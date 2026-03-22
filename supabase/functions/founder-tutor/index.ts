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
  appUrl?: string;
  repoUrl?: string;
  conversationHistory?: Array<{ role?: string; text?: string }>;
};

type CommandModes = {
  appInspection: boolean;
  seo: boolean;
  hooks: boolean;
  dataAnalysis: boolean;
  competitorReview: boolean;
  generate: boolean;
  search: boolean;
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
  return /(latest|recent|today|current|trend|trends|market|competitor|research|look up|find|search|review this page|analyze this page|analyze this link|seo|hook|headline|copy|analyze data|app review|review my app|search my app|compare my app)/i.test(
    text,
  );
}

function detectCommandModes(text: string): CommandModes {
  return {
    appInspection:
      /(my app|lunarwise|review my app|search my app|analyze my app|analyze my homepage|review my homepage|homepage|landing page|live app|site\b)/i.test(
        text,
      ),
    seo:
      /\bseo\b|search engine optimization|keyword|meta title|meta description|organic search|search rankings|technical seo/i.test(
        text,
      ),
    hooks:
      /hooks?\b|headline|headlines|angles?\b|ad copy|copy ideas|creative ideas|content ideas|positioning/i.test(
        text,
      ),
    dataAnalysis:
      /analy[sz]e (this )?data|dataset|csv|spreadsheet|table|numbers|metrics|funnel data|cohort|retention|conversion data/i.test(
        text,
      ),
    competitorReview:
      /competitor|competitors|compare|comparison|benchmark|alternatives?/i.test(
        text,
      ),
    generate:
      /generate|draft|write|create|produce/i.test(text),
    search:
      /search|find|look up|research|latest|recent|current/i.test(text),
  };
}

function safeUrl(value?: string) {
  if (!value) return '';
  try {
    return new URL(value).toString();
  } catch (_) {
    return '';
  }
}

function buildSearchQueries(
  question: string,
  projectName: string,
  appUrl: string,
  modes: CommandModes,
) {
  const queries = new Set<string>();
  queries.add(question);

  if (modes.appInspection || modes.search) {
    queries.add(`${projectName} app`);
  }

  if (modes.seo) {
    queries.add(`${projectName} SEO review`);
    queries.add(`${projectName} organic search competitors`);
  }

  if (modes.hooks) {
    queries.add(`${projectName} marketing positioning examples`);
  }

  if (modes.competitorReview) {
    queries.add(`${projectName} competitors alternatives`);
  }

  if (appUrl) {
    try {
      const parsed = new URL(appUrl);
      queries.add(`site:${parsed.hostname} ${projectName}`);
    } catch (_) {
      // Ignore invalid app URL.
    }
  }

  return [...queries].slice(0, 4);
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

async function gatherSearchContext(queries: string[]) {
  const results = await Promise.all(queries.map((query) => searchWeb(query)));
  return queries.map((query, index) => ({
    query,
    results: results[index],
  }));
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
You are Founder OS Tutor, an in-app founder education tutor and execution agent.

Your job:
- teach in plain English
- explain jargon the first time it appears
- answer like a rigorous but practical founder instructor
- tie every answer to the user's current module, current lesson, and current project
- prioritize reasoning, sequencing, judgment, and next-step clarity
- when the user gives a command, execute the command with the provided tools and inspected context before teaching
- treat "my app" as the user's deployed app URL when available
- treat "my repo" as the linked GitHub repository when available

Output rules:
- do not sound like marketing copy
- do not assume the user knows startup acronyms
- if you use a term like ICP, CAC, MVP, onboarding, funnel, or retention, define it inline
- answer in short sections with clear headers when helpful
- include: what it means, why it matters, and what to do next
- if the user seems confused, simplify rather than adding more jargon
- keep the answer specific to the current lesson and to the project context
- do not mention that you are an AI model
- do not ignore command words like search, review, analyze, audit, compare, generate, or inspect
- if you inspected URLs or search results, say exactly what you inspected
- if the user asks for SEO, include: findings, why each issue matters, and prioritized fixes
- if the user asks for hooks or copy, produce multiple options instead of one
- if the user asks for data analysis, summarize assumptions, observed patterns, and recommended actions
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

    const modes = detectCommandModes(question);
    const appUrl = safeUrl(body.appUrl);
    const repoUrl = safeUrl(body.repoUrl);
    const linkedUrls = extractUrls(question);
    const fetchedUrlSet = new Set<string>(linkedUrls.slice(0, 3));

    if (modes.appInspection && appUrl) {
      fetchedUrlSet.add(appUrl);
    }

    if (
      /repo|repository|github|codebase|source code/i.test(question) &&
      repoUrl
    ) {
      fetchedUrlSet.add(repoUrl);
    }

    const fetchedContexts = await Promise.all(
      [...fetchedUrlSet].slice(0, 3).map((url) => fetchUrlContext(url)),
    );
    const searchContexts = shouldSearchWeb(question)
      ? await gatherSearchContext(
          buildSearchQueries(
            question,
            body.projectName ?? 'Unknown project',
            appUrl,
            modes,
          ),
        )
      : [];

    const conversationHistory = (body.conversationHistory ?? [])
      .map((turn) => ({
        role: turn.role === 'assistant' ? 'assistant' : 'user',
        text: cleanText(turn.text ?? ''),
      }))
      .filter((turn) => turn.text.length > 0)
      .slice(-8);

    const webContext = `
Internet context:
${searchContexts.length > 0 ? `Search results:\n${searchContexts
      .map(
        (context, index) =>
          `${index + 1}. Query: ${context.query}\n${context.results
            .map(
              (entry, entryIndex) =>
                `  ${entryIndex + 1}. ${entry.title} ${entry.url}`.trim(),
            )
            .join('\n')}`,
      )
      .join('\n\n')}` : 'Search results: none'}

${fetchedContexts.length > 0 ? `Fetched links:\n${fetchedContexts
      .map(
        (entry, index) =>
          `${index + 1}. ${entry.url}\nStatus: ${entry.status}\nExtracted text: ${entry.text}`,
      )
      .join('\n\n')}` : 'Fetched links: none'}
`.trim();

    const commandContext = `
Command routing:
- appInspection: ${modes.appInspection}
- seo: ${modes.seo}
- hooks: ${modes.hooks}
- dataAnalysis: ${modes.dataAnalysis}
- competitorReview: ${modes.competitorReview}
- generate: ${modes.generate}
- search: ${modes.search}

Known app URL:
${appUrl || 'none'}

Known repo URL:
${repoUrl || 'none'}
`.trim();

    const historyContext = `
Recent conversation:
${conversationHistory.length > 0 ? conversationHistory
      .map((turn) => `${turn.role.toUpperCase()}: ${turn.text}`)
      .join('\n\n') : 'No prior turns.'}
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

${commandContext}

${historyContext}

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
