const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
};

type VoiceRequest = {
  text?: string;
  voice?: string;
};

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

function sanitizeText(text: string) {
  return text.replace(/\s+/g, ' ').trim();
}

function resolveVoice(rawVoice?: string) {
  const allowedVoices = new Set([
    'alloy',
    'ash',
    'ballad',
    'coral',
    'nova',
    'sage',
  ]);

  if (rawVoice && allowedVoices.has(rawVoice)) {
    return rawVoice;
  }

  return 'sage';
}

function arrayBufferToBase64(buffer: ArrayBuffer) {
  const bytes = new Uint8Array(buffer);
  let binary = '';
  const chunkSize = 0x8000;

  for (let index = 0; index < bytes.length; index += chunkSize) {
    const chunk = bytes.subarray(index, index + chunkSize);
    binary += String.fromCharCode(...chunk);
  }

  return btoa(binary);
}

Deno.serve(async (request) => {
  if (request.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const body = (await request.json()) as VoiceRequest;
    const text = sanitizeText(body.text ?? '');
    const voice = resolveVoice(body.voice);

    if (!text) {
      return jsonResponse({ error: 'Text is required.' }, 400);
    }

    const openAiApiKey = Deno.env.get('OPENAI_API_KEY');
    if (!openAiApiKey) {
      return jsonResponse(
        { error: 'OPENAI_API_KEY is missing from Supabase function secrets.' },
        500,
      );
    }

    const response = await fetch('https://api.openai.com/v1/audio/speech', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${openAiApiKey}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini-tts',
        voice,
        input: text.slice(0, 3500),
        response_format: 'mp3',
        instructions:
          'Speak as a calm, natural founder educator. Sound warm, clear, intelligent, and conversational, not robotic or overly theatrical.',
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      return jsonResponse(
        {
          error: 'Voice synthesis failed.',
          details: errorText,
        },
        500,
      );
    }

    const audioBuffer = await response.arrayBuffer();
    const audioBase64 = arrayBufferToBase64(audioBuffer);

    return jsonResponse({
      audioBase64,
      mimeType: 'audio/mpeg',
      voice,
    });
  } catch (error) {
    return jsonResponse(
      {
        error: 'Founder voice function failed.',
        details: error instanceof Error ? error.message : String(error),
      },
      500,
    );
  }
});
