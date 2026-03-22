const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
};

type TutorRequest = {
  provider?: string;
  question?: string;
  projectName?: string;
  track?: string;
  stageTitle?: string;
  moduleTitle?: string;
  lessonTitle?: string;
  lessonSummary?: string;
  lessonConcept?: string;
  lessonWhyItMatters?: string;
  moduleTerms?: string[];
  lessonTerms?: string[];
  moduleNote?: string;
  todayLearningTask?: string;
  todayExecutionTask?: string;
  completedTaskCount?: number;
  overallProgress?: number;
};

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

function extractUrls(text: string) {
  return [...text.matchAll(/https?:\/\/[^\s)]+/g)].map((match) => match[0]);
}

function shouldSearchWeb(text: string) {
  return /(latest|recent|today|current|trend|trends|market|competitor|research|look up|find|search|review this page|analyze this page|analyze this link)/i.test(
    text,
  );
}

function cleanText(raw: string) {
  return raw.replace(/\s+/g, ' ').trim();
}

function htmlToText(html: string) {
  return cleanText(
    html
      .replace(/<script[\s\S]*?<\/script>/gi, ' ')
      .replace(/<style[\s\S]*?<\/style>/gi, ' ')
      .replace(/<noscript[\s\S]*?<\/noscript>/gi, ' ')
      .replace(/<\/(p|div|h1|h2|h3|h4|li|section|article|br)>/gi, '\n')
      .replace(/<[^>]+>/g, ' ')
      .replace(/&nbsp;/g, ' ')
      .replace(/&amp;/g, '&')
      .replace(/&quot;/g, '"')
      .replace(/&#39;/g, "'"),
  );
}

async function fetchUrlContext(url: string) {
  try {
    const response = await fetch(url, {
      headers: {
        'User-Agent':
          'Mozilla/5.0 (compatible; FounderOSBot/1.0; +https://tmclyyvzbufxezlxcifl.supabase.co)',
      },
    });
    const html = await response.text();
    const text = htmlToText(html).slice(0, 4000);
    return {
      url,
      ok: response.ok,
      status: response.status,
      text,
    };
  } catch (error) {
    return {
      url,
      ok: false,
      status: 0,
      text: `Fetch failed: ${error instanceof Error ? error.message : String(error)}`,
    };
  }
}

async function searchWeb(query: string) {
  try {
    const url = `https://html.duckduckgo.com/html/?q=${encodeURIComponent(query)}`;
    const response = await fetch(url, {
      headers: {
        'User-Agent':
          'Mozilla/5.0 (compatible; FounderOSBot/1.0; +https://tmclyyvzbufxezlxcifl.supabase.co)',
      },
    });
    const html = await response.text();
    const matches = [...html.matchAll(/result__a.*?href="([^"]+)".*?>(.*?)<\/a>/gsi)]
      .slice(0, 5)
      .map((match) => {
        const rawUrl = match[1];
        const title = cleanText(match[2].replace(/<[^>]+>/g, ' '));
        const decodedUrl = rawUrl.startsWith('//') ? `https:${rawUrl}` : rawUrl;
        return { title, url: decodedUrl };
      });

    return matches;
  } catch (error) {
    return [
      {
        title: `Search failed: ${error instanceof Error ? error.message : String(error)}`,
        url: '',
      },
    ];
  }
}

async function callOpenAi(
  apiKey: string,
  systemPrompt: string,
  userPrompt: string,
) {
  const response = await fetch('https://api.openai.com/v1/responses', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: 'gpt-4.1-mini',
      input: [
        {
          role: 'system',
          content: [{ type: 'input_text', text: systemPrompt }],
        },
        {
          role: 'user',
          content: [{ type: 'input_text', text: userPrompt }],
        },
      ],
      max_output_tokens: 900,
    }),
  });

  const payload = await response.json();
  if (!response.ok) {
    throw new Error(`OpenAI request failed: ${JSON.stringify(payload)}`);
  }

  return (
    payload?.output_text ??
    payload?.output?.flatMap((item: any) => item.content ?? [])?.find(
      (item: any) => item.type === 'output_text',
    )?.text ??
    ''
  );
}

async function callGemini(
  apiKey: string,
  systemPrompt: string,
  userPrompt: string,
) {
  const response = await fetch(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent',
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': apiKey,
      },
      body: JSON.stringify({
        system_instruction: {
          parts: [{ text: systemPrompt }],
        },
        contents: [
          {
            role: 'user',
            parts: [{ text: userPrompt }],
          },
        ],
      }),
    },
  );

  const payload = await response.json();
  if (!response.ok) {
    throw new Error(`Gemini request failed: ${JSON.stringify(payload)}`);
  }

  return payload?.candidates?.[0]?.content?.parts
    ?.map((part: any) => part?.text ?? '')
    .join('')
    .trim();
}

Deno.serve(async (request) => {
  if (request.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const body = (await request.json()) as TutorRequest;
    const provider = body.provider === 'gemini' ? 'gemini' : 'openai';
    const question = body.question?.trim();

    if (!question) {
      return jsonResponse({ error: 'A question is required.' }, 400);
    }

    const systemPrompt = `
You are Founder OS Tutor, an in-app founder education tutor.

Your job:
- teach in plain English
- explain jargon the first time it appears
- answer like a rigorous but practical founder instructor
- tie every answer to the user's current module, current lesson, and current project
- prioritize reasoning, sequencing, judgment, and next-step clarity

Output rules:
- do not sound like marketing copy
- do not assume the user knows startup acronyms
- if you use a term like ICP, CAC, MVP, onboarding, funnel, or retention, define it inline
- answer in short sections with clear headers when helpful
- include: what it means, why it matters, and what to do next
- if the user seems confused, simplify rather than adding more jargon
- keep the answer specific to the current lesson and to the project context
- do not mention that you are an AI model
`.trim();

    const providerInstruction =
      provider === 'gemini'
        ? `
Additional style for Gemini mode:
- lean more practical, creative, and distribution-aware
- help with positioning, messaging, channels, campaigns, hooks, and content angles when relevant
- still explain the underlying founder logic in plain English
`.trim()
        : `
Additional style for OpenAI mode:
- lean more analytical, structured, and reasoning-heavy
- focus on decision quality, sequencing, tradeoffs, and judgment
`.trim();

    const linkedUrls = extractUrls(question);
    const fetchedContexts = await Promise.all(
      linkedUrls.slice(0, 3).map((url) => fetchUrlContext(url)),
    );
    const searchResults = shouldSearchWeb(question)
      ? await searchWeb(question)
      : [];

    const webContext = `
Internet context:
${searchResults.length > 0 ? `Search results:\n${searchResults
      .map((entry, index) => `${index + 1}. ${entry.title} ${entry.url}`.trim())
      .join('\n')}` : 'Search results: none'}

${fetchedContexts.length > 0 ? `Fetched links:\n${fetchedContexts
      .map(
        (entry, index) =>
          `${index + 1}. ${entry.url}\nStatus: ${entry.status}\nExtracted text: ${entry.text}`,
      )
      .join('\n\n')}` : 'Fetched links: none'}
`.trim();

    const userPrompt = `
Provider mode: ${provider}
Project: ${body.projectName ?? 'Unknown project'}
Track: ${body.track ?? 'Unknown track'}
Current stage: ${body.stageTitle ?? 'Unknown stage'}
Current module: ${body.moduleTitle ?? 'Unknown module'}
Current lesson: ${body.lessonTitle ?? 'Unknown lesson'}

Lesson summary:
${body.lessonSummary ?? ''}

Lesson concept:
${body.lessonConcept ?? ''}

Why this lesson matters:
${body.lessonWhyItMatters ?? ''}

Module terms:
${(body.moduleTerms ?? []).join(', ')}

Lesson terms:
${(body.lessonTerms ?? []).join(', ')}

Current module note:
${body.moduleNote ?? ''}

Today's learning task:
${body.todayLearningTask ?? ''}

Today's execution task:
${body.todayExecutionTask ?? ''}

Completed tasks:
${body.completedTaskCount ?? 0}

Overall progress:
${((body.overallProgress ?? 0) * 100).toFixed(1)}%

${webContext}

User question:
${question}
`.trim();

    const fullSystemPrompt = `${systemPrompt}\n\n${providerInstruction}`;

    let answer = '';
    if (provider === 'gemini') {
      const geminiApiKey = Deno.env.get('GEMINI_API_KEY');
      if (!geminiApiKey) {
        return jsonResponse(
          { error: 'GEMINI_API_KEY is missing from Supabase function secrets.' },
          500,
        );
      }
      answer = await callGemini(geminiApiKey, fullSystemPrompt, userPrompt);
    } else {
      const openAiApiKey = Deno.env.get('OPENAI_API_KEY');
      if (!openAiApiKey) {
        return jsonResponse(
          { error: 'OPENAI_API_KEY is missing from Supabase function secrets.' },
          500,
        );
      }
      answer = await callOpenAi(openAiApiKey, fullSystemPrompt, userPrompt);
    }

    if (!answer || typeof answer !== 'string') {
      return jsonResponse(
        { error: `The ${provider} tutor did not return text.` },
        500,
      );
    }

    return jsonResponse({ answer, provider });
  } catch (error) {
    return jsonResponse(
      {
        error: 'Founder tutor function failed.',
        details: error instanceof Error ? error.message : String(error),
      },
      500,
    );
  }
});
