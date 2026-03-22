class LessonReference {
  const LessonReference({
    required this.title,
    required this.url,
    required this.note,
  });

  final String title;
  final String url;
  final String note;
}

class LessonContent {
  const LessonContent({
    required this.coreIdea,
    required this.whyItMatters,
    required this.timing,
    required this.evidence,
    required this.founderLens,
    required this.example,
    required this.steps,
    required this.watchOuts,
    required this.output,
    this.lessonTerms = const [],
    this.selfCheckQuestions = const [],
    this.references = const [],
  });

  final String coreIdea;
  final String whyItMatters;
  final String timing;
  final String evidence;
  final String founderLens;
  final String example;
  final List<String> steps;
  final List<String> watchOuts;
  final String output;
  final List<String> lessonTerms;
  final List<String> selfCheckQuestions;
  final List<LessonReference> references;
}

const Map<String, LessonContent> lessonContentById = {
  'sh-1': LessonContent(
    coreIdea:
        'This course exists to teach the operating logic of a founder: identify a painful problem, define the right buyer, create an offer, build only what is necessary, get the product in front of real people, improve conversion, price around value, and then build systems around what works. That sequence is not arbitrary. It is the common discipline used in serious early-stage company building because it reduces uncertainty in the right order.',
    whyItMatters:
        'Without a coherent model of what a founder is doing, the work feels like random tasks: product, marketing, pricing, operations, and finance all look disconnected. In reality, they are parts of one process. This overview matters because it tells you what game you are playing and why each module in the course exists.',
    timing:
        'This is the first lesson because it frames the rest of the curriculum. If you do not understand the overall sequence, later tactical lessons will feel fragmented or premature.',
    evidence:
        'This course structure draws on customer development, lean startup practice, practical startup writing, and entrepreneurship education. Across those traditions, the recurring logic is the same: founders should move from problem clarity to buyer clarity to offer clarity to product validation to distribution and monetization, rather than treating startup work as product-building alone.',
    founderLens:
        'A founder is not just a person with an idea. A founder is the person responsible for turning uncertainty into evidence, then turning evidence into a product and a business.',
    example:
        'A lawyer leaving practice to build software may be tempted to start with product features. The more disciplined path is to first identify the painful workflow, then specify which type of lawyer has that pain, then define the offer, then build the narrowest useful version, then test whether anyone actually uses or buys it.',
    steps: [
      'Read this overview before picking a module.',
      'Understand that the course moves in sequence from problem to sale to systems.',
      'Use later modules only after you know where you are in that sequence.',
    ],
    watchOuts: [
      'Do not confuse startup education with learning random business jargon.',
      'Do not jump to later-stage topics before the earlier-stage evidence exists.',
      'Do not treat product-building as the whole job of a founder.',
    ],
    output:
        'A mental map of the founder process and where each module fits inside it.',
    lessonTerms: [
      'Founder',
      'Startup',
      'Business model',
      'MVP',
      'Distribution',
      'Monetization',
    ],
    selfCheckQuestions: [
      'Can you explain, in plain English, what a founder is trying to do besides “build an app”?',
      'Can you describe the sequence from problem discovery to product to sales to systems?',
      'Do you understand why this course teaches in stages instead of by disconnected topics?',
    ],
    references: [
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Primary startup source on testing business hypotheses in a staged process.',
      ),
      LessonReference(
        title: 'Paul Graham Essays',
        url: 'https://paulgraham.com/articles.html',
        note:
            'Foundational startup writing on what founders do, how startups work, and why early-stage judgment matters.',
      ),
      LessonReference(
        title: 'Y Combinator Library',
        url: 'https://www.ycombinator.com/library',
        note:
            'Broad practical founder education covering problem, product, growth, and fundraising.',
      ),
    ],
  ),
  'sh-2': LessonContent(
    coreIdea:
        'The normal founder process is not “have idea, build product, hope people buy.” The stronger industry-standard sequence is: identify a painful problem, define the first buyer, validate demand, create a credible offer, build the smallest useful version, learn from real usage, improve conversion, price intelligently, and only then scale systems. This is the course map because it reflects the order in which uncertainty should be reduced.',
    whyItMatters:
        'This matters because founders waste time when they solve questions out of order. For example, scaling acquisition before onboarding works, or debating complex pricing before demand is real, creates noise rather than progress. The timing of decisions is part of founder skill.',
    timing:
        'You use this lesson before diving into the detailed modules so you can place yourself in the correct phase. It is also useful whenever you feel lost, because it tells you which kind of problem you are actually supposed to be solving next.',
    evidence:
        'Entrepreneurship teaching and startup field practice repeatedly emphasize stage-appropriate decisions. Customer development, effectuation, and lean startup methods all reject the idea that startups should behave like mature companies from day one.',
    founderLens:
        'The founder job is to ask: what is the next uncertainty I need to reduce, and what evidence would justify moving forward?',
    example:
        'If no buyer has yet shown real interest, then improving the feature set is probably the wrong next move. If buyers are interested but not converting, then building more is also often the wrong next move. The correct move depends on the stage.',
    steps: [
      'Locate yourself in the founder sequence: problem, offer, build, distribution, conversion, monetization, or systems.',
      'Only study the next module with the highest immediate relevance.',
      'Return to this lesson whenever the course starts to feel fragmented.',
    ],
    watchOuts: [
      'Do not study advanced tactics without stage context.',
      'Do not assume more effort equals progress if the effort is mis-timed.',
      'Do not use complexity to avoid the next obvious decision.',
    ],
    output:
        'A clear view of what comes first, what comes later, and why timing matters in founder work.',
    lessonTerms: ['Customer development', 'Validation', 'Offer', 'MVP'],
    selfCheckQuestions: [
      'Can you name the standard sequence from problem to product to sales to systems?',
      'Can you say which stage you are personally in right now?',
      'Can you explain why the wrong decision at the wrong stage wastes time?',
    ],
    references: [
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Direct source on staged startup learning rather than product-first guessing.',
      ),
      LessonReference(
        title: 'Cambridge University Press: Effectuation',
        url:
            'https://www.cambridge.org/core/elements/effectuation/1E91EFA3C3E88C752B65715F9C176639',
        note: 'Academic treatment of entrepreneurial action under uncertainty.',
      ),
    ],
  ),
  'sh-3': LessonContent(
    coreIdea:
        'The point of building products for sale is to create repeatable value for a defined buyer in a way that can be delivered and paid for consistently. A product is not just software. It is a packaged answer to a problem. The business side matters because value without distribution is invisible, distribution without conversion is waste, and conversion without monetization is activity without a business.',
    whyItMatters:
        'This matters because many first-time founders treat the product itself as the entire mission. In reality, the product is one component of a business system. The founder must connect value creation, value communication, value capture, and delivery.',
    timing:
        'You should learn this before getting too emotionally attached to features. It helps anchor the whole course in commercial logic instead of maker logic alone.',
    evidence:
        'Entrepreneurship education, startup practice, and modern product-growth methods all assume that a venture must solve for value creation and value capture together. The difference between a project and a company is not merely having code; it is having a repeatable path from problem to purchase to continued use.',
    founderLens: 'A founder is building an economic system, not just a tool.',
    example:
        'A document automation app for lawyers is not successful because the code is elegant. It is successful if the right lawyers understand the value, trust the offer, adopt the workflow, keep using it, and pay enough for the business to sustain itself.',
    steps: [
      'Separate product quality from business viability in your thinking.',
      'Ask how the product creates value, how buyers find it, and how money is collected.',
      'Use the later modules to strengthen each of those links in order.',
    ],
    watchOuts: [
      'Do not confuse technical completion with business viability.',
      'Do not assume that a good tool will automatically find a market.',
      'Do not ignore monetization until the end.',
    ],
    output:
        'A clear understanding that the course is about building a sellable business, not just shipping software.',
    lessonTerms: [
      'Product',
      'Business model',
      'Distribution',
      'Conversion',
      'Monetization',
    ],
    selfCheckQuestions: [
      'Can you explain how a product becomes a business rather than just a tool?',
      'Can you identify the difference between value creation and value capture?',
      'Can you describe why distribution and monetization belong in founder education from the start?',
    ],
    references: [
      LessonReference(
        title:
            'Harvard Business Review: Know Your Customers’ “Jobs to Be Done”',
        url: 'https://hbr.org/2016/09/know-your-customers-jobs-to-be-done',
        note:
            'Relevant to understanding that products are hired to create customer progress.',
      ),
      LessonReference(
        title: 'Y Combinator Library',
        url: 'https://www.ycombinator.com/library',
        note:
            'Practical founder education spanning product, growth, and business fundamentals.',
      ),
    ],
  ),
  'sh-4': LessonContent(
    coreIdea:
        'You should treat this course like an accelerated founder-MBA in operating order. That means the goal is not to memorize jargon. The goal is to build judgment: what matters first, what evidence is good enough, what to ignore, and how to move from uncertainty to repeatable results. The course is designed to make you legible to yourself as a founder so you can think clearly about products, offers, growth, and systems.',
    whyItMatters:
        'This matters because educational value depends on context and application. If you read these lessons as disconnected information, you will forget most of it. If you read them as a sequence of operating decisions you will have to make, the material becomes practical and durable.',
    timing:
        'This lesson belongs at the start of the course and whenever you need to reset your mindset. It is especially relevant if you feel overwhelmed by startup language or tempted to treat the material as a collection of tips.',
    evidence:
        'Effective founder education tends to combine conceptual understanding, practical frameworks, and staged application. That is why this course includes explanation, timing, examples, checks, and source references rather than only vocabulary or dashboards.',
    founderLens:
        'The standard for this course is not “did I read it.” The standard is “can I use this to make a better founder decision?”',
    example:
        'After finishing the course overview, a serious learner should be able to say: I know what stage I am in, what the next major founder questions are, and which module to study next to answer them.',
    steps: [
      'Start with this module before going deeper.',
      'Use the lesson checks to confirm you actually understand the material.',
      'Move module by module in sequence unless your current business stage clearly requires a different priority.',
    ],
    watchOuts: [
      'Do not read passively and assume familiarity equals competence.',
      'Do not skip straight to late-stage topics because they sound sophisticated.',
      'Do not confuse founder vocabulary with founder judgment.',
    ],
    output:
        'A clear orientation to the course, its purpose, and how to use it for practical founder learning.',
    lessonTerms: ['Founder', 'Startup', 'MVP', 'Signal', 'Bottleneck'],
    selfCheckQuestions: [
      'Can you state what this course is trying to teach you at a high level?',
      'Can you explain how you should move through the modules?',
      'Can you identify the difference between learning terms and learning founder judgment?',
    ],
    references: [
      LessonReference(
        title: 'Paul Graham Essays',
        url: 'https://paulgraham.com/articles.html',
        note:
            'Strong source for founder judgment, startup logic, and practical early-stage thinking.',
      ),
      LessonReference(
        title: 'Y Combinator Library',
        url: 'https://www.ycombinator.com/library',
        note: 'Useful overview library for startup fundamentals across stages.',
      ),
    ],
  ),
  'pco-1': LessonContent(
    coreIdea:
        'A founder-worthy problem is not merely interesting or intellectually elegant. It is a repeated, costly, emotionally salient friction that already forces the buyer to spend time, money, attention, or reputation to manage it. The reason serious founders start here is that products do not create markets out of thin air very often; more often, they reorganize an existing struggle and make resolution easier, faster, safer, or cheaper. If you cannot name the present pain with precision, you are still looking at a topic, not a business.',
    whyItMatters:
        'This comes first because every later decision depends on it. Positioning, pricing, distribution, onboarding, and even product scope all break when the underlying pain is weak or badly specified. In practice, founders waste months building general-purpose tools because they fell in love with a solution category before proving that a buyer experiences a concrete recurring loss.',
    timing:
        'You do this before serious building. The moment you are still deciding what product to make, what buyer to serve, or what promise to lead with, you are in problem-definition territory. If you are already building but cannot clearly state the painful loss in the buyer’s language, you still need to come back to this lesson.',
    evidence:
        'This lesson tracks the customer-development tradition associated with Steve Blank, the jobs-to-be-done framing popularized by Clayton Christensen and colleagues, and effectuation research by Saras Sarasvathy. Across those bodies of work, the pattern is consistent: early ventures improve their odds when they ground product decisions in observed customer struggle rather than founder speculation.',
    founderLens:
        'As an attorney, think about the difference between a vague grievance and a fact pattern that supports a claim. Product discovery works the same way. "This industry is inefficient" is not enough. "Solo attorneys lose billable time and miss follow-up opportunities because intake information arrives across fragmented channels" is the beginning of something you can test.',
    example:
        'A founder says, "Lawyers need better AI." That is not a market insight; it is a technology opinion. A sharper problem statement would be: "Small firm attorneys lose several billable hours per week manually converting intake emails, call notes, and calendar commitments into reliable follow-up tasks, and the slippage creates both revenue loss and client-friction risk." The second statement names the user, the friction, and the cost.',
    steps: [
      'List five frustrations your target buyer repeats or complains about without prompting.',
      'For each frustration, write the cost in time, cash, risk, delay, or stress.',
      'Keep only the problems where the buyer already has a workaround.',
    ],
    watchOuts: [
      'Do not confuse an interesting topic with a painful problem.',
      'Do not start with the solution category before naming the loss.',
      'Do not validate with peers who will never buy.',
    ],
    output:
        'A one-sentence problem statement that names who loses what, why they lose it, and why it matters now.',
    references: [
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Primary practitioner source on customer development and testing startup hypotheses against real customers.',
      ),
      LessonReference(
        title:
            'Harvard Business Review: Know Your Customers’ “Jobs to Be Done”',
        url: 'https://hbr.org/2016/09/know-your-customers-jobs-to-be-done',
        note:
            'Explains why customer circumstance and the job being solved often matter more than broad customer categories.',
      ),
      LessonReference(
        title: 'Cambridge University Press: Effectuation',
        url:
            'https://www.cambridge.org/core/elements/effectuation/1E91EFA3C3E88C752B65715F9C176639',
        note:
            'Academic treatment of entrepreneurial action under uncertainty, useful for understanding why founders should work from means and observed signals rather than prediction alone.',
      ),
    ],
  ),
  'pco-2': LessonContent(
    coreIdea:
        'An ideal customer profile is a deliberately narrow starting point, not a description of everyone who could plausibly benefit. A good ICP identifies a buyer in a specific context, with a specific workflow, a specific current workaround, and a specific moment when the pain becomes expensive enough to motivate action. Narrowing is not a concession. It is how you create clarity strong enough to sell, test, and learn.',
    whyItMatters:
        'Startups usually fail by being too vague before they fail by being too small. When the target buyer is broad, everything downstream gets diluted: copy becomes generic, interviews become mixed, objections become inconsistent, and the product accumulates too many edge cases. A narrow ICP lets you hear patterns sooner and build a product for a real operating context instead of an imaginary market average.',
    timing:
        'You do this immediately after naming the painful problem and before expanding product scope or distribution. If your messaging still uses words like professionals, creators, founders, or small businesses without a specific operating context, you are not done with ICP definition.',
    evidence:
        'This lesson is supported by customer-discovery practice and by jobs-to-be-done research that emphasizes circumstances over abstract profile data. In practical terms, early ventures learn faster when they target one concrete slice of the market and iterate from real buyer behavior instead of trying to optimize for every possible user at once.',
    founderLens:
        'If you would not draft an argument without identifying the relevant court, procedural posture, and decision-maker, do not build a product without identifying the buyer, the context, and the triggering moment. The same legal reasoning discipline applies here: context determines relevance.',
    example:
        'Bad ICP: "professionals who need organization." Better ICP: "solo attorneys handling ten to fifty active matters who track follow-ups in email, calendar reminders, and spreadsheets, and who feel deadline pressure whenever new client communication arrives after hours." The second version is narrower, operational, and testable.',
    steps: [
      'Define the buyer by role, company size, workflow, and pressure moment.',
      'Name the current workaround they rely on today.',
      'Write why this buyer would act in the next ninety days instead of someday.',
    ],
    watchOuts: [
      'Broad markets make copy weak and interviews unfocused.',
      'Do not use demographics when workflow context matters more.',
      'Do not target buyers who feel the pain but cannot approve spend.',
    ],
    output:
        'A short ICP profile covering role, context, current workaround, urgency, and decision authority.',
    references: [
      LessonReference(
        title: 'Harvard Business Review: Target the Right Market',
        url: 'https://hbr.org/2012/10/target-the-right-market-2',
        note:
            'Explains why the first market choice is strategic and shapes the viability of the venture.',
      ),
      LessonReference(
        title: 'HBS Online: How to Do Market Research for a Startup',
        url:
            'https://online.hbs.edu/blog/post/how-to-do-market-research-for-a-startup',
        note:
            'Practical overview of primary research and market understanding for early-stage startups.',
      ),
      LessonReference(
        title:
            'Harvard Business Review: Know Your Customers’ “Jobs to Be Done”',
        url: 'https://hbr.org/2016/09/know-your-customers-jobs-to-be-done',
        note:
            'Useful for understanding why circumstance often matters more than broad persona labels.',
      ),
    ],
  ),
  'pco-3': LessonContent(
    coreIdea:
        'An offer is the translation layer between a painful problem and a buyer’s willingness to act. Buyers do not purchase your internal idea of the product. They purchase a believable improvement in their condition. That means the offer must explain who the product is for, what changes for them, how quickly value appears, and why they should trust the mechanism. Good offers reduce cognitive load. Bad offers make the buyer decode your product.',
    whyItMatters:
        'Even when the problem is real, a weak offer kills momentum because the buyer cannot quickly map the product to their world. Founders frequently over-describe features and under-describe the result. That mistake is expensive because it weakens conversion, obscures pricing logic, and attracts the wrong audience.',
    timing:
        'You work on this as soon as you can name the painful problem and the likely buyer. It should happen before writing major landing-page copy, before running traffic at scale, and before assuming that product confusion is a feature problem rather than an offer problem.',
    evidence:
        'This lesson draws from jobs-to-be-done logic and customer-development practice. The consistent lesson across both is that demand improves when the founder frames the offer around the customer’s progress, not around the company’s preferred description of the product. Buyers hire products to produce movement in their world, not to admire architecture.',
    founderLens:
        'Think in remedies, not ingredients. Clients do not retain counsel because they are excited about your drafting process; they retain counsel because they want a better position, less exposure, or a cleaner outcome. Product offers work the same way.',
    example:
        'Weak offer: "AI workflow platform." Stronger offer: "Turn intake emails and call notes into structured follow-up tasks and deadlines in under five minutes, without manual re-entry." The second statement gives the buyer a result and a speed claim they can evaluate.',
    steps: [
      'Write the user, the result, and the time-to-value in one sentence.',
      'Add the mechanism only if it increases credibility.',
      'Strip adjectives like innovative or intelligent unless you can prove them.',
    ],
    watchOuts: [
      'Feature lists are not positioning.',
      'Big promises without proof create distrust.',
      'If the buyer cannot picture the outcome, the offer is still fuzzy.',
    ],
    output:
        'A headline and subhead that explain who the offer is for, what changes, and why the buyer should believe it.',
    references: [
      LessonReference(
        title:
            'Harvard Business Review: Know Your Customers’ “Jobs to Be Done”',
        url: 'https://hbr.org/2016/09/know-your-customers-jobs-to-be-done',
        note:
            'Directly relevant to designing offers around customer progress rather than feature lists.',
      ),
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Grounds the idea that offer language should emerge from tested hypotheses about customer needs and behavior.',
      ),
    ],
  ),
  'pco-4': LessonContent(
    coreIdea:
        'Validation is not applause. It is evidence that a real buyer recognizes the pain, sees your proposed remedy as relevant, and is willing to spend some scarce resource to move forward. That scarce resource might be money, time, access, sample data, a follow-up meeting, or a warm introduction. The purpose of early validation is not to feel encouraged. It is to reduce uncertainty about whether the market pain is real enough to support action.',
    whyItMatters:
        'Founders routinely confuse interest with demand. That confusion leads to overbuilding, premature certainty, and products designed around polite feedback rather than actual behavior. Strong validation disciplines you to distinguish between people who like the idea and people who are ready to do something costly because the problem matters.',
    timing:
        'This is ongoing from the first meaningful conversations until you have repeated evidence that the buyer will engage, adopt, or pay. You do it before scaling the build, before assuming pricing will work, and before spending heavily on growth. Validation is not one meeting. It is a sequence of evidence-gathering decisions.',
    evidence:
        'This lesson follows the customer-discovery approach developed by Steve Blank and is consistent with effectuation’s emphasis on acting under uncertainty through affordable experiments. It also aligns with practical market-research guidance that prioritizes primary research over founder assumption when the goal is learning what buyers actually do.',
    founderLens:
        'Treat validation like due diligence. Praise without commitment is weak evidence. What matters is whether the buyer gives something up: time on calendar, access to materials, budget discussion, pilot willingness, or a next step that creates accountability.',
    example:
        'A user saying "this sounds useful" is not validation. A user agreeing to a workflow review next week, sharing anonymized sample data, asking implementation questions, or pressing on price and timing is materially stronger evidence because they are allocating effort toward the problem.',
    steps: [
      'Run five to ten conversations with the exact ICP, not generic professionals.',
      'Ask what they do now, what it costs them, and what has already been tried.',
      'Log every buying signal and every objection in plain language.',
    ],
    watchOuts: [
      'Do not pitch too early and contaminate the interview.',
      'Do not rely on social media praise as market proof.',
      'Do not keep building after repeated objections without changing the thesis.',
    ],
    output:
        'A short validation memo listing buyer language, objections, existing workarounds, and evidence of intent.',
    references: [
      LessonReference(
        title:
            'Steve Blank: How to Be Smarter than Your Investors – Continuous Customer Discovery',
        url:
            'https://steveblank.com/2014/02/19/how-to-be-smarter-than-your-investors-continuous-customer-discovery/',
        note:
            'Primary practitioner source on ongoing customer discovery and testing assumptions against reality.',
      ),
      LessonReference(
        title: 'HBS Online: How to Do Market Research for a Startup',
        url:
            'https://online.hbs.edu/blog/post/how-to-do-market-research-for-a-startup',
        note:
            'Useful on primary research and why real customer evidence matters early.',
      ),
      LessonReference(
        title: 'Cambridge University Press: Effectuation',
        url:
            'https://www.cambridge.org/core/elements/effectuation/1E91EFA3C3E88C752B65715F9C176639',
        note:
            'Supports the idea of reducing uncertainty through bounded action and evidence-gathering rather than prediction.',
      ),
    ],
  ),
  'psb-1': LessonContent(
    coreIdea:
        'Your first stack should optimize for speed of shipping, ease of debugging, and low operating overhead. Reliable and understandable beats fashionable. The best stack is the one you can actually finish and maintain.',
    whyItMatters:
        'Stack choice shapes how quickly you can learn from the market. Early founders often lose months to tool decisions that create complexity without improving customer value. A simpler stack reduces debugging time, lowers the chance of deployment paralysis, and keeps attention on the workflow the buyer actually pays for.',
    timing:
        'You make this decision once you know the problem and the first user journey, but before you let implementation sprawl. If you already have a partial build and cannot explain why each technical layer exists, this lesson is still timely because cleanup now is cheaper than cleanup after users arrive.',
    evidence:
        'This lesson is grounded in mainstream software-operating guidance such as the Twelve-Factor App and in official platform architecture guidance. The repeated pattern is that clear boundaries, low config sprawl, and repeatable deployment habits help small teams ship and maintain software faster than ad hoc complexity.',
    founderLens:
        'Early products fail more often from complexity than from lack of sophistication. The stack is a tool for learning, not a trophy.',
    example:
        'A solo founder using Flutter, Supabase, and one deployment target will usually learn faster than the same founder building five microservices because a podcast mentioned scale.',
    steps: [
      'List the minimum technical pieces needed for login, data, and one core workflow.',
      'Choose tools with strong docs and a deploy path you can explain simply.',
      'Reject any layer that exists only for imagined future complexity.',
    ],
    watchOuts: [
      'Do not copy enterprise architecture for a pre-revenue product.',
      'Do not add multiple databases or services without a real constraint.',
      'Do not pick tools you cannot debug alone.',
    ],
    output:
        'A one-page stack decision with frontend, backend, database, hosting, and why each piece is there.',
    references: [
      LessonReference(
        title: 'The Twelve-Factor App',
        url: 'https://12factor.net/',
        note:
            'Classic operating principles for building maintainable web applications with clear config and deployment practices.',
      ),
      LessonReference(
        title: 'Flutter Documentation',
        url: 'https://docs.flutter.dev/',
        note:
            'Official framework documentation useful for choosing and understanding the app layer when using Flutter.',
      ),
    ],
  ),
  'psb-2': LessonContent(
    coreIdea:
        'Products become manageable when you understand where each responsibility lives. Frontend handles interaction, backend handles rules, the database stores state, and APIs move data between systems.',
    whyItMatters:
        'Founders make better product decisions when they can trace cause and effect through the stack. You do not need deep engineering expertise to reason about architecture, but you do need enough clarity to know where business rules live, where data becomes authoritative, and where integrations can fail.',
    timing:
        'Use this lesson as soon as you are discussing product requirements with a builder, choosing tools, or debugging why the product behaves strangely. If you cannot narrate one user action from interface to stored result, this lesson belongs in your current workflow.',
    evidence:
        'Official architecture guidance from modern developer platforms consistently separates interface concerns, business logic, data persistence, and integration boundaries. That separation matters because it makes systems easier to reason about, test, and change without introducing accidental side effects.',
    founderLens:
        'You do not need to be a senior engineer to reason about product architecture. You do need a clean mental model of what happens when a user clicks a button.',
    example:
        'A user presses "Create matter." The interface collects the form, the backend checks permissions and rules, the database stores the new matter, and the UI refreshes with the saved record.',
    steps: [
      'Pick one important user action and trace it from screen to storage.',
      'Write down where validation, business rules, and persistence happen.',
      'Repeat this exercise until you can explain the app in plain English.',
    ],
    watchOuts: [
      'Do not bury business rules in random frontend code.',
      'Do not let the database shape the product before the workflow is clear.',
      'Do not treat APIs as magic plumbing you never need to understand.',
    ],
    output:
        'A plain-language workflow map for one core action from user input to stored result.',
    references: [
      LessonReference(
        title: 'Flutter App Architecture Guide',
        url: 'https://docs.flutter.dev/app-architecture',
        note:
            'Official explanation of layered application structure in Flutter.',
      ),
      LessonReference(
        title: 'Supabase Architecture',
        url: 'https://supabase.com/docs/guides/getting-started/architecture',
        note:
            'Useful for understanding how backend services, auth, database, and APIs fit together in a modern product stack.',
      ),
    ],
  ),
  'psb-3': LessonContent(
    coreIdea:
        'MVP work is about proving value with the smallest trustworthy product, not rehearsing for scale. Architectural purity is far less important than a clean path to getting something live and learning from it.',
    whyItMatters:
        'This matters because founders regularly spend scarce time insulating themselves against hypothetical future scale instead of proving present-day demand. Premature sophistication feels prudent, but it delays feedback, increases maintenance burden, and often buries the one workflow that actually needs to work for the business to exist.',
    timing:
        'You use this lens during MVP scoping, especially when feature requests and architecture ideas are multiplying faster than real user evidence. If you catch yourself building resilience for traffic, compliance, or team size you do not yet have, this lesson is current.',
    evidence:
        'Lean startup thinking and customer-development practice both emphasize shrinking uncertainty through small live tests rather than elaborate predictive planning. In engineering practice, the same logic appears in guidance that favors simpler architectures until a real constraint forces a change.',
    founderLens:
        'Scale theater is building defenses against traffic, team size, or compliance burdens you do not yet have. It feels responsible but often delays the only thing that matters: contact with reality.',
    example:
        'If your product has one paying pilot, the correct move is usually simplifying the signup and fixing onboarding, not introducing queues, event buses, and a multi-region architecture.',
    steps: [
      'List every system or feature that exists for a hypothetical future problem.',
      'Delete, postpone, or downgrade anything not needed for the current core flow.',
      'Protect only the parts that prevent user harm or data loss.',
    ],
    watchOuts: [
      'Do not confuse technical complexity with product quality.',
      'Do not keep "maybe later" features in the MVP by default.',
      'Do not optimize for investors before optimizing for users.',
    ],
    output:
        'A reduced MVP scope with only the flows required to prove the product can solve one real problem.',
    references: [
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Grounds the startup principle of validating assumptions before overbuilding.',
      ),
      LessonReference(
        title: 'The Twelve-Factor App',
        url: 'https://12factor.net/',
        note:
            'Helpful for distinguishing necessary operational discipline from unnecessary architectural sprawl.',
      ),
    ],
  ),
  'psb-4': LessonContent(
    coreIdea:
        'A product that is not deployed cannot teach you much. Deployment discipline means you can move from local changes to a live build with a repeatable process, rollback plan, and no panic.',
    whyItMatters:
        'This matters because deployment is where many founder-led products become fragile. A product trapped on a laptop cannot generate user signal, and a product with an improvised release process creates fear every time you change it. Consistent shipping discipline turns software from a private project into a learning machine.',
    timing:
        'You work on this before launch, not after a public release goes wrong. The moment you have a meaningful build, you need a documented path to staging or production and a habit of shipping small changes instead of dramatic launches.',
    evidence:
        'Modern software operations guidance repeatedly stresses repeatable deployment, configuration discipline, and release practices that reduce fear and batch size. The logic is straightforward: frequent small releases are easier to verify, roll back, and learn from than rare large ones.',
    founderLens:
        'Shipping is not the celebration at the end. It is the operating rhythm that lets product, feedback, and iteration stay connected.',
    example:
        'A disciplined founder can explain where environment variables live, how preview builds work, what URL the app uses, and what to do if a deploy breaks the core flow.',
    steps: [
      'Set one canonical deploy path and document it clearly.',
      'Create a checklist for config, secrets, and smoke testing.',
      'Practice shipping small updates instead of waiting for a perfect release.',
    ],
    watchOuts: [
      'Do not leave deploy setup for launch week.',
      'Do not keep secrets in code or screenshots.',
      'Do not ship giant batches you cannot debug.',
    ],
    output: 'A short deployment runbook you can follow without improvising.',
    references: [
      LessonReference(
        title: 'Vercel Deployments Overview',
        url: 'https://vercel.com/docs/deployments/overview',
        note:
            'Official deployment guidance illustrating repeatable release workflows and preview environments.',
      ),
      LessonReference(
        title: 'The Twelve-Factor App',
        url: 'https://12factor.net/',
        note:
            'Foundational guidance on config, release management, and operational discipline.',
      ),
    ],
  ),
  'sec-1': LessonContent(
    coreIdea:
        'Secrets management is foundational, not optional. Early-stage founders often leak keys, tokens, and credentials because speed feels more urgent than discipline, but one sloppy practice can create outsized risk.',
    whyItMatters:
        'This matters because trust-heavy products fail hard when basic secret handling is careless. A single exposed credential can create service abuse, data exposure, and reputational damage that is massively out of proportion to the founder effort it would have taken to prevent it. Security discipline here is not enterprise theater. It is minimum adult supervision for a live product.',
    timing:
        'This belongs at the beginning of the build phase, before launch and before other people start touching infrastructure. If you already have a working app but cannot confidently state where each secret lives and who can access it, this lesson is immediately active.',
    evidence:
        'This lesson is grounded in standard security practice reflected in OWASP guidance and official cloud secret-management documentation. The repeated principle is simple: secrets should live outside source code, access should be controlled, and exposure should be assumed possible unless you design against it.',
    founderLens:
        'Security basics are like conflict checks and privilege: the boring controls matter because failure is expensive and trust is hard to rebuild.',
    example:
        'An API key sitting in frontend code or a public repo is the startup equivalent of leaving client files in a coffee shop. It is preventable, avoidable, and damaging.',
    steps: [
      'Move credentials into environment variables or a managed secret store.',
      'Limit who and what can access production secrets.',
      'Rotate any key that has ever been exposed carelessly.',
    ],
    watchOuts: [
      'Do not assume obscurity is protection.',
      'Do not share production credentials informally over chat.',
      'Do not use one admin credential for every system.',
    ],
    output:
        'A basic secret-handling policy for local, staging, and production environments.',
    references: [
      LessonReference(
        title: 'OWASP Top 10',
        url: 'https://owasp.org/www-project-top-ten/',
        note:
            'Baseline security risks and principles relevant to any software product.',
      ),
      LessonReference(
        title: 'Google Secret Manager Overview',
        url: 'https://cloud.google.com/security/products/secret-manager',
        note:
            'Official example of managed secret storage and controlled access.',
      ),
    ],
  ),
  'sec-2': LessonContent(
    coreIdea:
        'Least privilege means every user, service, and teammate gets only the access needed to do the current job. This limits blast radius when mistakes happen.',
    whyItMatters:
        'This matters because most startup security problems are not movie-style hacks. They are over-broad permissions, stale admin access, and systems that trust too much by default. If every account can do everything, one mistake can become a product-wide incident.',
    timing:
        'You apply this as soon as multiple services, collaborators, or privileged workflows exist. It is especially relevant before bringing in contractors, connecting third-party tools, or launching features that touch billing, user data, or admin actions.',
    evidence:
        'Least privilege is a foundational security principle across modern security standards and cloud platform guidance. The operational reason is that narrow permissions reduce both accidental damage and the impact of compromised credentials.',
    founderLens:
        'Most early companies are over-permissioned because it feels convenient. Convenience becomes a liability once you have user data, payment access, or outside collaborators.',
    example:
        'A contractor who only needs analytics should not have database admin access. A support user should not be able to delete billing records.',
    steps: [
      'List the people and services touching sensitive systems.',
      'Reduce roles to the narrowest permissions that still allow the work.',
      'Review and remove stale access on a schedule.',
    ],
    watchOuts: [
      'Do not treat admin access as a default starting point.',
      'Do not forget third-party tools and automation accounts.',
      'Do not keep old collaborator permissions active after the project ends.',
    ],
    output: 'A role-access table showing who has what permissions and why.',
    references: [
      LessonReference(
        title: 'OWASP Top 10',
        url: 'https://owasp.org/www-project-top-ten/',
        note:
            'Broad security framework that reinforces access control discipline.',
      ),
      LessonReference(
        title: 'Supabase Security Guides',
        url: 'https://supabase.com/docs/guides/platform/security',
        note:
            'Official security guidance relevant to founder-friendly modern backend stacks.',
      ),
    ],
  ),
  'sec-3': LessonContent(
    coreIdea:
        'Reliability is part of the product promise. Users do not care whether the failure came from infra, code, or process. They only experience downtime, broken trust, and hesitation to return.',
    whyItMatters:
        'This matters because every reliability failure weakens future growth. A buggy or fragile product makes acquisition more expensive, retention weaker, and trust harder to rebuild. Founders often postpone backups, logging, and incident thinking because those tasks feel secondary to feature work, but reliability issues are often what turn a promising product into a stressful mess.',
    timing:
        'This lesson becomes active as soon as you have live users or meaningful pilots. If the product is already storing important information or supporting repeat workflows, reliability is no longer optional.',
    evidence:
        'Software operations guidance repeatedly treats observability, backup, and recovery planning as core operating discipline. The principle is not perfection. It is that live systems need a way to detect failure, preserve critical data, and recover without improvisation.',
    founderLens:
        'Reliability work is not glamorous, but it protects every future sales and retention effort. A shaky product makes marketing more expensive because every acquired user faces more friction.',
    example:
        'If your app loses user input or goes down during onboarding, the customer rarely separates that from your brand. They simply conclude the product is risky.',
    steps: [
      'Identify the top three ways a user can experience failure.',
      'Set up basic logging, uptime monitoring, and backups.',
      'Write a simple incident response checklist before you need it.',
    ],
    watchOuts: [
      'Do not wait for scale to care about backups.',
      'Do not rely on memory during an outage.',
      'Do not optimize features while repeat failures remain unresolved.',
    ],
    output:
        'A reliability checklist covering monitoring, backups, and failure response.',
    references: [
      LessonReference(
        title: 'The Twelve-Factor App',
        url: 'https://12factor.net/',
        note:
            'Foundational operational practices that support cleaner deployment and resilience.',
      ),
      LessonReference(
        title: 'Supabase Security Guides',
        url: 'https://supabase.com/docs/guides/platform/security',
        note:
            'Useful for thinking through platform-side protections and safe operations.',
      ),
    ],
  ),
  'sec-4': LessonContent(
    coreIdea:
        'Privacy can become a competitive advantage when buyers are already nervous about misuse, surveillance, or data leakage. Respectful handling of sensitive information increases trust and reduces friction in sales conversations.',
    whyItMatters:
        'This matters because in trust-heavy categories, buyers are not only buying features. They are buying a comfort level with how their information will be handled. A clear privacy posture can shorten objections, improve conversion, and prevent you from making operational promises you cannot keep.',
    timing:
        'You should work on this before launch messaging, before professional buyers start asking questions, and before you casually accumulate sensitive data you do not truly need.',
    evidence:
        'Privacy-centered product strategy is supported by both legal risk logic and platform guidance that encourages data minimization, clear disclosure, and controlled processing. The core business insight is that disciplined data handling can become part of the value proposition.',
    founderLens:
        'For lawyers and other trust-heavy buyers, privacy is not an edge case. It is part of the buying calculus and the reputational layer around the product.',
    example:
        'A founder selling workflow tools to legal teams can differentiate by clearly stating what data is stored, who can access it, and what is never used for model training.',
    steps: [
      'Write a plain-language explanation of what data you collect and why.',
      'Decide what sensitive data you should not store at all.',
      'Make privacy claims only when operations support them.',
    ],
    watchOuts: [
      'Do not copy privacy language you cannot operationally honor.',
      'Do not collect more data than the workflow requires.',
      'Do not treat privacy concerns as irrational buyer resistance.',
    ],
    output:
        'A privacy statement buyers can read and understand without legal translation.',
    references: [
      LessonReference(
        title: 'OWASP Top 10',
        url: 'https://owasp.org/www-project-top-ten/',
        note:
            'Broad security thinking that supports disciplined handling of sensitive user data.',
      ),
      LessonReference(
        title: 'Google Secret Manager Overview',
        url: 'https://cloud.google.com/security/products/secret-manager',
        note:
            'Relevant to the operational side of protecting sensitive configuration and access.',
      ),
    ],
  ),
  'dist-1': LessonContent(
    coreIdea:
        'Distribution starts with helping the buyer find your answer in the exact moments they are searching for it. Useful, direct, answer-shaped content often beats broad SEO vanity plays for solo founders.',
    whyItMatters:
        'This matters because a good product still loses if the right buyer never encounters it in a usable form. Early distribution is not about reach for its own sake. It is about earning qualified attention from people who already feel the problem and are looking for relief or direction.',
    timing:
        'You work on this as soon as you have a problem statement, an ICP, and a credible offer. It becomes especially urgent before spending on paid acquisition, because organic answer-shaped content clarifies what buyers respond to and what language they use.',
    evidence:
        'Google’s own guidance rewards helpful, people-first content that genuinely answers user needs. Practical startup writing from Paul Graham also reinforces the broader principle that early growth often comes from direct, non-scalable contact with real users rather than polished but generic mass messaging.',
    founderLens:
        'AEO here means writing for search intent and answer retrieval, not for keyword theater. The goal is to become the clearest answer to a narrow high-intent problem.',
    example:
        'A page titled "How solo attorneys stop missing follow-up deadlines" is stronger than a generic homepage claiming to be an all-in-one legal productivity system.',
    steps: [
      'List the exact questions your buyer types or asks when the pain peaks.',
      'Turn those questions into landing pages, articles, or demos with direct answers.',
      'Measure whether the traffic is qualified, not just whether it is large.',
    ],
    watchOuts: [
      'Do not chase broad high-volume terms too early.',
      'Do not write content disconnected from the product promise.',
      'Do not mistake impressions for useful traffic.',
    ],
    output:
        'One high-intent page that answers a buyer problem clearly and ties directly to your offer.',
    references: [
      LessonReference(
        title:
            'Google Search Central: Creating Helpful, Reliable, People-First Content',
        url:
            'https://developers.google.com/search/docs/fundamentals/creating-helpful-content',
        note:
            'Official Google guidance on building content that serves user needs rather than search manipulation.',
      ),
      LessonReference(
        title: 'Paul Graham: Do Things that Don’t Scale',
        url: 'https://paulgraham.com/ds.html',
        note:
            'Classic startup essay on direct early growth tactics and close contact with users.',
      ),
    ],
  ),
  'dist-2': LessonContent(
    coreIdea:
        'The right channel depends on stage. Early founders need channels that create direct learning and controlled tests, not channels that look prestigious from a distance.',
    whyItMatters:
        'Channel choice matters because every channel teaches different things at different costs. A founder with limited time should prefer channels that generate conversations, objections, and message refinement before moving to more expensive systems that optimize volume.',
    timing:
        'Use this lesson whenever you are tempted to spread effort across multiple channels or copy the playbook of a larger company. At the beginning, one learning-rich channel beats five partially maintained channels almost every time.',
    evidence:
        'Search-platform guidance, startup field practice, and growth writing all point toward the same principle: channel choice should fit the stage of uncertainty. Early on, founders need feedback density more than scale efficiency.',
    founderLens:
        'A founder with limited time should prefer channels that create conversations, objections, and buyer language. Prestige channels are often expensive detours.',
    example:
        'Cold outreach, founder-led content, niche communities, and targeted demos often outperform expensive broad paid acquisition at the start.',
    steps: [
      'Pick one primary acquisition channel for the next sprint.',
      'Define what signal that channel should generate.',
      'Stay with it long enough to learn before jumping to another channel.',
    ],
    watchOuts: [
      'Do not select channels based on ego or what bigger startups do.',
      'Do not run five channels badly instead of one channel well.',
      'Do not judge channel quality without defining the stage-appropriate metric.',
    ],
    output:
        'A single-channel distribution plan with target signal, cadence, and review metric.',
    references: [
      LessonReference(
        title: 'Google SEO Starter Guide',
        url:
            'https://developers.google.com/search/docs/fundamentals/seo-starter-guide',
        note: 'Official guidance on discoverability and search fundamentals.',
      ),
      LessonReference(
        title: 'Paul Graham: Do Things that Don’t Scale',
        url: 'https://paulgraham.com/ds.html',
        note:
            'Supports the early-stage idea that direct, scrappy channels often beat seemingly scalable ones.',
      ),
    ],
  ),
  'dist-3': LessonContent(
    coreIdea:
        'Creative testing is a loop: idea, asset, distribution, measurement, revision. Most founders quit too early or change too many variables at once to learn anything useful.',
    whyItMatters:
        'This matters because marketing becomes noise when you cannot isolate what worked. Without disciplined creative testing, founders end up confusing audience mismatch, weak hooks, and bad offers. A testing loop turns marketing into a learning system rather than a sequence of random posts and ads.',
    timing:
        'This lesson becomes active once you have one channel worth testing and enough consistency to compare messages. If every campaign looks different and nothing is logged, you need this now.',
    evidence:
        'Platform guidance from advertising systems and broader experimentation practice both support controlled iteration. The common thread is simple: change fewer variables, observe the effect, and accumulate evidence rather than stories.',
    founderLens:
        'You are not looking for one perfect creative. You are trying to learn what framing, pain, proof, and audience angle get attention from the right people.',
    example:
        'Three outreach angles to the same ICP might test time savings, missed deadlines, or workflow chaos. The winning angle tells you what pain the buyer prioritizes.',
    steps: [
      'Test one variable at a time, such as hook, audience, or CTA.',
      'Use a fixed review window before deciding whether to iterate or stop.',
      'Log what changed and what result followed.',
    ],
    watchOuts: [
      'Do not declare failure after one asset.',
      'Do not change the hook, audience, and offer all at once.',
      'Do not optimize for vanity engagement if the goal is qualified leads.',
    ],
    output:
        'A simple creative test log showing what was tested, what changed, and what signal improved.',
    references: [
      LessonReference(
        title: 'Meta Ads Guide',
        url: 'https://www.facebook.com/business/ads-guide',
        note:
            'Official ad examples and campaign structures useful for understanding message variations and testing.',
      ),
      LessonReference(
        title:
            'Google Search Central: Creating Helpful, Reliable, People-First Content',
        url:
            'https://developers.google.com/search/docs/fundamentals/creating-helpful-content',
        note:
            'Supports the principle that content should be built around user usefulness, not content churn.',
      ),
    ],
  ),
  'dist-4': LessonContent(
    coreIdea:
        'Retention changes the economics of acquisition. If users stick, acquisition spend can work harder. If they churn fast, growth becomes a leaking bucket.',
    whyItMatters:
        'This matters because growth is not just getting more people in the door. If the post-signup experience fails, then traffic quality, channel efficiency, and even pricing become harder to interpret. Retention is one of the clearest signals that the product actually delivers on the acquisition promise.',
    timing:
        'You focus on this once people are arriving and some are dropping away before they get real value. It is especially urgent before increasing paid spend or broadening distribution, because more traffic into a leaky experience magnifies waste.',
    evidence:
        'Analytics and product-growth practice consistently treat downstream behavior as essential to evaluating acquisition quality. In practical terms, acquisition only compounds when the product retains users long enough to justify the cost of getting them.',
    founderLens:
        'Distribution and retention are not separate worlds. Weak retention usually means your message is off, your onboarding is weak, or the product does not produce value fast enough.',
    example:
        'If users sign up from strong top-of-funnel content but disappear after day two, the problem is not solved by more content. It is solved by faster time-to-value and better message matching.',
    steps: [
      'Track what percentage of new users reach the first real value moment.',
      'Compare acquisition promises to the actual first-use experience.',
      'Fix retention blockers before scaling spend aggressively.',
    ],
    watchOuts: [
      'Do not buy more traffic into a broken post-signup experience.',
      'Do not treat churn as a separate team problem.',
      'Do not assume acquisition success if buyers do not stay.',
    ],
    output:
        'A short retention diagnosis naming the first value moment and the top reasons users fail to reach it.',
    references: [
      LessonReference(
        title: 'Google Analytics Help: Funnel Exploration',
        url: 'https://support.google.com/analytics/answer/9327974?hl=en',
        note:
            'Official Google Analytics guidance on visualizing where users drop through a funnel.',
      ),
      LessonReference(
        title: 'Google Analytics Help: Create Custom Funnel Reports',
        url: 'https://support.google.com/analytics/answer/13012015?hl=en',
        note:
            'Useful for understanding how to turn retention and drop-off analysis into an operating view.',
      ),
    ],
  ),
  'fc-1': LessonContent(
    coreIdea:
        'A funnel is the sequence of decisions and frictions a buyer moves through from awareness to value. If you do not map it, you cannot diagnose where momentum is being lost.',
    whyItMatters:
        'This matters because founders often react to symptoms instead of diagnosing the actual choke point. Funnel mapping turns vague frustration into a sequence you can inspect. Once you know where the major drop happens, you can prioritize the fix instead of making random improvements everywhere.',
    timing:
        'Do this as soon as you have meaningful traffic, demos, trials, or signups moving through a path. If people are touching the offer but not reaching value or purchase, you need a funnel view now.',
    evidence:
        'Analytics systems formalize funnel analysis because sequential behavior matters more than isolated counts. In practice, founders learn more from stage-to-stage drop-off than from top-line traffic because the sequence reveals where trust, clarity, or usability is failing.',
    founderLens:
        'Founders often focus on top-of-funnel volume because it is visible, but conversion work begins with understanding the full path from first touch to successful outcome.',
    example:
        'A simple funnel might be: sees offer, clicks page, books demo, signs up, completes setup, reaches first value, pays.',
    steps: [
      'Write every major stage from first touch to successful use.',
      'Assign one measurable signal to each stage.',
      'Find the stage with the biggest meaningful drop-off.',
    ],
    watchOuts: [
      'Do not call everything a funnel stage if it is not a decision point.',
      'Do not track so many metrics that you stop seeing the bottleneck.',
      'Do not optimize the wrong stage because it is easier to tweak.',
    ],
    output:
        'A funnel map with stage names, conversion signals, and one visible bottleneck.',
    references: [
      LessonReference(
        title: 'Google Analytics Help: Funnel Exploration',
        url: 'https://support.google.com/analytics/answer/9327974?hl=en',
        note: 'Official funnel-analysis guidance from GA4.',
      ),
      LessonReference(
        title: 'Google Analytics Help: Create Custom Funnel Reports',
        url: 'https://support.google.com/analytics/answer/13012015?hl=en',
        note:
            'Shows how stage-by-stage conversion data can be structured and reviewed.',
      ),
    ],
  ),
  'fc-2': LessonContent(
    coreIdea:
        'Message match means the promise that brought the buyer in matches the experience they receive next. When message match breaks, conversion drops because trust drops.',
    whyItMatters:
        'This matters because buyers decide quickly whether the next step feels consistent with the reason they clicked. When the message shifts from buyer problem to founder-centered language, trust decays. Message match is therefore not just copy polish. It is part of the conversion mechanism.',
    timing:
        'Use this lesson whenever a page gets clicks but weak progression, or when demos and signups feel lower than the initial interest suggests. It is especially relevant during landing-page iteration, outreach campaigns, and paid or search traffic tests.',
    evidence:
        'Search and analytics practice repeatedly reward relevance between user intent and destination content. The more directly a destination fulfills the expectation created upstream, the better the buyer can continue without reinterpreting your offer from scratch.',
    founderLens:
        'If the ad, article, or outreach promises one thing and the landing page or product says another, the buyer feels the mismatch immediately even if they cannot articulate it.',
    example:
        'If your ad promises faster client intake but the landing page talks mostly about AI innovation, you have lost the thread the buyer cared about.',
    steps: [
      'Write the primary promise at each funnel stage.',
      'Check whether the next stage reinforces or weakens that promise.',
      'Remove copy and visuals that distract from the buying reason.',
    ],
    watchOuts: [
      'Do not let branding language replace the buyer problem.',
      'Do not send cold traffic to generic pages.',
      'Do not add new features to fix a copy mismatch.',
    ],
    output:
        'A message-match review showing the promise at each step and where it currently breaks.',
    references: [
      LessonReference(
        title:
            'Google Search Central: Creating Helpful, Reliable, People-First Content',
        url:
            'https://developers.google.com/search/docs/fundamentals/creating-helpful-content',
        note:
            'Useful for aligning content with user intent rather than internal jargon.',
      ),
      LessonReference(
        title: 'Google Analytics Help: Funnel Exploration',
        url: 'https://support.google.com/analytics/answer/9327974?hl=en',
        note:
            'Helpful for spotting where message mismatch likely causes drop-off.',
      ),
    ],
  ),
  'fc-3': LessonContent(
    coreIdea:
        'Most early conversion gains come from removing friction, not adding more features. Every extra field, delay, or unclear instruction taxes the buyer.',
    whyItMatters:
        'This matters because every unnecessary step imposes a hidden tax on attention and trust. Founders often misread conversion problems as proof they need more product. In reality, many early improvements come from subtraction: fewer steps, fewer decisions, less ambiguity, less waiting.',
    timing:
        'You work on this once the basic offer is understandable and users are trying to move through the path. If people begin but fail to finish, or if onboarding feels heavy relative to the promised payoff, this lesson is immediate.',
    evidence:
        'Conversion and UX practice consistently show that excess complexity depresses progression. The operational lesson is not that every flow must be minimal at all costs, but that every added requirement must justify the friction it introduces.',
    founderLens:
        'Friction is not only technical. It also includes uncertainty, ambiguity, unnecessary choices, and emotional hesitation.',
    example:
        'A signup form asking for ten fields and a phone number creates more friction than a two-step start that proves value quickly.',
    steps: [
      'Walk the core user journey and note every point of delay or confusion.',
      'Remove anything not required to reach first value.',
      'Test the cleaned-up flow before adding more product surface area.',
    ],
    watchOuts: [
      'Do not use feature additions to avoid fixing UX friction.',
      'Do not ask for data before the user understands the payoff.',
      'Do not ignore mobile or low-attention conditions.',
    ],
    output:
        'A friction list prioritized by what blocks the first value moment most.',
    references: [
      LessonReference(
        title: 'Google Analytics Help: Funnel Exploration',
        url: 'https://support.google.com/analytics/answer/9327974?hl=en',
        note:
            'Useful for locating where friction is likely causing user drop-off.',
      ),
      LessonReference(
        title: 'Google Analytics Help: Create Custom Funnel Reports',
        url: 'https://support.google.com/analytics/answer/13012015?hl=en',
        note:
            'Helps translate user movement into measurable funnel stages for friction analysis.',
      ),
    ],
  ),
  'fc-4': LessonContent(
    coreIdea:
        'Onboarding should create momentum fast. The user should feel progress, orientation, and confidence within the first session, not after a long setup ritual.',
    whyItMatters:
        'This matters because the first-use experience is the product proving its case. If the buyer expends energy before seeing payoff, they start discounting the promise. Fast momentum is especially important for founder-led products where you do not yet have brand trust to compensate for roughness.',
    timing:
        'This becomes critical once new users are arriving and failing to reach the first meaningful result. If setup feels longer than the buyer’s patience window, or if the product asks for commitment before demonstrating usefulness, this lesson belongs in the current sprint.',
    evidence:
        'Product-growth practice and analytics both emphasize the importance of the first value moment as a predictor of activation and retention. The repeated operating lesson is that onboarding should be judged by how quickly it gets the user to value, not by how thoroughly it introduces every feature.',
    founderLens:
        'The first win is the product’s opening argument. If the buyer does not experience that win quickly, they rarely stay around long enough to appreciate your roadmap.',
    example:
        'A task-management product for attorneys should help the user create and trust one live workflow quickly, not bury them under configuration.',
    steps: [
      'Define the first value moment in one sentence.',
      'Strip onboarding down to what is needed to reach that moment.',
      'Use prompts, defaults, or guided examples to reduce hesitation.',
    ],
    watchOuts: [
      'Do not confuse setup completion with value.',
      'Do not overwhelm the user with optional configuration.',
      'Do not leave the first session without a visible success state.',
    ],
    output:
        'A first-session onboarding path that gets the user to one meaningful result fast.',
    references: [
      LessonReference(
        title: 'Google Analytics Help: Funnel Exploration',
        url: 'https://support.google.com/analytics/answer/9327974?hl=en',
        note:
            'Supports measuring the first-value path rather than relying on intuition.',
      ),
      LessonReference(
        title: 'Google Analytics Help: Create Custom Funnel Reports',
        url: 'https://support.google.com/analytics/answer/13012015?hl=en',
        note:
            'Useful for designing and monitoring activation steps in sequence.',
      ),
    ],
  ),
  'mon-1': LessonContent(
    coreIdea:
        'Pricing should anchor to the value or risk reduction you create, not just the time or effort you spent building. Buyers pay for outcomes that matter to them.',
    whyItMatters:
        'This matters because cost-based thinking systematically undervalues products that remove expensive pain. Buyers judge a price against the value of the result, the cost of the current workaround, and the risk of not acting. Founders who price only from effort often train the market to see the product as smaller than its actual economic usefulness.',
    timing:
        'You apply this lesson once the problem and buyer are becoming clear enough to discuss money honestly. It is especially important before publishing a pricing page, offering pilots, or defaulting to low prices out of founder discomfort.',
    evidence:
        'Pricing scholarship and modern payments guidance alike emphasize the logic of value capture rather than mere cost recovery. In practical terms, stronger pricing decisions start by understanding what the buyer gains, avoids, or accelerates by using the product.',
    founderLens:
        'Early founders often underprice because they compare against their own labor rather than the buyer’s upside, savings, or avoidance of pain.',
    example:
        'If your tool prevents missed deadlines and saves several hours per week, pricing should reflect avoided risk and recovered time, not just your hosting costs.',
    steps: [
      'Define the business or personal result the buyer gets.',
      'Estimate the value of that result in money, time, or risk reduction.',
      'Set pricing that captures a fair fraction of the value created.',
    ],
    watchOuts: [
      'Do not price from fear alone.',
      'Do not anchor only to competitor pricing without understanding positioning.',
      'Do not talk about your effort when the buyer cares about their result.',
    ],
    output:
        'A short pricing rationale tied to buyer outcome instead of founder effort.',
    references: [
      LessonReference(
        title: 'Harvard Business Review: A Quick Guide to Value-Based Pricing',
        url: 'https://hbr.org/2021/08/a-quick-guide-to-value-based-pricing',
        note:
            'Concise source on anchoring price to value delivered instead of internal cost.',
      ),
      LessonReference(
        title: 'Stripe: Pricing Models Explained',
        url:
            'https://stripe.com/resources/more/pricing-models-explained-types-of-pricing-models-and-when-to-use-them',
        note:
            'Practical framework for thinking about value capture and pricing structure.',
      ),
    ],
  ),
  'mon-2': LessonContent(
    coreIdea:
        'The pricing model should fit how the product delivers value. Subscription, one-time purchase, usage-based, and service-backed models each fit different products and buyer expectations.',
    whyItMatters:
        'This matters because the wrong pricing model creates friction even when the number itself is acceptable. Buyers use the pricing structure to infer what kind of commitment the product requires and how risk is allocated. If the model feels mismatched to how value arrives, trust and willingness to proceed both fall.',
    timing:
        'Work on this after clarifying the offer but before hard-coding pricing into the product and sales flow. It becomes especially important when you notice buyers understanding the outcome but hesitating at the packaging.',
    evidence:
        'Payments and monetization guidance consistently ties model choice to frequency of use, predictability of value, and buyer preference for simplicity. The core logic is to align the commercial structure with the shape of the benefit.',
    founderLens:
        'The wrong pricing model creates buyer confusion and internal operating pain even when the price itself is reasonable.',
    example:
        'A repeat-use workflow tool often fits subscription pricing. A fixed template library or one-time implementation kit may fit one-time or tiered pricing better.',
    steps: [
      'Match the pricing model to usage frequency and buyer expectation.',
      'Check whether the model is easy for the buyer to understand quickly.',
      'Avoid pricing complexity until the simpler version breaks.',
    ],
    watchOuts: [
      'Do not add multiple pricing variables too early.',
      'Do not force subscription on a one-time outcome product without reason.',
      'Do not copy pricing structures from products with different usage patterns.',
    ],
    output:
        'A chosen pricing model and one-paragraph explanation for why it fits the product.',
    references: [
      LessonReference(
        title: 'Stripe: Pricing Models Explained',
        url:
            'https://stripe.com/resources/more/pricing-models-explained-types-of-pricing-models-and-when-to-use-them',
        note:
            'Useful overview of common pricing structures and the business cases they fit.',
      ),
      LessonReference(
        title: 'Stripe: Usage-Based Pricing Guide',
        url:
            'https://stripe.com/resources/more/usage-based-pricing-how-it-works-benefits-and-examples',
        note:
            'Helpful for thinking through fit between value delivery and pricing mechanism.',
      ),
    ],
  ),
  'mon-3': LessonContent(
    coreIdea:
        'Willingness to pay is discovered through conversations, tests, and actual asks. Founders learn pricing faster by putting numbers in front of buyers than by privately speculating.',
    whyItMatters:
        'This matters because founder intuition about price is usually distorted by fear, projection, and comparison to personal effort. The market teaches faster than internal debate. Real pricing learning happens when a buyer reacts to a concrete ask and reveals where the offer feels expensive, cheap, confusing, or obviously worth it.',
    timing:
        'Use this lesson once you have a clear enough offer to test with live prospects. It is especially important before assuming you need to discount, and before deciding that the market is price-sensitive without observing actual reactions.',
    evidence:
        'Pricing literature and practical startup sales experience both support direct market testing over abstract hypotheticals. The discipline is simple: make a real ask, observe behavior, and record objections rather than reading the market through your own anxiety.',
    founderLens:
        'Pricing discomfort is normal. Avoiding the conversation keeps you blind. The market teaches faster than founder guesswork.',
    example:
        'A buyer who says the problem is severe but resists every paid solution may not be your customer, or the product may not yet feel valuable enough.',
    steps: [
      'Ask prospects what they currently spend in money or time on the problem.',
      'Test price points in calls, pages, or pilot offers.',
      'Record objections without immediately discounting.',
    ],
    watchOuts: [
      'Do not ask abstract pricing questions without context.',
      'Do not treat every pricing objection as proof the price is wrong.',
      'Do not hide the price forever while claiming to be validating.',
    ],
    output:
        'A pricing evidence log with reactions, objections, and likely ranges.',
    references: [
      LessonReference(
        title: 'Harvard Business Review: A Quick Guide to Value-Based Pricing',
        url: 'https://hbr.org/2021/08/a-quick-guide-to-value-based-pricing',
        note: 'Helps anchor price conversations to value, not guesswork.',
      ),
      LessonReference(
        title: 'Stripe: Pricing Models Explained',
        url:
            'https://stripe.com/resources/more/pricing-models-explained-types-of-pricing-models-and-when-to-use-them',
        note:
            'Useful for testing concrete pricing structures rather than abstract numbers alone.',
      ),
    ],
  ),
  'mon-4': LessonContent(
    coreIdea:
        'Pricing is also messaging. The way you frame tiers, limits, and names changes how buyers interpret value and self-select into offers.',
    whyItMatters:
        'This matters because buyers do not encounter price as a raw number. They encounter it as a story about fit, identity, and expected value. Tier names, feature grouping, and recommended options all shape whether a buyer quickly recognizes where they belong.',
    timing:
        'This lesson matters once you are moving from an improvised offer into a repeatable pricing page, rate card, or sales deck. It becomes critical whenever buyers seem confused about which option fits them or why tiers differ.',
    evidence:
        'Behavioral and pricing practice both show that framing changes choice. The startup lesson is not to manipulate buyers, but to make the pricing architecture legible enough that the right buyer can self-sort without friction.',
    founderLens:
        'A well-framed price can make the right buyer feel clarity. A badly framed price can make even a strong offer feel risky or confusing.',
    example:
        'A "Solo Practice" tier and a "Small Firm" tier communicate fit better than vague labels like Basic and Pro when the buyer is trying to locate themselves quickly.',
    steps: [
      'Name plans based on buyer identity, scale, or outcome.',
      'State what each tier unlocks in plain language.',
      'Use messaging to make the default choice obvious when appropriate.',
    ],
    watchOuts: [
      'Do not create tiers with arbitrary clutter.',
      'Do not make the buyer decode the packaging.',
      'Do not hide the best-fit plan behind internal product language.',
    ],
    output: 'A pricing page structure that communicates fit, not just numbers.',
    references: [
      LessonReference(
        title: 'Harvard Business Review: A Quick Guide to Value-Based Pricing',
        url: 'https://hbr.org/2021/08/a-quick-guide-to-value-based-pricing',
        note:
            'Useful for thinking about how price communication affects perceived value.',
      ),
      LessonReference(
        title: 'Stripe: Pricing Models Explained',
        url:
            'https://stripe.com/resources/more/pricing-models-explained-types-of-pricing-models-and-when-to-use-them',
        note:
            'Helps translate value logic into buyer-facing pricing structure.',
      ),
    ],
  ),
  'fos-1': LessonContent(
    coreIdea:
        'The founder should work the bottleneck, not whatever feels productive. The bottleneck is the single constraint most limiting learning, revenue, or delivery right now.',
    whyItMatters:
        'This matters because founder time is the scarcest resource in the company. If attention is diffused across low-leverage work, the business can feel busy while remaining structurally stuck. The bottleneck lens forces prioritization around the one constraint that most improves momentum when relieved.',
    timing:
        'This is a weekly operating lesson, not a one-time insight. You use it whenever the company feels overloaded, when progress is slower than effort suggests, or when too many priorities are competing for attention.',
    evidence:
        'Constraint-based thinking has deep roots in operations and execution practice. Across startup and operating literature, the pattern is consistent: progress compounds when leadership focuses on the limiting factor instead of managing every problem at once.',
    founderLens:
        'When attention is fragmented, progress becomes cosmetic. The founder job is to identify the slowest, most consequential point in the system and attack it directly.',
    example:
        'If leads are coming in but nobody converts, the bottleneck is not feature velocity. It is likely offer clarity, qualification, or conversion flow.',
    steps: [
      'List the main places work or learning gets stuck.',
      'Choose the one constraint that would unlock the most progress.',
      'Focus the week around that constraint before moving to secondary work.',
    ],
    watchOuts: [
      'Do not confuse urgent inbox work with the true bottleneck.',
      'Do not rotate focus daily with no throughline.',
      'Do not let polishing consume time while constraint work stays undone.',
    ],
    output:
        'A written statement of the current bottleneck and the next action to relieve it.',
    references: [
      LessonReference(
        title: 'Basecamp Shape Up',
        url: 'https://basecamp.com/shapeup',
        note:
            'Practical execution framework that helps founders focus work and reduce drift.',
      ),
      LessonReference(
        title: 'Paul Graham Essays',
        url: 'https://paulgraham.com/articles.html',
        note:
            'Useful source material on founder focus, prioritization, and startup judgment.',
      ),
    ],
  ),
  'fos-2': LessonContent(
    coreIdea:
        'Learning and building are both necessary, but they are not the same mode. Founders stall when they claim to be learning while actually avoiding contact with users, or when they build without first reducing uncertainty.',
    whyItMatters:
        'This matters because startup work constantly tempts you into false productivity. Endless reading, overbuilding, and maintenance sprawl can all masquerade as meaningful work. Separating modes helps you decide whether you are gathering evidence, creating product, selling, or simply staying occupied.',
    timing:
        'Use this lesson during weekly planning and anytime you feel like you are working hard but not becoming clearer. It is especially useful in early-stage companies where uncertainty is high and the proper mix of learning and building changes by stage.',
    evidence:
        'Customer-development and experiment-driven startup methods both depend on distinguishing discovery from delivery. The reason is straightforward: the activity that reduces uncertainty is not always the same as the activity that ships product.',
    founderLens:
        'The right ratio changes by stage. Early on, learning usually deserves more time than building because uncertainty is still high.',
    example:
        'If you do not know whether buyers care, more engineering is often avoidance. If the problem is validated and the workflow is clear, endless reading can also become avoidance.',
    steps: [
      'Label work as learn, build, sell, or maintain.',
      'Check whether your week reflects the current stage of uncertainty.',
      'Cut any activity that feels productive but produces no decision or artifact.',
    ],
    watchOuts: [
      'Do not call internet consumption research if it changes nothing.',
      'Do not hide from uncertainty by endlessly polishing the product.',
      'Do not spend founder time where a template or automation would do.',
    ],
    output:
        'A weekly plan showing what time is for learning, building, selling, and maintenance.',
    references: [
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Supports the distinction between discovery work and execution work.',
      ),
      LessonReference(
        title: 'Basecamp Shape Up',
        url: 'https://basecamp.com/shapeup',
        note:
            'Practical operating model for clarifying scopes, responsibilities, and focused execution.',
      ),
    ],
  ),
  'fos-3': LessonContent(
    coreIdea:
        'Experiments beat vibes. An experiment states the change, the expected effect, the metric, and the review date. Without that structure, founders create stories instead of evidence.',
    whyItMatters:
        'This matters because businesses become more rational when the founder can tell the difference between a hypothesis and a hope. Clear experiments reduce narrative drift, force metric discipline, and make it easier to learn from failure without rewriting history.',
    timing:
        'This lesson matters whenever you are changing offers, pages, onboarding, pricing, or channels and want to know whether the change helped. If you are making repeated adjustments without a defined hypothesis and review date, you need this immediately.',
    evidence:
        'Experiment-led operating practice is standard across product, growth, and startup methods. The shared principle is that small, well-defined tests generate better learning than broad, emotionally interpreted changes.',
    founderLens:
        'You are building a company, not just reacting to feelings. That means your hypotheses should be testable and your review discipline honest.',
    example:
        'Instead of "we should improve the page," a real experiment says, "Changing the hero to emphasize time saved should increase demo bookings from qualified solo attorneys over the next two weeks."',
    steps: [
      'Write the hypothesis, the intervention, and the metric before shipping.',
      'Set a review window and avoid midstream reinterpretation.',
      'Capture what you learned even when the experiment fails.',
    ],
    watchOuts: [
      'Do not run undefined experiments where success is subjective.',
      'Do not change metrics after seeing weak results.',
      'Do not discard failed tests without extracting the lesson.',
    ],
    output:
        'A one-page experiment brief with hypothesis, metric, owner, and review date.',
    references: [
      LessonReference(
        title: 'Atlassian Experiment Guide',
        url:
            'https://www.atlassian.com/continuous-delivery/principles/experiment',
        note: 'Practical explanation of experiment design and learning loops.',
      ),
      LessonReference(
        title: 'Steve Blank: Customer Development Flow',
        url: 'https://steveblank.com/customer-development-flow/',
        note:
            'Supports the use of explicit hypotheses and real-world tests in startup learning.',
      ),
    ],
  ),
  'fos-4': LessonContent(
    coreIdea:
        'A weekly review is where the founder converts activity into judgment. The point is not self-criticism. The point is to inspect signal, decide what matters next, and stop drifting.',
    whyItMatters:
        'This matters because without review, founders repeat weak weeks. The review is where motion is separated from progress, where signal is named explicitly, and where the next week is shaped by evidence instead of emotional carryover.',
    timing:
        'This belongs at the end of every week. It becomes even more important when the company is moving quickly, because unreviewed speed often produces confusion rather than disciplined progress.',
    evidence:
        'Execution systems across product and operating disciplines rely on regular retrospection because judgment improves when actions, outcomes, and surprises are examined on a cadence. The founder version of that principle is the weekly review.',
    founderLens:
        'Most bad weeks repeat because they are never examined honestly. Review is where you separate motion from progress.',
    example:
        'A strong review notes what was built, what was learned, what signal changed, what bottleneck emerged, and what to stop doing next week.',
    steps: [
      'Block recurring time for review instead of doing it ad hoc.',
      'Review actions, results, surprises, and waste.',
      'End with one clear focus for the next week.',
    ],
    watchOuts: [
      'Do not turn review into guilt journaling.',
      'Do not skip the stop-doing list.',
      'Do not carry forward stale priorities automatically.',
    ],
    output:
        'A weekly review note with wins, lessons, bottleneck, stop list, and next focus.',
    references: [
      LessonReference(
        title: 'Basecamp Shape Up',
        url: 'https://basecamp.com/shapeup',
        note:
            'Useful operating framework for periodic review and focused planning.',
      ),
      LessonReference(
        title: 'Paul Graham Essays',
        url: 'https://paulgraham.com/articles.html',
        note:
            'Relevant reading on founder judgment, work quality, and startup focus.',
      ),
    ],
  ),
  'pst-1': LessonContent(
    coreIdea:
        'Sometimes a template, toolkit, or productized service beats SaaS because the buyer wants a faster, lower-friction result without ongoing software adoption. The right product form depends on the job and buying behavior.',
    whyItMatters:
        'This matters because founders often assume software is the superior product form by default. In reality, the right commercial shape depends on how the buyer wants to consume value. Sometimes a template, training asset, or productized service solves the problem faster, with lower support burden and less adoption friction.',
    timing:
        'This lesson becomes active when you know the buyer problem but are still deciding whether to sell software, a digital product, a repeatable service, or a hybrid. It is also relevant when building SaaS starts to look heavier than the value really requires.',
    evidence:
        'Commercial practice across digital products and creator-led businesses shows that product form strongly affects adoption, support burden, and monetization. The founder lesson is to match the product format to buyer behavior rather than to startup prestige.',
    founderLens:
        'Not every problem deserves software. Some buyers prefer an asset, a playbook, or a service package because it gets them to value faster.',
    example:
        'A lawyer who needs a repeatable client onboarding system may buy a document set, workflow template, and implementation guide long before adopting a new platform.',
    steps: [
      'Ask whether the buyer needs a system they will use repeatedly or a result they can apply once.',
      'Compare support burden, price point, and time-to-value across product forms.',
      'Choose the form that best matches buyer behavior, not founder identity.',
    ],
    watchOuts: [
      'Do not force SaaS because it sounds more scalable.',
      'Do not ignore support complexity in low-ticket digital products.',
      'Do not overlook productized services as a valid path to revenue and learning.',
    ],
    output:
        'A product-form decision explaining why this should be software, a digital product, or a productized service.',
    references: [
      LessonReference(
        title: 'Shopify Digital Products Guide',
        url: 'https://www.shopify.com/blog/digital-products',
        note:
            'Practical guidance on productized digital offerings and how they are sold.',
      ),
      LessonReference(
        title: 'Gumroad Creator Resources',
        url: 'https://gumroad.com/blog',
        note:
            'Useful for understanding digital-product economics and delivery tradeoffs.',
      ),
    ],
  ),
  'pst-2': LessonContent(
    coreIdea:
        'Packaging means turning your work into a clear buyer-facing outcome with defined scope, boundaries, and deliverables. Good packaging reduces buyer uncertainty and founder chaos.',
    whyItMatters:
        'This matters because unstructured offers create scope creep, weak sales conversations, and operational fatigue. Packaging is what turns raw capability into something a buyer can understand, compare, and purchase with confidence.',
    timing:
        'You need this lesson when moving from custom one-off work into a repeatable offer, or whenever prospects seem interested but confused about what they are actually buying.',
    evidence:
        'Productized-service and digital-product businesses consistently rely on clear packaging because buyers make faster decisions when the scope, result, and boundaries are explicit. Operationally, packaging protects margin as much as it improves sales clarity.',
    founderLens:
        'If the buyer cannot tell what they get, how it helps, and what is not included, the offer is still underpackaged.',
    example:
        'A vague offer like "growth support" becomes clearer as "90-day founder messaging sprint with three positioning revisions, one landing page structure, and one distribution plan."',
    steps: [
      'Name the outcome first, then list what is included.',
      'State what is not included to avoid silent scope creep.',
      'Package deliverables so the buyer can picture the handoff.',
    ],
    watchOuts: [
      'Do not rely on private understanding instead of explicit scope.',
      'Do not leave the timeline or deliverables ambiguous.',
      'Do not package around tasks when the buyer wants outcomes.',
    ],
    output:
        'A packaged offer with outcome, deliverables, boundaries, and timeline.',
    references: [
      LessonReference(
        title: 'Shopify Digital Products Guide',
        url: 'https://www.shopify.com/blog/digital-products',
        note:
            'Useful for translating expertise into structured buyer-facing products.',
      ),
      LessonReference(
        title: 'Gumroad Creator Resources',
        url: 'https://gumroad.com/blog',
        note: 'Relevant to packaging, delivery, and repeatable digital offers.',
      ),
    ],
  ),
  'pst-3': LessonContent(
    coreIdea:
        'Licensing and usage boundaries protect margin and reduce future conflict. This matters more when you sell templates, assets, documents, or systems that can be reused widely.',
    whyItMatters:
        'This matters because unclear rights language quietly destroys commercial control. If the buyer does not know what can be copied, reused, shared, or resold, you are inviting disputes and underpricing expanded usage without noticing it.',
    timing:
        'Use this lesson before selling templates, educational assets, document systems, or repeatable digital deliverables at scale. If usage rights are still informal, this lesson is overdue.',
    evidence:
        'Licensing practice exists because product rights are part of the economic design of the offer. The founder insight is that rights clarity is not legal decoration; it is part of the monetization model and part of the support boundary.',
    founderLens:
        'Clear rights language is product design, not just legal cleanup. Buyers need clarity on what they can use, copy, modify, and redistribute.',
    example:
        'A template bundle may allow internal business use but prohibit resale, sharing across client organizations, or white-label redistribution without a higher tier.',
    steps: [
      'Decide what rights the base product includes.',
      'Define where broader rights justify higher pricing.',
      'Write the license in plain business language before legal refinement.',
    ],
    watchOuts: [
      'Do not leave rights ambiguous because the product feels informal.',
      'Do not assume buyers interpret usage limits the same way you do.',
      'Do not underprice expanded commercial rights.',
    ],
    output:
        'A license summary that states permitted use, restricted use, and upgrade triggers.',
    references: [
      LessonReference(
        title: 'Creative Commons Licensing Overview',
        url: 'https://creativecommons.org/share-your-work/cclicenses/',
        note:
            'Useful baseline for understanding structured permission frameworks.',
      ),
      LessonReference(
        title: 'Gumroad Creator Resources',
        url: 'https://gumroad.com/blog',
        note:
            'Practical creator-side guidance relevant to selling repeatable digital assets.',
      ),
    ],
  ),
  'pst-4': LessonContent(
    coreIdea:
        'Support hell happens when the product creates endless bespoke questions, handholding, and troubleshooting that pricing does not cover. Preventing that starts with packaging, documentation, and boundaries.',
    whyItMatters:
        'This matters because a product can look profitable on paper while becoming miserable in practice. If every buyer generates custom support labor, your margin collapses and the business becomes emotionally expensive to run. Good support design is therefore part of product strategy, not merely customer service hygiene.',
    timing:
        'This lesson becomes active as soon as buyers start asking the same questions or when fulfillment requires repeated manual intervention. It is particularly important before scaling a digital product or productized service beyond a few forgiving customers.',
    evidence:
        'Operationally, repeatable businesses depend on documentation, scope discipline, and support boundaries because human handholding does not scale with low-priced or high-volume offers. The pattern is visible across digital-product and service businesses alike.',
    founderLens:
        'Support load is part of the business model. If you ignore it, a profitable-looking product can become a miserable one.',
    example:
        'A template product with no onboarding notes, examples, or FAQ often turns into repeated inbox labor that destroys margin.',
    steps: [
      'List the questions buyers are most likely to ask after purchase.',
      'Turn repeat questions into docs, videos, or canned responses.',
      'Decide what support is included and what becomes paid help.',
    ],
    watchOuts: [
      'Do not promise unlimited help by accident.',
      'Do not wait for support pain before documenting common issues.',
      'Do not let one difficult customer rewrite your scope.',
    ],
    output:
        'A support policy and documentation list that protects margin while keeping the buyer successful.',
    references: [
      LessonReference(
        title: 'Shopify Digital Products Guide',
        url: 'https://www.shopify.com/blog/digital-products',
        note:
            'Useful for thinking about delivery, documentation, and product support expectations.',
      ),
      LessonReference(
        title: 'Gumroad Creator Resources',
        url: 'https://gumroad.com/blog',
        note:
            'Helpful for understanding support and fulfillment issues in digital-product businesses.',
      ),
    ],
  ),
};
