import 'package:flutter/material.dart';

import '../models/founder_models.dart';

class SeedContent {
  const SeedContent._();

  static FounderSeedData build() {
    return FounderSeedData(
      modules: _modules,
      stages: _stages,
      glossary: _glossary,
      frameworks: _frameworks,
    );
  }

  static const List<Module> _modules = [
    Module(
      id: 'start-here',
      title: 'Start Here / Founder Overview',
      telemetry: 'ORIENTATION',
      icon: Icons.school_outlined,
      explanation:
          'Start here if you need the big picture first. This module explains what a founder is actually doing, why this course is structured in stages, and how products become businesses.',
      whyItMatters:
          'If the overall founder process is not clear, every later lesson feels like disconnected jargon. This module gives you the map before the tactics.',
      keyTerms: [
        'Founder',
        'Startup',
        'Business model',
        'MVP',
        'Customer development',
        'Distribution',
        'Monetization',
        'Signal',
        'Bottleneck',
      ],
      lessons: [
        Lesson(
          id: 'sh-1',
          title: 'What this course is actually teaching',
          summary:
              'This course teaches the process of turning uncertainty into a product and a business, not just building software.',
          battleTask:
              'Write, in your own words, what a founder is trying to accomplish beyond “building an app.”',
        ),
        Lesson(
          id: 'sh-2',
          title: 'The standard founder sequence from problem to sale',
          summary:
              'Founders learn faster when they solve questions in the right order: problem, buyer, offer, build, distribution, conversion, monetization, then systems.',
          battleTask:
              'Write the founder sequence in order and circle the stage you believe you are in right now.',
        ),
        Lesson(
          id: 'sh-3',
          title: 'How a product becomes a business',
          summary:
              'A product becomes a business only when value creation, discovery, conversion, and monetization all connect.',
          battleTask:
              'Describe how your current idea would create value, reach a buyer, and make money.',
        ),
        Lesson(
          id: 'sh-4',
          title: 'How to use this course like an accelerated founder MBA',
          summary:
              'The point is not jargon memorization. The point is to build judgment about what matters, when it matters, and why.',
          battleTask:
              'Write down the three founder decisions you most need help making right now.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-sh-1',
          title: 'Read the course overview first',
          detail:
              'Use this module before jumping into specialized founder topics.',
        ),
        ChecklistTask(
          id: 'mod-sh-2',
          title: 'Identify your current founder stage',
          detail:
              'Pick the stage you are actually in, not the stage you wish you were in.',
        ),
        ChecklistTask(
          id: 'mod-sh-3',
          title: 'Write your current founder questions',
          detail:
              'Name the top three decisions or unknowns you need this course to help you answer.',
        ),
        ChecklistTask(
          id: 'mod-sh-4',
          title: 'Commit to learning in sequence',
          detail:
              'Do not skip straight to advanced topics without understanding the basics.',
        ),
      ],
      companyPatterns: [
        'Serious founders learn in stages instead of treating every business problem as equally urgent.',
        'Strong operators match their learning priorities to the current business bottleneck.',
        'Good startup education reduces uncertainty instead of just adding vocabulary.',
      ],
      soloFounderMisses: [
        'Starting with product features before understanding the founder process.',
        'Mistaking founder jargon for founder judgment.',
        'Jumping to growth or pricing before problem and buyer clarity exist.',
      ],
      resources: [
        ResourceLink(
          title: 'Steve Blank Customer Development Flow',
          url: 'https://steveblank.com/customer-development-flow/',
          type: 'Framework',
        ),
        ResourceLink(
          title: 'Y Combinator Library',
          url: 'https://www.ycombinator.com/library',
          type: 'Articles',
        ),
        ResourceLink(
          title: 'Paul Graham Essays',
          url: 'https://paulgraham.com/articles.html',
          type: 'Article',
        ),
      ],
      aiPrompts: [
        'Explain the founder process to me in plain English without jargon.',
        'Help me identify which founder stage I am actually in.',
        'Turn my current idea into a staged founder roadmap from problem to revenue.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'For SaaS, the founder process usually emphasizes recurring use, onboarding, retention, and subscription economics.',
          differs:
              'You are building an ongoing product relationship, not only a one-time transaction.',
          recommendedTask:
              'Write the recurring user behavior your SaaS must create to become valuable.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'For digital products, the founder process usually emphasizes offer clarity, fast conversion, delivery, and support boundaries.',
          differs:
              'You are often optimizing for a fast, single buying moment more than ongoing software adoption.',
          recommendedTask:
              'Write the exact result the buyer receives immediately after purchase.',
        ),
      },
    ),
    Module(
      id: 'problem-customer-offer',
      title: 'Problem / Customer / Offer',
      telemetry: 'FOUNDATION',
      icon: Icons.track_changes_outlined,
      explanation:
          'Clarify the painful problem, the user who feels it, and the offer that makes the problem worth solving now.',
      whyItMatters:
          'Most founder confusion starts here. If the pain, buyer, and promise stay fuzzy, everything downstream gets expensive.',
      keyTerms: [
        'ICP',
        'Pain intensity',
        'Value proposition',
        'Demand validation',
        'Offer wedge',
      ],
      lessons: [
        Lesson(
          id: 'pco-1',
          title: 'Find the expensive pain',
          summary:
              'A useful problem is painful, recurring, and already costing the customer time, money, status, or stress.',
          battleTask:
              'Write one sentence that starts with: "People lose ___ because ___."',
        ),
        Lesson(
          id: 'pco-2',
          title: 'Define the ideal customer profile (ICP) narrowly',
          summary:
              'Pick one specific user segment with clear context instead of describing a broad market.',
          battleTask:
              'Describe your target user by role, moment, current workaround, and urgency.',
        ),
        Lesson(
          id: 'pco-3',
          title: 'Make the offer tangible',
          summary:
              'Users buy outcomes, not features. State the before, after, and the mechanism clearly.',
          battleTask:
              'Draft a headline with user, outcome, and time-to-value in one line.',
        ),
        Lesson(
          id: 'pco-4',
          title: 'Validate before building more',
          summary:
              'Validation means collecting reactions tied to real intent, not just polite encouragement.',
          battleTask:
              'Run five user conversations and ask what they do today to solve this problem.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-pco-1',
          title: 'Write a one-sentence problem statement',
          detail:
              'Keep it concrete enough that a stranger could repeat it back accurately.',
        ),
        ChecklistTask(
          id: 'mod-pco-2',
          title: 'Name the first ideal customer profile (ICP) to serve',
          detail:
              'Role, company type, moment of need, and why urgency exists now.',
        ),
        ChecklistTask(
          id: 'mod-pco-3',
          title: 'List the current workaround',
          detail:
              'Workarounds show whether a user already values a solution enough to act.',
        ),
        ChecklistTask(
          id: 'mod-pco-4',
          title: 'Draft a value proposition',
          detail:
              'State what changes for the user and why your offer is more credible or faster.',
        ),
        ChecklistTask(
          id: 'mod-pco-5',
          title: 'Collect five validation conversations',
          detail: 'Capture language, objections, and buying triggers in notes.',
        ),
        ChecklistTask(
          id: 'mod-pco-6',
          title: 'Define one promise you can prove',
          detail:
              'Use a result, timeframe, or measurable shift instead of vague marketing words.',
        ),
      ],
      companyPatterns: [
        'Teams often run structured user research before they write a roadmap.',
        'Strong companies reuse exact customer language in positioning and onboarding.',
        'Winning offers are framed around a job-to-be-done, not a generic product category.',
      ],
      soloFounderMisses: [
        'Talking to peers instead of buyers.',
        'Calling curiosity "validation" before any action happens.',
        'Trying to serve too many buyer types on the first pass.',
      ],
      resources: [
        ResourceLink(
          title: 'Y Combinator Library',
          url: 'https://www.ycombinator.com/library',
          type: 'Articles',
        ),
        ResourceLink(
          title: 'Strategyzer Value Proposition Resources',
          url: 'https://www.strategyzer.com/library',
          type: 'Framework',
        ),
        ResourceLink(
          title: 'Jobs To Be Done overview',
          url: 'https://www.intercom.com/blog/jobs-to-be-done/',
          type: 'Article',
        ),
      ],
      aiPrompts: [
        'Audit my offer based on this target user, their current workaround, and the main pain I described.',
        'Rewrite this value proposition so it is clearer, narrower, and outcome-based.',
        'Generate ten interview questions that expose urgency, budget, and timing.',
        'Tell me whether this sounds like a nice-to-have or a must-solve problem and explain why.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'For SaaS, prioritize recurring pain, repeated usage, and a workflow that users will return to weekly or daily.',
          differs:
              'Your offer should promise speed, visibility, or automation inside an ongoing workflow, not a one-time deliverable.',
          recommendedTask:
              'Map the user action that should repeat at least three times per month.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'For digital products, prioritize a fast result, clear transformation, and a low-friction buying moment.',
          differs:
              'The product wins when buyers understand the result quickly and can apply it with little handholding.',
          recommendedTask:
              'Define the exact artifact the buyer receives and the result it should create in week one.',
        ),
      },
    ),
    Module(
      id: 'product-stack-build',
      title: 'Product / Stack / Build',
      telemetry: 'SYSTEMS',
      icon: Icons.developer_mode_outlined,
      explanation:
          'Choose a stack that gets you to a working product quickly without burying yourself in architecture debt.',
      whyItMatters:
          'A good MVP stack is boring, fast, documented, and easy to change. Overbuilding here slows learning everywhere else.',
      keyTerms: [
        'Frontend',
        'Backend',
        'API',
        'Database',
        'Hosting',
        'Deployment',
      ],
      lessons: [
        Lesson(
          id: 'psb-1',
          title: 'Pick the simplest reliable stack',
          summary:
              'Stack choice should follow product constraints, not trends. Use what helps you ship and debug fastest.',
          battleTask:
              'Write the minimum pieces your product actually needs to work end-to-end.',
        ),
        Lesson(
          id: 'psb-2',
          title: 'Know the app layers',
          summary:
              'Frontend handles interface, backend handles logic, APIs connect systems, and the database stores source-of-truth data.',
          battleTask:
              'Map one user action from button tap to saved record in plain English.',
        ),
        Lesson(
          id: 'psb-3',
          title: 'Optimize for MVP, not scale theater',
          summary:
              'A clean deploy path and simple data model beat a fancy service map for an early product.',
          battleTask:
              'Remove one feature or layer that exists only because it might matter later.',
        ),
        Lesson(
          id: 'psb-4',
          title: 'Ship with deployment discipline',
          summary:
              'The best learning comes from software that is running somewhere, not from software that is nearly ready.',
          battleTask:
              'Document your deploy flow from local dev to production in six steps or fewer.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-psb-1',
          title: 'Choose frontend, backend, and hosting',
          detail:
              'Pick tools with documentation you can actually use when stuck.',
        ),
        ChecklistTask(
          id: 'mod-psb-2',
          title: 'Write the MVP feature boundary',
          detail:
              'List what must ship in v1 and what is intentionally deferred.',
        ),
        ChecklistTask(
          id: 'mod-psb-3',
          title: 'Map the core data objects',
          detail:
              'Write the records you need before you start adding tables or collections.',
        ),
        ChecklistTask(
          id: 'mod-psb-4',
          title: 'Set up a deploy target',
          detail:
              'Make production or preview deployment routine instead of scary.',
        ),
        ChecklistTask(
          id: 'mod-psb-5',
          title: 'Add environment variables',
          detail:
              'No keys in code. Store secrets outside the repository from day one.',
        ),
        ChecklistTask(
          id: 'mod-psb-6',
          title: 'Document the setup locally',
          detail:
              'Future-you should be able to reinstall or debug the app without guessing.',
        ),
      ],
      companyPatterns: [
        'Mature teams design around one or two critical user journeys first.',
        'Healthy engineering orgs keep deploy paths scripted and repeatable.',
        'Good products narrow the v1 scope enough to reach real usage quickly.',
      ],
      soloFounderMisses: [
        'Picking tools because they look sophisticated.',
        'Creating more services than the product needs.',
        'Ignoring deploy setup until launch week.',
      ],
      resources: [
        ResourceLink(
          title: 'Flutter docs',
          url: 'https://docs.flutter.dev/',
          type: 'Docs',
        ),
        ResourceLink(
          title: 'Vercel deployment docs',
          url: 'https://vercel.com/docs',
          type: 'Docs',
        ),
        ResourceLink(
          title: 'Supabase architecture guides',
          url: 'https://supabase.com/docs/guides',
          type: 'Docs',
        ),
      ],
      aiPrompts: [
        'Help me choose the lightest stack for this product and these constraints.',
        'Audit this architecture for unnecessary complexity in an MVP.',
        'Turn this feature list into a strict v1 scope and a later backlog.',
        'Explain the API, database, and hosting pieces of this app in plain language.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'SaaS products need a repeatable user workflow, account states, and a clean path to reliable onboarding.',
          differs:
              'You should plan for user identity, session handling, and recurring product use even if the initial build stays lean.',
          recommendedTask:
              'Document the single repeatable user workflow that proves retention.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'Digital products need fulfillment, delivery, update handling, and support boundaries more than complex application logic.',
          differs:
              'The stack can stay lighter if the buyer mostly downloads, duplicates, or installs a packaged asset.',
          recommendedTask:
              'Write the exact flow from purchase to delivery to buyer success.',
        ),
      },
    ),
    Module(
      id: 'security-reliability',
      title: 'Security / Reliability',
      telemetry: 'RISK',
      icon: Icons.shield_outlined,
      explanation:
          'Protect secrets, user data, and core operations before you scale problems into emergencies.',
      whyItMatters:
          'Security failures hurt trust fast. Early reliability habits also reduce launch-day chaos.',
      keyTerms: [
        'Environment variables',
        'Least privilege',
        'Auth safety',
        'Backups',
        'Privacy',
        'Compliance basics',
      ],
      lessons: [
        Lesson(
          id: 'sr-1',
          title: 'Protect secrets from day one',
          summary:
              'API keys and service tokens should live in environment variables or secure secret stores, never in code or screenshots.',
          battleTask:
              'List every secret your product uses and where each one is stored.',
        ),
        Lesson(
          id: 'sr-2',
          title: 'Design for least privilege',
          summary:
              'Give each system only the access it needs. Most founder breaches start with broad permissions and weak boundaries.',
          battleTask:
              'Review one integration and reduce access to only the required scope.',
        ),
        Lesson(
          id: 'sr-3',
          title: 'Reliability is a product feature',
          summary:
              'Backups, logs, and graceful failures matter more than edge-case polish in v1.',
          battleTask:
              'Write the top three ways your app could fail and how you would detect them.',
        ),
        Lesson(
          id: 'sr-4',
          title: 'Privacy can become your moat',
          summary:
              'If your users share sensitive data, local-first storage and minimal data transfer can become a trust advantage.',
          battleTask:
              'Mark which data truly needs to leave the device and which should stay local.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-sr-1',
          title: 'Move all secrets into environment variables',
          detail:
              'Check local files, deployment settings, and docs for stray keys.',
        ),
        ChecklistTask(
          id: 'mod-sr-2',
          title: 'Review auth and admin privileges',
          detail:
              'Make sure users and services only get access they actually need.',
        ),
        ChecklistTask(
          id: 'mod-sr-3',
          title: 'Create a backup plan',
          detail:
              'Know what data is backed up, how often, and how you would restore it.',
        ),
        ChecklistTask(
          id: 'mod-sr-4',
          title: 'Write a basic privacy statement',
          detail:
              'State what you collect, why you collect it, and what stays local.',
        ),
        ChecklistTask(
          id: 'mod-sr-5',
          title: 'Set up monitoring or logs',
          detail: 'You need a way to know when core functionality breaks.',
        ),
        ChecklistTask(
          id: 'mod-sr-6',
          title: 'Document the top founder risks',
          detail:
              'Include leaked keys, broken auth, data loss, and third-party outages.',
        ),
      ],
      companyPatterns: [
        'Teams routinely separate dev, staging, and production credentials.',
        'Healthy systems treat backups and recovery as standard operating procedure.',
        'Good operators write down data handling rules before they need to defend them.',
      ],
      soloFounderMisses: [
        'Leaving keys in screenshots, repos, or exported config files.',
        'Using admin credentials everywhere to save time.',
        'Assuming small products are too small to be attacked.',
      ],
      resources: [
        ResourceLink(
          title: 'OWASP Top 10',
          url: 'https://owasp.org/www-project-top-ten/',
          type: 'Security',
        ),
        ResourceLink(
          title: 'Google Secret Manager overview',
          url: 'https://cloud.google.com/security/products/secret-manager',
          type: 'Docs',
        ),
        ResourceLink(
          title: 'Supabase security guides',
          url: 'https://supabase.com/docs/guides/platform/security',
          type: 'Docs',
        ),
      ],
      aiPrompts: [
        'What security risks am I missing in this stack and launch setup?',
        'Review my secrets handling plan and point out weak spots.',
        'Help me write a plain-English privacy summary for this app.',
        'Create a simple reliability checklist for a solo founder shipping v1.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'For SaaS, reliability drives retention. Broken onboarding, auth bugs, or sync issues directly destroy trust and redownload velocity.',
          differs:
              'You need stronger attention on auth, permissions, monitoring, and uptime because the user relationship is ongoing.',
          recommendedTask:
              'Audit login, password reset, and session expiry flows before launch.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'For digital products, security is mostly about asset delivery, buyer access, licensing clarity, and preventing support chaos.',
          differs:
              'Risk shifts from ongoing uptime to file delivery, version control, and protecting commercial rights.',
          recommendedTask:
              'Define who gets access to files, updates, and support across license tiers.',
        ),
      },
    ),
    Module(
      id: 'distribution-marketing',
      title: 'Distribution / Marketing',
      telemetry: 'TRAFFIC',
      icon: Icons.campaign_outlined,
      explanation:
          'Learn where attention already exists and how to intercept it with the right message, asset, and experiment loop.',
      whyItMatters:
          'A strong product without distribution still looks like failure. Distribution decides whether the market ever sees your work.',
      keyTerms: [
        'AEO',
        'ASO',
        'Organic loops',
        'Creative testing',
        'Attribution',
        'Signal vs noise',
      ],
      lessons: [
        Lesson(
          id: 'dm-1',
          title:
              'Answer engine optimization (AEO) beats generic SEO for solo operators',
          summary:
              'Answer engines surface pages that clearly state who they help, what they do, and why they are relevant in direct language.',
          battleTask:
              'Audit your first 100 landing-page words for explicit user, outcome, and use case clarity.',
        ),
        Lesson(
          id: 'dm-2',
          title: 'Pick channels by stage, not ego',
          summary:
              'At each stage, the right channel is the one that teaches you fastest, not the one that looks biggest from the outside.',
          battleTask:
              'Choose one primary channel and one supporting channel for the next two weeks.',
        ),
        Lesson(
          id: 'dm-3',
          title: 'Creative tests need a loop',
          summary:
              'Hooks, landing pages, and offers should change based on real response data rather than taste.',
          battleTask:
              'Write three testable hooks for the same offer aimed at the same user.',
        ),
        Lesson(
          id: 'dm-4',
          title: 'Retention changes acquisition economics',
          summary:
              'Leaky onboarding kills paid and organic growth because weak product experience poisons downstream ranking and word-of-mouth.',
          battleTask:
              'Identify the first point where new users lose momentum after arriving.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-dm-1',
          title: 'Write an AEO-friendly landing page intro',
          detail:
              'State audience, result, and context with no vague brand language.',
        ),
        ChecklistTask(
          id: 'mod-dm-2',
          title: 'Choose one stage-appropriate channel',
          detail:
              'Do not spread yourself across five channels before one works.',
        ),
        ChecklistTask(
          id: 'mod-dm-3',
          title: 'Create three creative hooks',
          detail:
              'Each hook should promise the same result from a different angle.',
        ),
        ChecklistTask(
          id: 'mod-dm-4',
          title: 'Track top-line signal',
          detail:
              'Capture impressions, clicks, visits, leads, installs, or replies depending on the offer.',
        ),
        ChecklistTask(
          id: 'mod-dm-5',
          title: 'Decide what metric matters now',
          detail:
              'Avoid vanity metrics by naming the current stage metric explicitly.',
        ),
        ChecklistTask(
          id: 'mod-dm-6',
          title: 'Review traffic quality weekly',
          detail: 'A lot of attention from the wrong user is still failure.',
        ),
      ],
      companyPatterns: [
        'Strong teams match messaging, creative, and landing pages tightly.',
        'Good growth systems choose one learning metric per stage and optimize around it.',
        'Serious operators run repeated experiments with consistent documentation.',
      ],
      soloFounderMisses: [
        'Posting everywhere without a learning loop.',
        'Changing audience, offer, and creative at the same time.',
        'Confusing attention with qualified demand.',
      ],
      resources: [
        ResourceLink(
          title: 'Google Search Central',
          url: 'https://developers.google.com/search',
          type: 'Docs',
        ),
        ResourceLink(
          title: 'Apple App Store marketing resources',
          url: 'https://developer.apple.com/app-store/',
          type: 'Docs',
        ),
        ResourceLink(
          title: 'Meta Ads guide',
          url: 'https://www.facebook.com/business/ads',
          type: 'Guide',
        ),
      ],
      aiPrompts: [
        'Audit my landing page for AI readability and answer-engine clarity.',
        'Suggest three channel tests based on my stage, offer, and budget.',
        'Rewrite this ad hook for a colder audience with stronger specificity.',
        'Help me separate real signal from noise in these traffic metrics.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'For SaaS, focus on answer-engine visibility, retention-aware acquisition, and app or onboarding assets that convert ongoing use.',
          differs:
              'Distribution depends on trust, product clarity, and retention. OEM placement, app listing quality, and post-click experience matter more.',
          recommendedTask:
              'Review your install or signup path for the exact point where redownload or retention would collapse.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'For digital products, focus on result-based positioning, programmatic niche pages, and fast conversion on a single buying session.',
          differs:
              'You are selling an immediate outcome rather than long-term retention, so niche landing pages and offer clarity matter more than recurring usage.',
          recommendedTask:
              'Write three niche landing page concepts that sell the same product to different buyer contexts.',
        ),
      },
    ),
    Module(
      id: 'funnel-conversion',
      title: 'Funnel / Conversion',
      telemetry: 'FLOW',
      icon: Icons.filter_alt_outlined,
      explanation:
          'Track how attention becomes action, where friction appears, and which message or step needs repair.',
      whyItMatters:
          'If people show interest but do not move forward, the bottleneck is rarely solved by more traffic alone.',
      keyTerms: [
        'Install rate',
        'Signup rate',
        'Trial conversion',
        'Onboarding',
        'Friction point',
        'Paywall',
      ],
      lessons: [
        Lesson(
          id: 'fc-1',
          title: 'Map the funnel end-to-end',
          summary:
              'Every funnel has stages where people hesitate, get confused, or lose trust. You need the sequence before you can diagnose it.',
          battleTask:
              'Write your current funnel as a sequence of six steps or fewer.',
        ),
        Lesson(
          id: 'fc-2',
          title: 'Fix message matching first',
          summary:
              'The ad, landing page, onboarding, and paywall must promise the same result or people will bounce.',
          battleTask:
              'Compare your traffic source promise against your first screen and note any mismatch.',
        ),
        Lesson(
          id: 'fc-3',
          title: 'Reduce friction before adding features',
          summary:
              'Shorter forms, clearer copy, and better defaults often outperform new functionality in early conversion work.',
          battleTask:
              'Identify one screen where the user has to think harder than necessary.',
        ),
        Lesson(
          id: 'fc-4',
          title: 'Onboarding must create momentum',
          summary:
              'A new user needs a quick win or a clear path to one. Confusion in the first session is expensive.',
          battleTask:
              'Define the first success event a new user should hit within the first five minutes.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-fc-1',
          title: 'Document the funnel stages',
          detail:
              'Name each step from first impression to value moment or payment.',
        ),
        ChecklistTask(
          id: 'mod-fc-2',
          title: 'Check message alignment',
          detail:
              'Make sure ad, landing page, onboarding, and offer say the same thing.',
        ),
        ChecklistTask(
          id: 'mod-fc-3',
          title: 'Remove one friction point',
          detail:
              'Shorten, clarify, or prefill one step that slows users down.',
        ),
        ChecklistTask(
          id: 'mod-fc-4',
          title: 'Define the first success event',
          detail: 'Know exactly what counts as an activated user.',
        ),
        ChecklistTask(
          id: 'mod-fc-5',
          title: 'Review trial or payment handoff',
          detail:
              'Make the pricing transition feel consistent with earlier promises.',
        ),
        ChecklistTask(
          id: 'mod-fc-6',
          title: 'Track one conversion metric weekly',
          detail:
              'Focus on the stage with the highest leverage instead of every rate at once.',
        ),
      ],
      companyPatterns: [
        'Teams obsess over the first success event because it predicts downstream retention or conversion.',
        'Good funnels remove cognitive load before they add persuasion.',
        'Strong growth work changes one variable at a time.',
      ],
      soloFounderMisses: [
        'Sending paid traffic into an untested onboarding flow.',
        'Changing the offer without checking where drop-off actually happens.',
        'Letting the landing page promise one thing while the product shows another.',
      ],
      resources: [
        ResourceLink(
          title: 'App onboarding guidance',
          url: 'https://developer.apple.com/design/human-interface-guidelines/',
          type: 'Design',
        ),
        ResourceLink(
          title: 'Google Analytics conversion guides',
          url: 'https://support.google.com/analytics',
          type: 'Docs',
        ),
        ResourceLink(
          title: 'Reforge essays',
          url: 'https://www.reforge.com/blog',
          type: 'Articles',
        ),
      ],
      aiPrompts: [
        'Diagnose my funnel from these metrics and tell me where the real bottleneck is.',
        'Rewrite this onboarding sequence to create a faster first success event.',
        'Suggest three low-effort experiments to improve this conversion step.',
        'Tell me whether this is a traffic problem, a messaging problem, or a product friction problem.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'SaaS funnel work should optimize install or signup through activation, trial, and paid conversion with retention in mind.',
          differs:
              'Your first success event must make the user believe repeated use is worthwhile, not just that the app looks interesting.',
          recommendedTask:
              'Define the event that best predicts a retained SaaS user.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'Digital product conversion focuses on page clarity, trust, price framing, and making the buyer confident in a single session.',
          differs:
              'There is less onboarding after purchase, so the pre-purchase funnel must do more explanatory work.',
          recommendedTask:
              'Rewrite the sales page to reduce the top three purchase objections.',
        ),
      },
    ),
    Module(
      id: 'monetization-pricing',
      title: 'Monetization / Pricing',
      telemetry: 'REVENUE',
      icon: Icons.attach_money_outlined,
      explanation:
          'Price the offer around outcomes, buying context, and how value is delivered over time.',
      whyItMatters:
          'Weak pricing can hide strong demand or create the wrong customer behavior. Monetization is part of product design.',
      keyTerms: [
        'Outcome-based pricing',
        'CAC',
        'Payback',
        'License tier',
        'Willingness to pay',
        'Price anchors',
      ],
      lessons: [
        Lesson(
          id: 'mp-1',
          title: 'Price the result, not your effort',
          summary:
              'Customers compare cost against the value of the outcome, not the number of hours or features you used to make it.',
          battleTask:
              'Write the financial, time, or emotional value your offer creates when it works.',
        ),
        Lesson(
          id: 'mp-2',
          title: 'Use the right model for the product',
          summary:
              'Subscription, one-time, licensing, and hybrid credit models each create different expectations and margins.',
          battleTask:
              'List the pricing models that fit your product behavior and eliminate the ones that do not.',
        ),
        Lesson(
          id: 'mp-3',
          title: 'Learn willingness to pay',
          summary:
              'Pricing conversations should expose urgency, alternatives, and what buyers compare your offer against.',
          battleTask:
              'Ask three prospects what makes this feel cheap, fair, or risky.',
        ),
        Lesson(
          id: 'mp-4',
          title: 'Pricing is a messaging test too',
          summary:
              'If users do not understand the value ladder, the issue may be framing, not just the number.',
          battleTask:
              'Draft a pricing table headline that explains who each tier is for.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-mp-1',
          title: 'Pick a default pricing model',
          detail: 'Match it to how value is delivered and consumed.',
        ),
        ChecklistTask(
          id: 'mod-mp-2',
          title: 'Define the buyer outcome',
          detail: 'State the concrete result that justifies payment.',
        ),
        ChecklistTask(
          id: 'mod-mp-3',
          title: 'Create a tier or package ladder',
          detail: 'Make each option feel intentional and easy to compare.',
        ),
        ChecklistTask(
          id: 'mod-mp-4',
          title: 'Pressure-test willingness to pay',
          detail:
              'Use interviews, preorders, or live offers instead of guessing.',
        ),
        ChecklistTask(
          id: 'mod-mp-5',
          title: 'Write pricing objections',
          detail:
              'Know why buyers would hesitate before you write your sales copy.',
        ),
        ChecklistTask(
          id: 'mod-mp-6',
          title: 'Name the key economics metric',
          detail:
              'Recurring products track payback and retention; one-time products track margin and support load.',
        ),
      ],
      companyPatterns: [
        'Good companies use pricing to steer buyers into the right package, not just maximize the headline number.',
        'Healthy businesses align price with delivery cost and support expectations.',
        'Winning teams revisit pricing as the offer gets clearer.',
      ],
      soloFounderMisses: [
        'Choosing the popular pricing model instead of the suitable one.',
        'Underpricing because the product still feels unfinished internally.',
        'Ignoring support cost when selling one-time products.',
      ],
      resources: [
        ResourceLink(
          title: 'Stripe pricing resources',
          url: 'https://stripe.com/resources/more',
          type: 'Pricing',
        ),
        ResourceLink(
          title: 'ProfitWell pricing articles',
          url: 'https://www.paddle.com/resources',
          type: 'Articles',
        ),
        ResourceLink(
          title: 'Demand Curve growth and pricing',
          url: 'https://www.demandcurve.com/playbooks',
          type: 'Playbooks',
        ),
      ],
      aiPrompts: [
        'Help me choose between subscription, one-time pricing, licensing, or a hybrid model for this offer.',
        'Audit this pricing table and tell me what feels confusing or weak.',
        'Suggest willingness-to-pay questions for my next customer interviews.',
        'Turn this offer into three pricing tiers with clear buyer fit.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'For SaaS, pricing should map to recurring value. Hybrid base-plus-credit models can fit products with variable compute or high-cost actions.',
          differs:
              'Retention, usage, and payback matter more because revenue depends on repeated value delivery over time.',
          recommendedTask:
              'Define the recurring action or outcome your customer keeps paying to access.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'For digital products, use tiered licensing and support boundaries to protect margin and match buyer intent.',
          differs:
              'The buyer cares about ownership, rights, and fit-for-use more than ongoing seats or feature unlocks.',
          recommendedTask:
              'Draft personal, commercial, and white-label license boundaries in plain English.',
        ),
      },
    ),
    Module(
      id: 'founder-operator-systems',
      title: 'Founder / Operator Systems',
      telemetry: 'CONTROL',
      icon: Icons.dashboard_customize_outlined,
      explanation:
          'Build routines for prioritization, weekly review, and experiments so your work compounds instead of scattering.',
      whyItMatters:
          'Solo founders lose more time to random work than to a lack of effort. Systems turn effort into learning.',
      keyTerms: [
        'Priority stack',
        'Experiment',
        'Bottleneck',
        'Weekly review',
        'Decision hygiene',
        'Operating cadence',
      ],
      lessons: [
        Lesson(
          id: 'fos-1',
          title: 'Work the bottleneck',
          summary:
              'Not all tasks matter equally. Progress accelerates when you identify the constraint that is currently limiting growth.',
          battleTask:
              'Write one sentence describing what is actually slowing progress this week.',
        ),
        Lesson(
          id: 'fos-2',
          title: 'Separate learning from building',
          summary:
              'Some work creates product output, and some work creates better decisions. You need both, but they should be intentional.',
          battleTask: 'Label today’s tasks as build, learn, or maintain.',
        ),
        Lesson(
          id: 'fos-3',
          title: 'Run experiments, not vibes',
          summary:
              'A good experiment has a hypothesis, a success metric, and a time box.',
          battleTask:
              'Turn one idea into a one-week test with a clear success condition.',
        ),
        Lesson(
          id: 'fos-4',
          title: 'Review the week honestly',
          summary:
              'Weekly review is where random effort gets turned into decisions for the next sprint.',
          battleTask:
              'Write what you built, what you learned, and what signal changed your next move.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-fos-1',
          title: 'Define the current bottleneck',
          detail:
              'Use plain language. If it is vague, it is probably not useful yet.',
        ),
        ChecklistTask(
          id: 'mod-fos-2',
          title: 'Write the top three priorities',
          detail: 'Everything else should support or wait behind these.',
        ),
        ChecklistTask(
          id: 'mod-fos-3',
          title: 'Create one experiment brief',
          detail: 'Include hypothesis, metric, and stop condition.',
        ),
        ChecklistTask(
          id: 'mod-fos-4',
          title: 'Run a weekly review',
          detail: 'Capture build output, learning, signal, and next focus.',
        ),
        ChecklistTask(
          id: 'mod-fos-5',
          title: 'List what to stop doing',
          detail: 'Removing distraction is part of execution.',
        ),
        ChecklistTask(
          id: 'mod-fos-6',
          title: 'Keep one live scoreboard',
          detail:
              'Choose the handful of metrics and statuses you actually need weekly.',
        ),
      ],
      companyPatterns: [
        'Effective teams define a weekly focus and a single accountable metric.',
        'Good operators write down hypotheses before they interpret outcomes.',
        'Healthy review rituals protect teams from repeating low-signal work.',
      ],
      soloFounderMisses: [
        'Switching priorities every day based on mood.',
        'Calling a task productive just because it felt difficult.',
        'Skipping review, then forgetting what was learned.',
      ],
      resources: [
        ResourceLink(
          title: 'Basecamp Shape Up',
          url: 'https://basecamp.com/shapeup',
          type: 'Book',
        ),
        ResourceLink(
          title: 'Paul Graham essays',
          url: 'https://paulgraham.com/articles.html',
          type: 'Essays',
        ),
        ResourceLink(
          title: 'Atlassian experiment guide',
          url:
              'https://www.atlassian.com/agile/project-management/experimentation',
          type: 'Guide',
        ),
      ],
      aiPrompts: [
        'Help me identify the real bottleneck from this week’s notes.',
        'Turn my task list into top-three priorities and a backlog.',
        'Write a one-week experiment plan for this growth or product idea.',
        'Review this weekly summary and tell me what I should stop doing.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'For SaaS, operator systems should protect roadmap discipline, growth experiments, and retention review.',
          differs:
              'Because the business compounds over time, you need recurring habits around activation, retention, and bug review.',
          recommendedTask:
              'Create a weekly scoreboard with activation, retention, and top product risks.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'For digital products, operator systems should track launch cadence, delivery quality, support load, and offer iteration.',
          differs:
              'Your business may move in launches or campaign bursts, so your review process should protect margin and prevent support sprawl.',
          recommendedTask:
              'Create a weekly scoreboard with offer views, sales, refunds, and support volume.',
        ),
      },
    ),
    Module(
      id: 'productized-services-templates',
      title: 'Productized Services / Templates',
      telemetry: 'OFFERS',
      icon: Icons.inventory_2_outlined,
      explanation:
          'Learn when one-time products, templates, or implementation-backed offers make more sense than recurring software.',
      whyItMatters:
          'A founder can create real cash flow with templates, dashboards, installations, and licensing before a full SaaS engine exists.',
      keyTerms: [
        'Template offer',
        'Scope boundary',
        'Licensing',
        'Implementation',
        'Support load',
        'White-label',
      ],
      lessons: [
        Lesson(
          id: 'pst-1',
          title: 'Know when a template beats SaaS',
          summary:
              'If the buyer mostly needs a proven asset, setup speed, and clear delivery, a template or productized service may be the better offer.',
          battleTask:
              'Write why your buyer may prefer a done-for-you asset over another software subscription.',
        ),
        Lesson(
          id: 'pst-2',
          title: 'Package the result clearly',
          summary:
              'The buyer should know exactly what is included, what setup looks like, and where support stops.',
          battleTask:
              'Write the deliverables, setup support, and non-included items in one list.',
        ),
        Lesson(
          id: 'pst-3',
          title: 'Licensing protects margin',
          summary:
              'Commercial rights, client use, and white-label rights should be priced separately instead of being blurred together.',
          battleTask:
              'Draft license boundaries for personal, client, and resale usage.',
        ),
        Lesson(
          id: 'pst-4',
          title: 'Prevent support hell',
          summary:
              'Documentation, onboarding assets, and explicit boundaries reduce one-off handholding that destroys margin.',
          battleTask:
              'List the top support requests you want to prevent with documentation or scope controls.',
        ),
      ],
      checklist: [
        ChecklistTask(
          id: 'mod-pst-1',
          title: 'Define the template outcome',
          detail: 'What does the buyer end up with after using this product?',
        ),
        ChecklistTask(
          id: 'mod-pst-2',
          title: 'Write scope boundaries',
          detail:
              'Be explicit about what setup, support, and customization are not included.',
        ),
        ChecklistTask(
          id: 'mod-pst-3',
          title: 'Create license tiers',
          detail:
              'Personal, commercial, and white-label should have different rights and price points.',
        ),
        ChecklistTask(
          id: 'mod-pst-4',
          title: 'Draft handoff documentation',
          detail:
              'Reduce repeat support by documenting setup and common issues.',
        ),
        ChecklistTask(
          id: 'mod-pst-5',
          title: 'Estimate support load',
          detail:
              'Know how much help the average buyer will need after purchase.',
        ),
        ChecklistTask(
          id: 'mod-pst-6',
          title: 'Decide if subcontracted support is needed',
          detail:
              'If you scale fulfillment, know who owns delivery and customer communication.',
        ),
      ],
      companyPatterns: [
        'Strong offers define exactly what the buyer receives and how long support lasts.',
        'Healthy template businesses use licensing to align price with buyer usage.',
        'Good operators document repeat support questions before they hire more help.',
      ],
      soloFounderMisses: [
        'Letting custom requests sneak into a standardized offer.',
        'Giving away commercial rights without pricing them.',
        'Underestimating setup and post-purchase questions.',
      ],
      resources: [
        ResourceLink(
          title: 'Shopify digital products guide',
          url: 'https://www.shopify.com/blog/digital-products',
          type: 'Guide',
        ),
        ResourceLink(
          title: 'Creative Commons licensing overview',
          url: 'https://creativecommons.org/share-your-work/',
          type: 'Licensing',
        ),
        ResourceLink(
          title: 'Gumroad creator resources',
          url: 'https://gumroad.com/blog',
          type: 'Articles',
        ),
      ],
      aiPrompts: [
        'Help me design a template offer with clear scope and buyer fit.',
        'Write licensing language for personal, commercial, and white-label use.',
        'Audit this template offer for support risks and margin leaks.',
        'Turn this custom service into a more productized package.',
      ],
      trackVariants: {
        TrackType.saas: TrackVariant(
          focus:
              'This module is secondary for SaaS founders, but it can still reveal lower-friction offer wedges, implementation packages, or revenue bridges.',
          differs:
              'Use it to explore whether service-backed onboarding, setup packages, or template add-ons improve monetization before full software maturity.',
          recommendedTask:
              'Consider whether a setup package or productized implementation could accelerate early revenue.',
        ),
        TrackType.digitalProduct: TrackVariant(
          focus:
              'This is a primary module for digital products. The offer must be sharp, bounded, license-aware, and easy to fulfill.',
          differs:
              'Your business quality depends on packaging, rights, and support boundaries more than long-term product retention.',
          recommendedTask:
              'Write the three clearest rules buyers must understand before purchasing.',
        ),
      },
    ),
  ];

  static const List<Stage> _stages = [
    Stage(
      id: 'idea-discovery',
      order: 1,
      title: 'Idea / Problem Discovery',
      telemetry: 'SCAN',
      meaning:
          'You are defining the real problem, who has it, and whether it is painful enough to deserve attention now.',
      successLooksLike:
          'You can explain the problem, buyer, and urgency without vague language.',
      commonMistakes: [
        'Falling in love with a feature before proving the problem.',
        'Talking to friends or peers instead of buyers.',
        'Trying to solve a broad market in one step.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-1-1',
          title: 'Problem statement written',
          detail: 'A plain-English statement of the pain.',
        ),
        ChecklistTask(
          id: 'stage-1-2',
          title: 'First ICP selected',
          detail: 'One narrow user segment with context.',
        ),
        ChecklistTask(
          id: 'stage-1-3',
          title: 'Current workaround documented',
          detail: 'Know what users do today instead.',
        ),
        ChecklistTask(
          id: 'stage-1-4',
          title: 'Five discovery notes captured',
          detail: 'Use real language from real conversations.',
        ),
      ],
      moveOnWhen:
          'Move forward when you can state the problem, audience, and current workaround with confidence and evidence.',
      focusStatement: 'Clarify the pain before designing the product.',
      priorities: [
        'Talk to the right buyer type.',
        'Name the pain in concrete language.',
        'Document what users already do today.',
      ],
      blockedItems: [
        'Too many possible buyer types.',
        'No evidence that the pain is urgent.',
      ],
      biggestRisk: 'Building around assumed pain instead of observed pain.',
      moduleId: 'problem-customer-offer',
    ),
    Stage(
      id: 'offer-definition',
      order: 2,
      title: 'Offer Definition',
      telemetry: 'POSITION',
      meaning:
          'You are turning a problem insight into a clear promise and deciding what the first version of the offer should be.',
      successLooksLike:
          'A target buyer understands the promise, outcome, and why this is better than their current workaround.',
      commonMistakes: [
        'Listing features instead of promising a result.',
        'Making the offer too broad to feel believable.',
        'Ignoring how the buyer measures success.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-2-1',
          title: 'Value proposition drafted',
          detail: 'One concise offer statement.',
        ),
        ChecklistTask(
          id: 'stage-2-2',
          title: 'Promise and proof points listed',
          detail: 'Why the buyer should trust it.',
        ),
        ChecklistTask(
          id: 'stage-2-3',
          title: 'Offer boundary defined',
          detail: 'What the first offer does and does not do.',
        ),
        ChecklistTask(
          id: 'stage-2-4',
          title: 'Buyer objections collected',
          detail: 'Known doubts before launch.',
        ),
      ],
      moveOnWhen:
          'Move on when the offer reads clearly, the promise feels believable, and the scope is tight enough to ship.',
      focusStatement:
          'Turn insight into a promise that a buyer can quickly understand.',
      priorities: [
        'Make the promise outcome-based.',
        'Reduce ambiguity in who this is for.',
        'Set boundaries on what v1 includes.',
      ],
      blockedItems: [
        'Offer still sounds generic.',
        'No proof or reason to trust the promise.',
      ],
      biggestRisk: 'Trying to sound impressive instead of useful.',
      moduleId: 'problem-customer-offer',
    ),
    Stage(
      id: 'mvp-build',
      order: 3,
      title: 'MVP Build',
      telemetry: 'ASSEMBLE',
      meaning:
          'You are building the smallest version that can prove the core workflow and generate real feedback.',
      successLooksLike:
          'There is a working end-to-end experience for the main use case, even if the edges are rough.',
      commonMistakes: [
        'Adding future-proofing instead of finishing the core loop.',
        'Making every screen feel production-complete before testing.',
        'Skipping deployment until the app feels perfect.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-3-1',
          title: 'Core user flow mapped',
          detail: 'Plain-English flow from entry to value.',
        ),
        ChecklistTask(
          id: 'stage-3-2',
          title: 'Stack chosen',
          detail: 'Frontend, backend, storage, and deployment path.',
        ),
        ChecklistTask(
          id: 'stage-3-3',
          title: 'First end-to-end build works',
          detail: 'The main workflow completes successfully.',
        ),
        ChecklistTask(
          id: 'stage-3-4',
          title: 'Deploy path documented',
          detail: 'Know how to move code into a live environment.',
        ),
      ],
      moveOnWhen:
          'Move on when the product works end-to-end for the core job and you can show it to a user without apologizing for basic breakage.',
      focusStatement: 'Finish the core loop before adding comfort features.',
      priorities: [
        'Keep the scope tight.',
        'Get one flow working live.',
        'Protect the deploy path early.',
      ],
      blockedItems: [
        'Architecture drift from too many new ideas.',
        'No shared understanding of v1 boundary.',
      ],
      biggestRisk: 'Losing momentum in endless rebuild loops.',
      moduleId: 'product-stack-build',
    ),
    Stage(
      id: 'working-product',
      order: 4,
      title: 'Working Product',
      telemetry: 'LIVE',
      meaning:
          'The product is usable enough to learn from real behavior instead of guesswork.',
      successLooksLike:
          'A real user can complete the intended action and you can observe what helps or hurts that experience.',
      commonMistakes: [
        'Assuming the presence of a product means the hard part is over.',
        'Ignoring onboarding clarity because the founder knows how the product works.',
        'Shipping without logging or feedback capture.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-4-1',
          title: 'First user completed core task',
          detail: 'Observe a successful real workflow.',
        ),
        ChecklistTask(
          id: 'stage-4-2',
          title: 'Top bugs triaged',
          detail: 'Major blockers are documented and ranked.',
        ),
        ChecklistTask(
          id: 'stage-4-3',
          title: 'First success event defined',
          detail: 'Know what activation means.',
        ),
        ChecklistTask(
          id: 'stage-4-4',
          title: 'Feedback capture in place',
          detail: 'Notes, logs, or analytics are ready.',
        ),
      ],
      moveOnWhen:
          'Move on when new users can reach a meaningful result and you can see where they stall.',
      focusStatement: 'Make the real workflow usable and observable.',
      priorities: [
        'Close obvious usability gaps.',
        'Define activation clearly.',
        'Capture feedback consistently.',
      ],
      blockedItems: [
        'Core path still breaks often.',
        'No clear signal about first-time user success.',
      ],
      biggestRisk:
          'Calling the product live when it is still too fragile to learn from.',
      moduleId: 'funnel-conversion',
    ),
    Stage(
      id: 'launch-prep',
      order: 5,
      title: 'Launch Prep',
      telemetry: 'READY',
      meaning:
          'You are preparing the assets, positioning, and operational basics needed to bring users in without chaos.',
      successLooksLike:
          'The app, message, landing page, and support expectations all match and can handle initial traffic.',
      commonMistakes: [
        'Treating launch as a one-day event instead of a prepared sequence.',
        'Ignoring support, FAQ, or error handling.',
        'Leading with the wrong message because assets were rushed.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-5-1',
          title: 'Landing page or product page ready',
          detail: 'Clear message and call to action.',
        ),
        ChecklistTask(
          id: 'stage-5-2',
          title: 'Support and FAQ notes prepared',
          detail: 'Avoid repetitive confusion after launch.',
        ),
        ChecklistTask(
          id: 'stage-5-3',
          title: 'Core metrics selected',
          detail: 'Know what you will watch immediately.',
        ),
        ChecklistTask(
          id: 'stage-5-4',
          title: 'Launch checklist completed',
          detail: 'Assets, tracking, and backups are in place.',
        ),
      ],
      moveOnWhen:
          'Move on when your launch path is coherent, measured, and supported by basic operational readiness.',
      focusStatement: 'Remove avoidable chaos before attention arrives.',
      priorities: [
        'Tighten message and call to action.',
        'Prepare simple support systems.',
        'Choose launch metrics before launch day.',
      ],
      blockedItems: [
        'Landing page still lacks clear audience and outcome.',
        'Support expectations are undefined.',
      ],
      biggestRisk: 'Driving attention into a confusing first experience.',
      moduleId: 'distribution-marketing',
    ),
    Stage(
      id: 'early-distribution',
      order: 6,
      title: 'Early Distribution',
      telemetry: 'TRAFFIC',
      meaning:
          'You are putting the product in front of real prospects through one or two focused channels and watching the response carefully.',
      successLooksLike:
          'Traffic quality improves, user feedback is specific, and you can tell which message or channel is creating meaningful interest.',
      commonMistakes: [
        'Spreading effort across too many channels.',
        'Changing audience, message, and product all at once.',
        'Chasing vanity metrics instead of stage-specific signal.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-6-1',
          title: 'Primary channel selected',
          detail: 'One main distribution path is active.',
        ),
        ChecklistTask(
          id: 'stage-6-2',
          title: 'AEO or landing page copy updated',
          detail: 'The message is explicit and searchable.',
        ),
        ChecklistTask(
          id: 'stage-6-3',
          title: 'Three creatives or hooks tested',
          detail: 'You are learning from message variation.',
        ),
        ChecklistTask(
          id: 'stage-6-4',
          title: 'Traffic quality reviewed',
          detail: 'You know if the right people are arriving.',
        ),
      ],
      moveOnWhen:
          'Move on when you can identify a channel-message combination that consistently attracts qualified attention.',
      focusStatement: 'Find the right attention, not just more attention.',
      priorities: [
        'Choose the primary channel.',
        'Tighten AEO and landing clarity.',
        'Test a few message angles with discipline.',
      ],
      blockedItems: [
        'No clarity on what counts as a qualified lead or install.',
        'Traffic is arriving but not converting.',
      ],
      biggestRisk: 'Interpreting weak or misaligned traffic as market demand.',
      moduleId: 'distribution-marketing',
    ),
    Stage(
      id: 'signal-validation',
      order: 7,
      title: 'Signal Validation',
      telemetry: 'PROVE',
      meaning:
          'You are checking whether the interest or usage patterns show enough promise to justify further investment.',
      successLooksLike:
          'You have evidence that a specific user segment values the product enough to keep using, buying, or asking for it.',
      commonMistakes: [
        'Celebrating one loud positive response as proof.',
        'Ignoring weak retention or weak buying follow-through.',
        'Confusing curiosity with intent.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-7-1',
          title: 'Signal metric defined',
          detail: 'Know what counts as meaningful proof.',
        ),
        ChecklistTask(
          id: 'stage-7-2',
          title: 'Qualified user feedback captured',
          detail: 'Real signal from the right user type.',
        ),
        ChecklistTask(
          id: 'stage-7-3',
          title: 'Repeat usage or purchase intent observed',
          detail: 'Evidence of durable demand.',
        ),
        ChecklistTask(
          id: 'stage-7-4',
          title: 'Decision logged',
          detail: 'Continue, narrow, or pivot based on actual evidence.',
        ),
      ],
      moveOnWhen:
          'Move on when the evidence shows enough real demand to invest in improving conversion and monetization.',
      focusStatement: 'Decide based on qualified signal, not hope.',
      priorities: [
        'Define the proof metric.',
        'Watch qualified user behavior closely.',
        'Write the decision, not just the observation.',
      ],
      blockedItems: [
        'No agreement on what counts as proof.',
        'Feedback is positive but behavior is weak.',
      ],
      biggestRisk: 'Mistaking noise for product-market pull.',
      moduleId: 'founder-operator-systems',
    ),
    Stage(
      id: 'conversion-optimization',
      order: 8,
      title: 'Conversion Optimization',
      telemetry: 'TUNE',
      meaning:
          'You are improving the handoff from attention to activation or payment by reducing friction and sharpening alignment.',
      successLooksLike:
          'More of the right users reach the first success event or purchase without needing more traffic volume.',
      commonMistakes: [
        'Testing tiny design details before fixing major clarity problems.',
        'Changing too many funnel elements simultaneously.',
        'Ignoring activation because top-of-funnel metrics look exciting.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-8-1',
          title: 'Funnel stages documented',
          detail: 'The handoff steps are visible and measurable.',
        ),
        ChecklistTask(
          id: 'stage-8-2',
          title: 'Largest drop-off identified',
          detail: 'One clear friction point is prioritized.',
        ),
        ChecklistTask(
          id: 'stage-8-3',
          title: 'One funnel experiment run',
          detail: 'A meaningful improvement test is complete.',
        ),
        ChecklistTask(
          id: 'stage-8-4',
          title: 'Message alignment reviewed',
          detail: 'Traffic promise and product promise match.',
        ),
      ],
      moveOnWhen:
          'Move on when your funnel is measurably healthier and the main friction points are known instead of guessed.',
      focusStatement:
          'Make the existing traffic convert better before chasing more.',
      priorities: [
        'Map the funnel.',
        'Remove the biggest friction point.',
        'Keep message consistent from click to value.',
      ],
      blockedItems: [
        'No clear activation definition.',
        'Multiple funnel changes are happening at once.',
      ],
      biggestRisk: 'Treating conversion work as cosmetic polish.',
      moduleId: 'funnel-conversion',
    ),
    Stage(
      id: 'monetization',
      order: 9,
      title: 'Monetization',
      telemetry: 'REVENUE',
      meaning:
          'You are aligning pricing, packaging, and value delivery so the business can become durable.',
      successLooksLike:
          'People understand what they are paying for, and the model fits how value is consumed.',
      commonMistakes: [
        'Underpricing to reduce founder discomfort.',
        'Using a pricing model that does not match product behavior.',
        'Ignoring support and delivery cost when setting price.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-9-1',
          title: 'Pricing model selected',
          detail: 'Subscription, one-time, licensing, or hybrid.',
        ),
        ChecklistTask(
          id: 'stage-9-2',
          title: 'Outcome stated clearly',
          detail: 'The buyer value is explicit.',
        ),
        ChecklistTask(
          id: 'stage-9-3',
          title: 'Tiers or packages drafted',
          detail: 'Options feel intentional and easy to understand.',
        ),
        ChecklistTask(
          id: 'stage-9-4',
          title: 'Willingness-to-pay feedback captured',
          detail: 'Live reactions to the offer and price.',
        ),
      ],
      moveOnWhen:
          'Move on when pricing feels aligned with the product, the buyer understands the ladder, and evidence suggests the offer is viable.',
      focusStatement: 'Make revenue logic match delivered value.',
      priorities: [
        'Pick the pricing model that fits usage.',
        'State the buyer outcome clearly.',
        'Test pricing with real conversations or offers.',
      ],
      blockedItems: [
        'Price is chosen from fear instead of evidence.',
        'Users do not understand what each tier means.',
      ],
      biggestRisk: 'Locking in weak economics before the offer is clear.',
      moduleId: 'monetization-pricing',
    ),
    Stage(
      id: 'repeatable-growth',
      order: 10,
      title: 'Repeatable Growth',
      telemetry: 'LOOP',
      meaning:
          'You are refining the system until acquisition, conversion, and monetization can be repeated with more confidence.',
      successLooksLike:
          'A small number of reliable loops and metrics guide decisions instead of random bursts of effort.',
      commonMistakes: [
        'Adding more channels before one repeatable loop exists.',
        'Scaling spend without a stable conversion path.',
        'Letting support load or bugs quietly erode growth.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-10-1',
          title: 'Primary growth loop identified',
          detail: 'Know what can repeat with intent.',
        ),
        ChecklistTask(
          id: 'stage-10-2',
          title: 'Weekly scoreboard active',
          detail: 'Metrics reviewed on a real cadence.',
        ),
        ChecklistTask(
          id: 'stage-10-3',
          title: 'Experiment cadence established',
          detail: 'Tests run and reviewed regularly.',
        ),
        ChecklistTask(
          id: 'stage-10-4',
          title: 'Support or ops drag reviewed',
          detail: 'Growth is not hiding operational pain.',
        ),
      ],
      moveOnWhen:
          'Move on when growth behavior is becoming repeatable enough to systematize instead of heroically pushing each week.',
      focusStatement: 'Build loops that work again, not just once.',
      priorities: [
        'Identify the repeatable loop.',
        'Review the same scoreboard weekly.',
        'Protect the business from silent drag.',
      ],
      blockedItems: [
        'Growth depends on one-off bursts.',
        'Operational load is stealing time from high-leverage work.',
      ],
      biggestRisk: 'Confusing a spike with a system.',
      moduleId: 'founder-operator-systems',
    ),
    Stage(
      id: 'scale-systems',
      order: 11,
      title: 'Scale / Systems',
      telemetry: 'CONTROL',
      meaning:
          'You are tightening operations, documentation, reliability, and delegation so the business can grow without breaking itself.',
      successLooksLike:
          'Core workflows, metrics, security, and support systems are documented well enough to sustain growth with less founder chaos.',
      commonMistakes: [
        'Hiring or expanding before the process exists.',
        'Ignoring reliability or support debt because revenue is growing.',
        'Letting systems remain in the founder’s head.',
      ],
      milestones: [
        ChecklistTask(
          id: 'stage-11-1',
          title: 'Core processes documented',
          detail: 'Critical operating tasks are written down.',
        ),
        ChecklistTask(
          id: 'stage-11-2',
          title: 'Reliability and backup plan reviewed',
          detail: 'The business can survive common failures.',
        ),
        ChecklistTask(
          id: 'stage-11-3',
          title: 'Support boundaries or handoff set',
          detail: 'Growth is not trapped in one person.',
        ),
        ChecklistTask(
          id: 'stage-11-4',
          title: 'Next system bottleneck identified',
          detail: 'Know what breaks at the next level.',
        ),
      ],
      moveOnWhen:
          'This stage never really ends, but you are healthy when growth creates less chaos than before.',
      focusStatement: 'Turn founder heroics into repeatable systems.',
      priorities: [
        'Document core workflows.',
        'Reduce operational fragility.',
        'Clarify ownership and handoff boundaries.',
      ],
      blockedItems: [
        'Critical knowledge only exists in your head.',
        'Support, security, or infrastructure debt is ignored.',
      ],
      biggestRisk: 'Scaling chaos instead of scaling systems.',
      moduleId: 'security-reliability',
    ),
  ];

  static const List<GlossaryTerm> _glossary = [
    GlossaryTerm(
      term: 'Founder',
      category: 'Orientation',
      definition:
          'The person responsible for turning an idea into a real product and business by making decisions under uncertainty.',
    ),
    GlossaryTerm(
      term: 'Startup',
      category: 'Orientation',
      definition:
          'A young business still searching for a repeatable way to create value and make money.',
    ),
    GlossaryTerm(
      term: 'Business model',
      category: 'Orientation',
      definition:
          'The logic for how a company creates value, delivers it, and gets paid.',
    ),
    GlossaryTerm(
      term: 'MVP',
      category: 'Orientation',
      definition:
          'Minimum Viable Product. The smallest version of the product that can test whether the core value is real.',
    ),
    GlossaryTerm(
      term: 'Customer development',
      category: 'Orientation',
      definition:
          'A disciplined process of testing assumptions about customers, problems, and demand with real people.',
    ),
    GlossaryTerm(
      term: 'AEO',
      category: 'Marketing',
      definition:
          'Answer Engine Optimization. Structuring content so AI answer engines can understand, trust, and surface it.',
    ),
    GlossaryTerm(
      term: 'ASO',
      category: 'Marketing',
      definition:
          'App Store Optimization. Improving how an app listing gets discovered and converted.',
    ),
    GlossaryTerm(
      term: 'CAC',
      category: 'Business',
      definition:
          'Customer Acquisition Cost. How much you spend to get one paying customer.',
    ),
    GlossaryTerm(
      term: 'ICP',
      category: 'Strategy',
      definition:
          'Ideal Customer Profile. The specific buyer segment you are designing and selling for first.',
    ),
    GlossaryTerm(
      term: 'Activation',
      category: 'Product',
      definition:
          'The first meaningful success event that proves a new user reached value.',
    ),
    GlossaryTerm(
      term: 'Retention',
      category: 'Product',
      definition:
          'Whether users keep coming back or continue using the product over time.',
    ),
    GlossaryTerm(
      term: 'LTV',
      category: 'Business',
      definition:
          'Lifetime Value. The expected revenue a customer produces across the relationship.',
    ),
    GlossaryTerm(
      term: 'Payback Period',
      category: 'Business',
      definition:
          'How long it takes for revenue from a customer to recover the cost of acquiring them.',
    ),
    GlossaryTerm(
      term: 'Value Proposition',
      category: 'Strategy',
      definition:
          'A simple statement of who the product is for, what result it creates, and why it is better or faster.',
    ),
    GlossaryTerm(
      term: 'Pain intensity',
      category: 'Strategy',
      definition:
          'How severe, frequent, or costly the buyer’s problem feels in real life.',
    ),
    GlossaryTerm(
      term: 'Demand validation',
      category: 'Strategy',
      definition:
          'Evidence that real buyers care enough about the problem to take action, not just compliment the idea.',
    ),
    GlossaryTerm(
      term: 'Offer wedge',
      category: 'Strategy',
      definition:
          'The narrow angle or entry point that makes your offer feel specific and immediately relevant to one buyer segment.',
    ),
    GlossaryTerm(
      term: 'API',
      category: 'Engineering',
      definition:
          'Application Programming Interface. A structured way for software systems to send or request data.',
    ),
    GlossaryTerm(
      term: 'Frontend',
      category: 'Engineering',
      definition:
          'The part of the product the user sees and interacts with directly.',
    ),
    GlossaryTerm(
      term: 'Backend',
      category: 'Engineering',
      definition:
          'The server-side logic that handles rules, processing, and data operations behind the scenes.',
    ),
    GlossaryTerm(
      term: 'Database',
      category: 'Engineering',
      definition:
          'The system that stores the product’s structured data as the main source of truth.',
    ),
    GlossaryTerm(
      term: 'Hosting',
      category: 'Engineering',
      definition:
          'The service or infrastructure where your app is deployed and made available online.',
    ),
    GlossaryTerm(
      term: 'Deployment',
      category: 'Engineering',
      definition:
          'The process of pushing your application from local development into a live environment.',
    ),
    GlossaryTerm(
      term: 'Environment Variable',
      category: 'Security',
      definition:
          'A secret or configuration value stored outside the source code so it does not get committed.',
    ),
    GlossaryTerm(
      term: 'Least Privilege',
      category: 'Security',
      definition:
          'Giving a user or system only the minimum access needed to perform its task.',
    ),
    GlossaryTerm(
      term: 'Onboarding',
      category: 'Product',
      definition:
          'The sequence that helps a new user understand the product and reach the first value moment quickly.',
    ),
    GlossaryTerm(
      term: 'Conversion Rate',
      category: 'Marketing',
      definition:
          'The percent of users who move from one step in a funnel to the next desired action.',
    ),
    GlossaryTerm(
      term: 'Organic loops',
      category: 'Marketing',
      definition:
          'Growth patterns where current users, content, or usage naturally bring in new users without direct paid spend.',
    ),
    GlossaryTerm(
      term: 'Creative testing',
      category: 'Marketing',
      definition:
          'Running controlled experiments on hooks, ads, landing pages, or messaging to see what performs best.',
    ),
    GlossaryTerm(
      term: 'Attribution',
      category: 'Marketing',
      definition:
          'Figuring out which channel, touchpoint, or message influenced a user to convert.',
    ),
    GlossaryTerm(
      term: 'Signal vs noise',
      category: 'Marketing',
      definition:
          'Separating useful evidence that should change your decision from distracting activity that looks busy but teaches little.',
    ),
    GlossaryTerm(
      term: 'Install rate',
      category: 'Product',
      definition:
          'The percentage of people who install the product after seeing the listing or offer.',
    ),
    GlossaryTerm(
      term: 'Signup rate',
      category: 'Product',
      definition:
          'The percentage of visitors who create an account or start using the product.',
    ),
    GlossaryTerm(
      term: 'Trial conversion',
      category: 'Product',
      definition: 'The percentage of trial users who become paying customers.',
    ),
    GlossaryTerm(
      term: 'Friction point',
      category: 'Product',
      definition:
          'Any step that creates confusion, delay, extra effort, or drop-off for the user.',
    ),
    GlossaryTerm(
      term: 'Paywall',
      category: 'Product',
      definition:
          'The screen or step where the product asks the user to pay or upgrade to continue.',
    ),
    GlossaryTerm(
      term: 'Outcome-based pricing',
      category: 'Monetization',
      definition:
          'Pricing that reflects the result or value delivered to the buyer rather than the founder’s effort.',
    ),
    GlossaryTerm(
      term: 'Payback',
      category: 'Monetization',
      definition:
          'The amount of time it takes to recover what you spent to acquire a customer.',
    ),
    GlossaryTerm(
      term: 'Willingness to pay',
      category: 'Monetization',
      definition:
          'The amount a buyer is actually prepared to pay for the value or outcome you offer.',
    ),
    GlossaryTerm(
      term: 'Price anchors',
      category: 'Monetization',
      definition:
          'Reference prices or framing points that shape how expensive or reasonable an offer feels.',
    ),
    GlossaryTerm(
      term: 'License Tier',
      category: 'Monetization',
      definition:
          'A pricing or rights layer that changes how a digital product can be used.',
    ),
    GlossaryTerm(
      term: 'Signal',
      category: 'Operator',
      definition:
          'Useful evidence that changes what you should do next. Signal is stronger than activity or attention alone.',
    ),
    GlossaryTerm(
      term: 'Bottleneck',
      category: 'Operator',
      definition: 'The current constraint that is most limiting progress.',
    ),
    GlossaryTerm(
      term: 'Scope Creep',
      category: 'Operator',
      definition:
          'When work expands beyond the intended boundary and slows delivery.',
    ),
  ];

  static const List<DecisionFramework> _frameworks = [
    DecisionFramework(
      title: 'Should I keep testing this?',
      description:
          'Use this when a channel, feature, or offer is producing mixed results and you need to decide whether to continue.',
      questions: [
        'What exact signal am I hoping to improve?',
        'Have I tested the core message enough times with the same audience?',
        'Is the product or offer clear enough that failure would teach me something real?',
        'What would count as a stop condition this week?',
      ],
      output:
          'Continue only if the next test changes one important variable and can produce a clear decision.',
    ),
    DecisionFramework(
      title: 'Product problem or distribution problem?',
      description:
          'Use this when attention exists but results remain weak and you are not sure where the issue lives.',
      questions: [
        'Are the right people arriving?',
        'Does the landing page or first screen match the promise from the traffic source?',
        'Can users reach a success event quickly once they arrive?',
        'Would stronger traffic solve the issue, or would it just amplify the same leak?',
      ],
      output:
          'If qualified users arrive but stall, the problem is often product or conversion. If the wrong users arrive, the problem is distribution or message targeting.',
    ),
    DecisionFramework(
      title: 'Is this worth building?',
      description:
          'Use this before spending meaningful time on a feature, module, or new offer idea.',
      questions: [
        'What painful problem does this solve right now?',
        'Who specifically will care enough to use or buy it?',
        'What evidence exists beyond my personal intuition?',
        'Does this unlock learning, revenue, or retention soon enough to matter?',
      ],
      output:
          'Build only if the work solves a known bottleneck or creates evidence that changes the next decision.',
    ),
    DecisionFramework(
      title: 'Am I under-testing or overthinking?',
      description:
          'Use this when you feel stuck between more research and more action.',
      questions: [
        'Do I already know enough to run a small real-world test?',
        'Am I avoiding a test because I dislike the possible result?',
        'What is the cheapest experiment that would produce real signal?',
        'Would another day of planning materially change the experiment design?',
      ],
      output:
          'If the next test is obvious and safe, act. If the test would be invalid because the core assumption is still fuzzy, tighten the assumption first.',
    ),
  ];
}
