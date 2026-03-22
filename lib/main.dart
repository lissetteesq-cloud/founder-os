import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config/supabase_config.dart';
import 'data/lesson_content.dart';
import 'models/founder_models.dart';
import 'services/chat_export_service.dart';
import 'services/founder_os_sync_service.dart';
import 'services/founder_tutor_service.dart';
import 'services/founder_voice_playback_controller.dart';
import 'state/founder_os_controller.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FounderOsSyncService.instance.initialize();
  final controller = await FounderOsController.load();
  runApp(FounderOsApp(controller: controller));
}

class FounderOsApp extends StatelessWidget {
  const FounderOsApp({
    super.key,
    required this.controller,
    this.requireAuth = true,
  });

  final FounderOsController controller;
  final bool requireAuth;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Founder OS',
          theme: buildFounderTheme(),
          home: FounderOsAuthGate(
            controller: controller,
            requireAuth: requireAuth,
          ),
        );
      },
    );
  }
}

class FounderOsAuthGate extends StatelessWidget {
  const FounderOsAuthGate({
    super.key,
    required this.controller,
    required this.requireAuth,
  });

  final FounderOsController controller;
  final bool requireAuth;

  @override
  Widget build(BuildContext context) {
    if (!requireAuth || !FounderOsSyncService.instance.isInitialized) {
      return FounderOsShell(controller: controller);
    }

    final client = Supabase.instance.client;
    return StreamBuilder<AuthState>(
      stream: client.auth.onAuthStateChange,
      initialData: AuthState(
        AuthChangeEvent.initialSession,
        client.auth.currentSession,
      ),
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? client.auth.currentSession;
        if (session == null) {
          return const _AuthScreen();
        }
        return FounderOsShell(controller: controller);
      },
    );
  }
}

class _AuthScreen extends StatefulWidget {
  const _AuthScreen();

  @override
  State<_AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<_AuthScreen> {
  late final TextEditingController _emailController;
  bool _isSending = false;
  String? _error;
  String? _success;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _Panel(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.terminal, color: AppColors.success),
                        const SizedBox(width: 10),
                        Text(
                          'FOUNDER_OS',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Use your email and we will send you a magic link so only you can enter the app from the public URL.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'you@example.com',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isSending ? null : _sendMagicLink,
                        child: Text(
                          _isSending ? 'Sending...' : 'Send magic link',
                        ),
                      ),
                    ),
                    if (_success != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _success!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _error!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.critical,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendMagicLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _error = 'Enter your email first.';
        _success = null;
      });
      return;
    }

    setState(() {
      _isSending = true;
      _error = null;
      _success = null;
    });

    try {
      await Supabase.instance.client.auth.signInWithOtp(
        email: email,
        emailRedirectTo: Uri.base.toString(),
      );
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _success =
            'Magic link sent. Open the email on this device and come back here after signing in.';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _error = 'Sign-in failed: $error';
      });
    }
  }
}

class FounderOsShell extends StatefulWidget {
  const FounderOsShell({super.key, required this.controller});

  final FounderOsController controller;

  @override
  State<FounderOsShell> createState() => _FounderOsShellState();
}

class _FounderOsShellState extends State<FounderOsShell> {
  int _currentIndex = 0;
  final FounderVoicePlaybackController _voicePlayback =
      FounderVoicePlaybackController.instance;

  void _openLearnForModule(String moduleId, {String? lessonId}) {
    widget.controller.setSelectedModule(moduleId);
    final module = widget.controller.data.modulesById[moduleId];
    widget.controller.setSelectedLesson(
      lessonId ?? module?.lessons.first.id ?? '',
    );
    setState(() => _currentIndex = 2);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      CommandPage(
        controller: widget.controller,
        onOpenLearn: () => _openLearnForModule(
          widget.controller.selectedModuleId ??
              widget.controller.currentModule.id,
          lessonId: widget.controller.selectedLessonId,
        ),
      ),
      MapPage(controller: widget.controller, onOpenLearn: _openLearnForModule),
      LearnPage(controller: widget.controller),
      ExpertPage(controller: widget.controller),
      IntelligencePage(controller: widget.controller),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.terminal, color: AppColors.success),
            const SizedBox(width: 10),
            Text(
              'FOUNDER_OS',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'LunarWise',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _currentIndex >= 3
                      ? AppColors.accent
                      : AppColors.textMuted,
                ),
              ),
            ),
          ),
          if (FounderOsSyncService.instance.isInitialized)
            IconButton(
              tooltip: 'Sign out',
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: pages),
          AnimatedBuilder(
            animation: _voicePlayback,
            builder: (context, _) {
              if (!_voicePlayback.isVisible) {
                return const SizedBox.shrink();
              }
              return Positioned(
                top: 12,
                left: 16,
                right: 16,
                child: SafeArea(
                  bottom: false,
                  child: _VoicePlayerPill(controller: _voicePlayback),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) => setState(() => _currentIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize),
            label: 'Command',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_outlined),
            label: 'Expert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            label: 'Intel',
          ),
        ],
      ),
    );
  }
}

class CommandPage extends StatelessWidget {
  const CommandPage({
    super.key,
    required this.controller,
    required this.onOpenLearn,
  });

  final FounderOsController controller;
  final VoidCallback onOpenLearn;

  @override
  Widget build(BuildContext context) {
    final module = _selectedModule(controller);
    final stage = controller.currentStage;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'SYSTEM_STATUS: STABLE',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.accent),
                ),
              ),
              Text(
                'PROJECT_IDENTIFIER',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'LunarWise',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stage.focusStatement,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onOpenLearn,
                      child: const Text('DEPLOY_BUILD'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onOpenLearn,
                      child: const Text('VIEW_CHANGELOG'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _MetricCard(
              label: 'LOC_TOTAL',
              value: '42,809',
              accent: AppColors.accent,
            ),
            _MetricCard(
              label: 'BUGS_FIXED',
              value: '114',
              accent: const Color(0xFFFFB77D),
              sublabel: '+12 this week',
            ),
            _MetricCard(
              label: 'MOMENTUM',
              value: '98.4%',
              accent: AppColors.textPrimary,
              sublabel: stage.telemetry,
            ),
            _MetricCard(
              label: 'UPTIME',
              value: '99.9',
              accent: AppColors.textPrimary,
              sublabel: 'SLA compliant',
            ),
          ],
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TACTICAL_TASK_BACKLOG',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 12),
              ...module.checklist
                  .take(4)
                  .map(
                    (task) => _BacklogItem(
                      title: task.title,
                      subtitle: task.detail,
                      active: !controller.isTaskComplete(task.id),
                      onTap: () => controller.toggleTask(task.id),
                    ),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DEPLOYMENT_MAP',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 12),
              const SizedBox(
                height: 180,
                child: Center(
                  child: Icon(
                    Icons.public,
                    size: 72,
                    color: AppColors.outlineVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _MetricRow(label: 'Current stage', value: stage.title),
              const SizedBox(height: 8),
              _MetricRow(
                label: 'Progress',
                value: '${(controller.overallProgress * 100).round()}%',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({
    super.key,
    required this.controller,
    required this.onOpenLearn,
  });

  final FounderOsController controller;
  final void Function(String moduleId, {String? lessonId}) onOpenLearn;

  @override
  Widget build(BuildContext context) {
    final stages = [...controller.stages]
      ..sort((a, b) => a.order.compareTo(b.order));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BATTLE MAP',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Read the founder process as a sequence. Each stage points to a module and a specific kind of decision.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...stages.map((stage) {
          final isCurrent = stage.id == controller.currentStage.id;
          final linkedModule = controller.data.modulesById[stage.moduleId];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                controller.setActiveStage(stage.id);
                if (linkedModule != null) {
                  onOpenLearn(
                    linkedModule.id,
                    lessonId: linkedModule.lessons.first.id,
                  );
                }
              },
              child: _Panel(
                background: isCurrent
                    ? AppColors.accent.withValues(alpha: 0.12)
                    : AppColors.surfaceCard,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? AppColors.accent
                            : AppColors.surfaceRaised,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        stage.order.toString(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isCurrent
                              ? AppColors.background
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stage.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stage.meaning,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          _MetricRow(
                            label: 'Linked module',
                            value: linkedModule?.title ?? 'No module linked',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class LearnPage extends StatefulWidget {
  const LearnPage({super.key, required this.controller});

  final FounderOsController controller;

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final module = _selectedModule(widget.controller);
    final lesson = _selectedLesson(widget.controller, module);
    final content = _lessonContentFor(lesson);
    final lessonIndex =
        module.lessons.indexWhere((item) => item.id == lesson.id) + 1;
    final note = widget.controller.moduleNote(module.id);

    if (_notesController.text != note) {
      _notesController.value = TextEditingValue(
        text: note,
        selection: TextSelection.collapsed(offset: note.length),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('START HERE', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 6),
              Text(
                'Learn',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 38),
              ),
              const SizedBox(height: 8),
              Text(
                'This is the course area. Pick a module, read the lessons in order, then use the tutor if you need help applying it to LunarWise.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FOUNDER ROADMAP // READ IN THIS ORDER',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              ...widget.controller.modules.asMap().entries.map((entry) {
                final current = entry.value.id == module.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      widget.controller.setSelectedModule(entry.value.id);
                      widget.controller.setSelectedLesson(
                        entry.value.lessons.first.id,
                      );
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: current
                            ? AppColors.surfaceHighest
                            : AppColors.surfaceLow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: current ? AppColors.accent : AppColors.ghost,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: current
                                  ? AppColors.accent.withValues(alpha: 0.18)
                                  : AppColors.surfaceRaised,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('${entry.key + 1}'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.value.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  entry.value.explanation,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                module.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(module.explanation),
              const SizedBox(height: 12),
              _DetailBlock(
                title: 'Why this matters',
                body: module.whyItMatters,
              ),
              const SizedBox(height: 12),
              _DetailBlock(
                title: 'Track-specific focus',
                body: widget.controller.currentTrackVariant.focus,
              ),
              const SizedBox(height: 12),
              _GlossaryTermsBlock(
                title: 'Plain-English terms for this module',
                terms: module.keyTerms,
                glossary: widget.controller.data.glossary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 980;
            final outline = _Panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LESSON OUTLINE // READ THESE IN ORDER',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 8),
                  ...module.lessons.asMap().entries.map((entry) {
                    final current = entry.value.id == lesson.id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          widget.controller.setSelectedLesson(entry.value.id);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: current
                                ? AppColors.surfaceHighest
                                : AppColors.inset,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: current
                                  ? AppColors.accent
                                  : AppColors.ghost,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lesson ${entry.key + 1}',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: current
                                          ? AppColors.accent
                                          : AppColors.textMuted,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                entry.value.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                entry.value.summary,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );

            final reader = _LessonReaderCard(
              controller: widget.controller,
              module: module,
              lesson: lesson,
              lessonNumber: lessonIndex,
              content: content,
            );

            if (stacked) {
              return Column(
                children: [outline, const SizedBox(height: 16), reader],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 340, child: outline),
                const SizedBox(width: 16),
                Expanded(child: reader),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        _TutorConversationPanel(
          controller: widget.controller,
          module: module,
          lesson: lesson,
          content: content,
          title: 'ASK ANYTHING ABOUT THIS LESSON',
          intro:
              'Use this chat for full back-and-forth discussion about the lesson, founder process, or how it applies to LunarWise. You are not limited to the prompts.',
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CHECKLIST', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              ...module.checklist.map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _ChecklistRow(
                    task: task,
                    complete: widget.controller.isTaskComplete(task.id),
                    onToggle: () => widget.controller.toggleTask(task.id),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NOTES', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                minLines: 4,
                maxLines: 8,
                onChanged: (value) =>
                    widget.controller.updateModuleNote(module.id, value),
                decoration: const InputDecoration(
                  hintText:
                      'Capture your notes, decisions, and open questions here.',
                ),
              ),
              const SizedBox(height: 16),
              Text('RESOURCES', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              ...module.resources.map(
                (resource) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: OutlinedButton(
                    onPressed: () => _openUrl(resource.url),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${resource.type}: ${resource.title}'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TutorConversationPanel extends StatefulWidget {
  const _TutorConversationPanel({
    required this.controller,
    required this.module,
    required this.lesson,
    required this.content,
    required this.title,
    required this.intro,
  });

  final FounderOsController controller;
  final Module module;
  final Lesson lesson;
  final LessonContent content;
  final String title;
  final String intro;

  @override
  State<_TutorConversationPanel> createState() =>
      _TutorConversationPanelState();
}

class _TutorConversationPanelState extends State<_TutorConversationPanel> {
  final FounderTutorService _tutorService = const FounderTutorService();
  final FounderVoicePlaybackController _voicePlayback =
      FounderVoicePlaybackController.instance;
  final SpeechToText _speechToText = SpeechToText();
  final List<_TutorMessage> _messages = <_TutorMessage>[];
  late final TextEditingController _promptController;
  bool _isSending = false;
  bool _speechReady = false;
  bool _isListening = false;
  bool _autoReadReplies = false;
  String? _error;
  String? _lastLessonId;
  TutorProvider _provider = TutorProvider.openAi;
  String _selectedVoice = 'nova';

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController();
    _initializeVoice();
  }

  @override
  void dispose() {
    _speechToText.stop();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_lastLessonId != widget.lesson.id) {
      final starter =
          'Explain "${widget.lesson.title}" to me in plain English, then tell me what I should do in LunarWise right now.';
      _lastLessonId = widget.lesson.id;
      _promptController.value = TextEditingValue(
        text: starter,
        selection: TextSelection.collapsed(offset: starter.length),
      );
      _messages.clear();
      _error = null;
    }

    final promptChips = <String>[
      'Explain this lesson simply.',
      'Search my app and tell me what you find.',
      'Review my app homepage and tell me what is weak.',
      'Run an SEO audit on my app.',
      'Generate 10 hooks for this stage.',
      'Analyze this data for me:',
      'How does this apply to LunarWise?',
      'What should I do next?',
      'Define the jargon in this lesson.',
    ];

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          Text(widget.intro, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          Text(
            'Live app: ${SupabaseConfig.appUrl}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            'Repo: ${SupabaseConfig.repoUrl}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          _MetricRow(
            label: 'Stage',
            value: widget.controller.currentStage.title,
          ),
          const SizedBox(height: 8),
          _MetricRow(label: 'Module', value: widget.module.title),
          const SizedBox(height: 8),
          _MetricRow(label: 'Lesson', value: widget.lesson.title),
          const SizedBox(height: 12),
          SegmentedButton<TutorProvider>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: TutorProvider.openAi, label: Text('OpenAI')),
              ButtonSegment(value: TutorProvider.gemini, label: Text('Gemini')),
            ],
            selected: {_provider},
            onSelectionChanged: (selection) {
              setState(() {
                _provider = selection.first;
              });
            },
          ),
          const SizedBox(height: 8),
          Text(
            _provider == TutorProvider.openAi
                ? 'Use OpenAI for reasoning, logic, app review, structured decision support, and implementation analysis.'
                : 'Use Gemini for distribution, SEO, hooks, messaging, channel thinking, and creative support with the same lesson and app context.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Natural voice playback',
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedVoice,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'sage', child: Text('Sage')),
                  DropdownMenuItem(value: 'coral', child: Text('Coral')),
                  DropdownMenuItem(value: 'alloy', child: Text('Alloy')),
                  DropdownMenuItem(value: 'nova', child: Text('Nova')),
                  DropdownMenuItem(value: 'ash', child: Text('Ash')),
                  DropdownMenuItem(value: 'ballad', child: Text('Ballad')),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedVoice = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Reply playback uses model-generated audio from OpenAI, not the device voice engine.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Text(
            'Command shortcuts',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: promptChips
                .map(
                  (prompt) => ActionChip(
                    label: Text(prompt),
                    onPressed: () {
                      _promptController.value = TextEditingValue(
                        text: prompt,
                        selection: TextSelection.collapsed(
                          offset: prompt.length,
                        ),
                      );
                      _promptController.selection = TextSelection.collapsed(
                        offset: _promptController.text.length,
                      );
                    },
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.inset,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.ghost),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'founder_tutor://context',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.accent,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The agent can use your lesson context, your live app URL, your repo URL, public web research, and recent chat turns. It should treat commands like "search my app", "review my app", "run an SEO audit", "generate hooks", and "analyze this data" as commands, not as generic tutoring prompts.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (_messages.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ..._messages.map(
                    (message) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: message.isUser
                              ? AppColors.surfaceLow
                              : AppColors.surfaceRaised,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: message.isUser
                                ? AppColors.accent
                                : AppColors.ghost,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.isUser ? 'You' : 'Founder Tutor',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: message.isUser
                                        ? AppColors.accent
                                        : AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(message.text),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                if (_isSending) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.critical),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _promptController,
            minLines: 2,
            maxLines: 8,
            decoration: InputDecoration(
              hintText:
                  'Ask anything. Examples: "search my app", "review my homepage", "run an SEO audit", "generate 15 hooks", "analyze this data: ..."',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _promptController.text.trim().isEmpty
                        ? null
                        : () {
                            setState(() {
                              _promptController.clear();
                            });
                          },
                    icon: const Icon(Icons.clear),
                    tooltip: 'Clear input',
                  ),
                  IconButton(
                    onPressed: _speechReady ? _toggleListening : null,
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    tooltip: _isListening
                        ? 'Stop dictation'
                        : 'Start dictation',
                  ),
                ],
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _copyPrompt(context),
                icon: const Icon(Icons.content_copy),
                label: const Text('Copy Prompt'),
              ),
              OutlinedButton.icon(
                onPressed: _messages.isEmpty
                    ? null
                    : () {
                        setState(() {
                          _messages.clear();
                          _error = null;
                        });
                      },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Clear Chat'),
              ),
              OutlinedButton.icon(
                onPressed: _messages.isEmpty
                    ? null
                    : () => _exportConversation(context),
                icon: const Icon(Icons.download_outlined),
                label: const Text('Export Chat'),
              ),
              OutlinedButton.icon(
                onPressed: _messages.any((message) => !message.isUser)
                    ? _speakLatestReply
                    : null,
                icon: const Icon(Icons.volume_up_outlined),
                label: Text(
                  _voicePlayback.isLoading ? 'Loading...' : 'Read Reply',
                ),
              ),
              OutlinedButton.icon(
                onPressed: _stopVoice,
                icon: const Icon(Icons.stop_circle_outlined),
                label: const Text('Stop Voice'),
              ),
              FilterChip(
                label: const Text('Auto-read replies'),
                selected: _autoReadReplies,
                onSelected: (value) {
                  setState(() {
                    _autoReadReplies = value;
                  });
                },
              ),
              FilledButton.icon(
                onPressed: _isSending ? null : _askTutor,
                icon: const Icon(Icons.send),
                label: Text(_isSending ? 'Thinking...' : 'Ask Tutor'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => _openUrl(SupabaseConfig.appUrl),
                  child: const Text('Open Live App'),
                ),
                OutlinedButton(
                  onPressed: () => _openUrl(SupabaseConfig.repoUrl),
                  child: const Text('Open Repo'),
                ),
                OutlinedButton(
                  onPressed: () => _openUrl('https://gemini.google.com/app'),
                  child: const Text('Open Gemini External'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeVoice() async {
    try {
      final ready = await _speechToText.initialize(
        onStatus: (status) {
          if (!mounted) return;
          if (status == 'done' || status == 'notListening') {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (error) {
          if (!mounted) return;
          setState(() {
            _isListening = false;
            _error = 'Voice input failed: ${error.errorMsg}';
          });
        },
      );
      if (!mounted) return;
      setState(() {
        _speechReady = ready;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Voice tools failed to initialize. $error';
      });
    }
  }

  Future<void> _copyPrompt(BuildContext context) async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: prompt));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Prompt copied')));
  }

  Future<void> _toggleListening() async {
    if (!_speechReady) {
      setState(() {
        _error = 'Speech input is not available on this device/browser.';
      });
      return;
    }

    if (_isListening) {
      await _speechToText.stop();
      if (!mounted) return;
      setState(() {
        _isListening = false;
      });
      return;
    }

    setState(() {
      _error = null;
      _isListening = true;
    });

    await _speechToText.listen(
      listenOptions: SpeechListenOptions(
        partialResults: true,
        listenMode: ListenMode.dictation,
      ),
      onResult: (result) {
        if (!mounted) return;
        final recognized = result.recognizedWords.trim();
        if (recognized.isEmpty) return;
        setState(() {
          _promptController.value = TextEditingValue(
            text: recognized,
            selection: TextSelection.collapsed(offset: recognized.length),
          );
        });
      },
    );
  }

  Future<void> _speakLatestReply() async {
    final latestReply = _messages.lastWhere(
      (message) => !message.isUser,
      orElse: () => const _TutorMessage(role: 'assistant', text: ''),
    );
    if (latestReply.text.trim().isEmpty) return;
    await _voicePlayback.loadReply(
      text: latestReply.text,
      voice: _selectedVoice,
      title: 'Tutor reply',
      autoPlay: false,
    );
  }

  Future<void> _stopVoice() async {
    await _speechToText.stop();
    await _voicePlayback.stop();
    if (!mounted) return;
    setState(() {
      _isListening = false;
    });
  }

  String _buildTranscriptMarkdown() {
    final buffer = StringBuffer()
      ..writeln('# Founder OS Tutor Transcript')
      ..writeln()
      ..writeln('- Project: LunarWise')
      ..writeln('- Live app: ${SupabaseConfig.appUrl}')
      ..writeln('- Repo: ${SupabaseConfig.repoUrl}')
      ..writeln('- Stage: ${widget.controller.currentStage.title}')
      ..writeln('- Module: ${widget.module.title}')
      ..writeln('- Lesson: ${widget.lesson.title}')
      ..writeln('- Provider: ${_provider.label}')
      ..writeln()
      ..writeln('## Conversation')
      ..writeln();

    for (final message in _messages) {
      buffer
        ..writeln('### ${message.isUser ? 'You' : 'Tutor'}')
        ..writeln()
        ..writeln(message.text)
        ..writeln();
    }

    return buffer.toString();
  }

  Future<void> _exportConversation(BuildContext context) async {
    try {
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .replaceAll('.', '-');
      final filename = 'founder-os-tutor-$timestamp.md';
      final result = await exportTranscript(
        filename: filename,
        contents: _buildTranscriptMarkdown(),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Transcript exported: $result')));
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transcript export failed: $error')),
      );
    }
  }

  Future<void> _askTutor() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty || _isSending) return;

    setState(() {
      _messages.add(_TutorMessage(role: 'user', text: prompt));
      _isSending = true;
      _error = null;
    });

    try {
      final reply = await _tutorService.ask(
        FounderTutorRequest(
          provider: _provider,
          question: prompt,
          projectName: 'LunarWise',
          track: widget.controller.selectedTrack.label,
          stageTitle: widget.controller.currentStage.title,
          moduleTitle: widget.module.title,
          lessonTitle: widget.lesson.title,
          lessonSummary: widget.lesson.summary,
          lessonConcept: widget.content.coreIdea,
          lessonWhyItMatters: widget.content.whyItMatters,
          moduleTerms: widget.module.keyTerms,
          lessonTerms: widget.content.lessonTerms,
          moduleNote: widget.controller.moduleNote(widget.module.id),
          todayLearningTask: widget.controller.todayLearningTask,
          todayExecutionTask: widget.controller.todayExecutionTask,
          completedTaskCount: widget.controller.completedTaskCount,
          overallProgress: widget.controller.overallProgress,
          appUrl: SupabaseConfig.appUrl,
          repoUrl: SupabaseConfig.repoUrl,
          conversationHistory: _messages
              .map(
                (message) => TutorConversationTurn(
                  role: message.role,
                  text: message.text,
                ),
              )
              .toList(growable: false),
        ),
      );

      if (!mounted) return;
      setState(() {
        _messages.add(
          _TutorMessage(
            role: 'assistant',
            text: '[${_provider.label}] ${reply.answer}',
          ),
        );
        _isSending = false;
      });
      if (_autoReadReplies) {
        await _voicePlayback.loadReply(
          text: '[${_provider.label}] ${reply.answer}',
          voice: _selectedVoice,
          title: 'Tutor reply',
          autoPlay: true,
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _error =
            'The founder tutor could not answer right now. Check that the Supabase function is deployed and that the needed provider secret exists. Technical detail: $error';
      });
    }
  }
}

class _TutorMessage {
  const _TutorMessage({required this.role, required this.text});

  final String role;
  final String text;

  bool get isUser => role == 'user';
}

class _VoicePlayerPill extends StatelessWidget {
  const _VoicePlayerPill({required this.controller});

  final FounderVoicePlaybackController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised.withValues(alpha: 0.78),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.ghost),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              controller.isLoading
                  ? Icons.graphic_eq
                  : controller.isPlaying
                  ? Icons.volume_up
                  : Icons.headphones,
              color: AppColors.accent,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.isLoading
                        ? 'Preparing natural voice'
                        : controller.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.error != null
                        ? 'Playback blocked or failed. Press play to retry.'
                        : controller.isLoading
                        ? 'Generating ${controller.voice} voice audio...'
                        : 'Voice: ${controller.voice}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: controller.isLoading
                  ? null
                  : controller.isPlaying
                  ? controller.pause
                  : controller.hasAudio
                  ? controller.play
                  : null,
              icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
              tooltip: controller.isPlaying ? 'Pause' : 'Play',
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: controller.hasAudio ? controller.stop : null,
              icon: const Icon(Icons.stop),
              tooltip: 'Stop',
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: controller.dismiss,
              icon: const Icon(Icons.close),
              tooltip: 'Close player',
            ),
          ],
        ),
      ),
    );
  }
}

class ExpertPage extends StatefulWidget {
  const ExpertPage({super.key, required this.controller});

  final FounderOsController controller;

  @override
  State<ExpertPage> createState() => _ExpertPageState();
}

class _ExpertPageState extends State<ExpertPage> {
  @override
  Widget build(BuildContext context) {
    final module = _selectedModule(widget.controller);
    final lesson = _selectedLesson(widget.controller, module);
    final content = _lessonContentFor(lesson);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EXPERT TUTOR',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'This tutor answers about the lesson you are currently studying. It uses your current module, lesson, stage, notes, progress, and the LunarWise project context.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              _MetricRow(
                label: 'Stage',
                value: widget.controller.currentStage.title,
              ),
              const SizedBox(height: 8),
              _MetricRow(label: 'Module', value: module.title),
              const SizedBox(height: 8),
              _MetricRow(label: 'Lesson', value: lesson.title),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _TutorConversationPanel(
          controller: widget.controller,
          module: module,
          lesson: lesson,
          content: content,
          title: 'FOUNDER TUTOR // FULL CHAT',
          intro:
              'This is the same tutor as the one in Learn, but on its own page. Use it for open-ended back-and-forth about the current lesson, founder logic, or LunarWise decisions.',
        ),
      ],
    );
  }
}

class IntelligencePage extends StatelessWidget {
  const IntelligencePage({super.key, required this.controller});

  final FounderOsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MARKETING CAMPAIGN TRACKER',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Use this as your operating surface for attention, conversion, and backlog thinking.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _MetricCard(
              label: 'IMPRESSIONS',
              value: '1.2M',
              accent: AppColors.accent,
              sublabel: '+12.4% vs last week',
            ),
            _MetricCard(
              label: 'CLICKS',
              value: '48.2K',
              accent: AppColors.textPrimary,
              sublabel: 'CTR 4.02%',
            ),
            _MetricCard(
              label: 'LEADS',
              value: '3.1K',
              accent: AppColors.textPrimary,
              sublabel: 'CPL \$4.12',
            ),
            _MetricCard(
              label: 'CONVERSIONS',
              value: '842',
              accent: AppColors.textPrimary,
              sublabel: '27.1%',
            ),
          ],
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _IntelChannelCard(
                title: 'Twitter / X',
                spend: '\$4,200',
                efficiency: '94%',
                status: 'HIGH_ROI',
              ),
              SizedBox(height: 10),
              _IntelChannelCard(
                title: 'LinkedIn',
                spend: '\$1,850',
                efficiency: '72%',
                status: 'STABLE',
              ),
              SizedBox(height: 10),
              _IntelChannelCard(
                title: 'Search Ads',
                spend: '\$12,400',
                efficiency: '58%',
                status: 'OVER_BUDGET',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LessonReaderCard extends StatelessWidget {
  const _LessonReaderCard({
    required this.controller,
    required this.module,
    required this.lesson,
    required this.lessonNumber,
    required this.content,
  });

  final FounderOsController controller;
  final Module module;
  final Lesson lesson;
  final int lessonNumber;
  final LessonContent content;

  @override
  Widget build(BuildContext context) {
    final voicePlayback = FounderVoicePlaybackController.instance;
    final checks = content.selfCheckQuestions.isNotEmpty
        ? content.selfCheckQuestions
        : <String>[
            'Can you explain the main point of this lesson in plain English?',
            'Can you say why this matters at this stage?',
            'Have you drafted the output this lesson asks you to produce?',
          ];

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LESSON $lessonNumber',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  lesson.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: 'Listen to lesson',
                onPressed: () async {
                  final script = _buildLessonAudioScript(
                    lesson: lesson,
                    content: content,
                  );
                  await voicePlayback.loadReply(
                    text: script,
                    voice: voicePlayback.voice,
                    title: lesson.title,
                    autoPlay: false,
                  );
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lesson audio is ready in the top player.'),
                    ),
                  );
                },
                icon: const Icon(Icons.volume_up_outlined, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(lesson.summary, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          _GlossaryTermsBlock(
            title: 'Plain-English terms for this lesson',
            terms: content.lessonTerms,
            glossary: controller.data.glossary,
          ),
          const SizedBox(height: 12),
          _DetailBlock(title: 'Concept', body: content.coreIdea),
          const SizedBox(height: 12),
          _DetailBlock(title: 'Why this matters', body: content.whyItMatters),
          const SizedBox(height: 12),
          _DetailBlock(title: 'When to work on this', body: content.timing),
          const SizedBox(height: 12),
          _DetailBlock(
            title: 'Evidence and foundations',
            body: content.evidence,
          ),
          const SizedBox(height: 12),
          _DetailBlock(title: 'Founder lens', body: content.founderLens),
          const SizedBox(height: 12),
          _DetailBlock(title: 'Concrete example', body: content.example),
          const SizedBox(height: 12),
          _BulletSection(title: 'Do this next', items: content.steps),
          const SizedBox(height: 12),
          _BulletSection(title: 'Watch outs', items: content.watchOuts),
          const SizedBox(height: 12),
          _DetailBlock(title: 'Practice task', body: lesson.battleTask),
          const SizedBox(height: 12),
          _DetailBlock(title: 'What you should end with', body: content.output),
          const SizedBox(height: 12),
          _BulletSection(title: 'Self-check', items: checks),
          if (content.references.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Sources', style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 8),
            ...content.references.map(
              (reference) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: () => _openUrl(reference.url),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${reference.title}\n${reference.note}'),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child, this.background = AppColors.surfaceLow});

  final Widget child;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ghost),
      ),
      child: child,
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.accent,
    this.sublabel,
  });

  final String label;
  final String value;
  final Color accent;
  final String? sublabel;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      background: AppColors.surfaceRaised,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 24, color: accent),
          ),
          if (sublabel != null) ...[
            const SizedBox(height: 6),
            Text(sublabel!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}

class _BacklogItem extends StatelessWidget {
  const _BacklogItem({
    required this.title,
    required this.subtitle,
    required this.active,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.inset,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: active
                  ? AppColors.accent.withValues(alpha: 0.35)
                  : AppColors.ghost,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 36,
                color: active ? AppColors.accent : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                active ? Icons.radio_button_unchecked : Icons.check_circle,
                color: active ? AppColors.textMuted : AppColors.success,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.task,
    required this.complete,
    required this.onToggle,
  });

  final ChecklistTask task;
  final bool complete;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.inset,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: complete, onChanged: (_) => onToggle()),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.detail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlossaryTermsBlock extends StatelessWidget {
  const _GlossaryTermsBlock({
    required this.title,
    required this.terms,
    required this.glossary,
  });

  final String title;
  final List<String> terms;
  final List<GlossaryTerm> glossary;

  @override
  Widget build(BuildContext context) {
    final resolved = terms
        .map((term) => _resolveGlossaryTerm(term, glossary))
        .whereType<GlossaryTerm>()
        .toList(growable: false);

    if (resolved.isEmpty) {
      return _DetailBlock(
        title: title,
        body:
            'No plain-English term definitions have been attached to this section yet.',
      );
    }

    return _Panel(
      background: AppColors.inset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          ...resolved.map(
            (term) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    term.term,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    term.definition,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      background: AppColors.inset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 6),
          Text(body),
        ],
      ),
    );
  }
}

class _BulletSection extends StatelessWidget {
  const _BulletSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      background: AppColors.inset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 8),
                    child: Icon(Icons.circle, size: 6, color: AppColors.accent),
                  ),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _buildLessonAudioScript({
  required Lesson lesson,
  required LessonContent content,
}) {
  final steps = content.steps.take(4).join(' ');
  final watchOuts = content.watchOuts.take(3).join(' ');

  return '''
Lesson: ${lesson.title}.

Summary: ${lesson.summary}

Concept: ${content.coreIdea}

Why this matters: ${content.whyItMatters}

What to do next: $steps

Watch outs: $watchOuts

Practice task: ${lesson.battleTask}
'''
      .trim();
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}

class _IntelChannelCard extends StatelessWidget {
  const _IntelChannelCard({
    required this.title,
    required this.spend,
    required this.efficiency,
    required this.status,
  });

  final String title;
  final String spend;
  final String efficiency;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inset,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                status,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.accent),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _MetricRow(label: 'Spend', value: spend),
          const SizedBox(height: 6),
          _MetricRow(label: 'Efficiency', value: efficiency),
        ],
      ),
    );
  }
}

Module _selectedModule(FounderOsController controller) {
  return controller.data.modulesById[controller.selectedModuleId ??
          controller.currentModule.id] ??
      controller.currentModule;
}

Lesson _selectedLesson(FounderOsController controller, Module module) {
  for (final lesson in module.lessons) {
    if (lesson.id == controller.selectedLessonId) {
      return lesson;
    }
  }
  return module.lessons.first;
}

GlossaryTerm? _resolveGlossaryTerm(String raw, List<GlossaryTerm> glossary) {
  final normalized = raw.toLowerCase().trim();
  for (final item in glossary) {
    if (item.term.toLowerCase() == normalized) {
      return item;
    }
  }
  if (normalized.contains('(') && normalized.contains(')')) {
    final acronym = normalized.split('(').last.replaceAll(')', '').trim();
    for (final item in glossary) {
      if (item.term.toLowerCase() == acronym) {
        return item;
      }
    }
  }
  return null;
}

LessonContent _lessonContentFor(Lesson lesson) {
  return lessonContentById[lesson.id] ??
      LessonContent(
        coreIdea: lesson.summary,
        whyItMatters:
            'This lesson still needs an upgraded longform explanation.',
        timing: 'This lesson still needs a proper timing section.',
        evidence: 'This lesson still needs source-backed references.',
        founderLens: 'This lesson is still using fallback text.',
        example: 'No concrete example has been authored for this lesson yet.',
        steps: [lesson.battleTask],
        watchOuts: const ['This lesson is still in fallback mode.'],
        output: lesson.battleTask,
      );
}

Future<void> _openUrl(String rawUrl) async {
  final uri = Uri.parse(rawUrl);
  await launchUrl(uri, mode: LaunchMode.platformDefault);
}
