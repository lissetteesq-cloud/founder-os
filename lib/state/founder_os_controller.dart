import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/seed_content.dart';
import '../models/founder_models.dart';
import '../services/founder_os_sync_service.dart';

class FounderOsController extends ChangeNotifier {
  FounderOsController._(this._preferences, this.data) {
    _restore();
  }

  static const _storageKey = 'founder_os_state_v1';

  final SharedPreferences _preferences;
  final FounderSeedData data;

  TrackType selectedTrack = TrackType.saas;
  late final Map<TrackType, String> _activeStageByTrack = {
    TrackType.saas: 'early-distribution',
    TrackType.digitalProduct: 'offer-definition',
  };

  final Set<String> _completedTaskIds = <String>{};
  final Map<String, String> _completedTaskDates = <String, String>{};
  final Map<String, String> _moduleNotes = <String, String>{};
  final Map<String, String> _dailyJournalByDate = <String, String>{};
  final Map<String, int> _energyByDate = <String, int>{};
  final Set<String> _completedDays = <String>{};
  final Map<String, Map<String, String>> _weeklyReviewByWeek =
      <String, Map<String, String>>{};

  String? selectedModuleId;
  String? selectedStageId;
  String? selectedLessonId;

  static Future<FounderOsController> load({
    bool enableRemoteSync = true,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final controller = FounderOsController._(preferences, SeedContent.build());
    if (enableRemoteSync) {
      await controller._hydrateRemoteState();
    }
    return controller;
  }

  void _restore() {
    final raw = _preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      selectedModuleId = 'start-here';
      selectedStageId = currentStage.id;
      selectedLessonId = data.modulesById[selectedModuleId!]?.lessons.first.id;
      return;
    }

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    _applyDecodedState(decoded);
  }

  void _applyDecodedState(Map<String, dynamic> decoded) {
    selectedTrack = TrackTypeLabel.fromStorage(
      decoded['selectedTrack'] as String? ?? 'saas',
    );

    final stageMap =
        (decoded['activeStageByTrack'] as Map<String, dynamic>? ??
        <String, dynamic>{});
    _activeStageByTrack[TrackType.saas] =
        stageMap['saas'] as String? ?? 'early-distribution';
    _activeStageByTrack[TrackType.digitalProduct] =
        stageMap['digitalProduct'] as String? ?? 'offer-definition';

    _completedTaskIds
      ..clear()
      ..addAll(
        List<String>.from(
          decoded['completedTaskIds'] as List<dynamic>? ?? const [],
        ),
      );

    _completedTaskDates
      ..clear()
      ..addAll(
        (decoded['completedTaskDates'] as Map<String, dynamic>? ??
                <String, dynamic>{})
            .map((key, value) => MapEntry(key, value.toString())),
      );

    _moduleNotes
      ..clear()
      ..addAll(
        (decoded['moduleNotes'] as Map<String, dynamic>? ?? <String, dynamic>{})
            .map((key, value) => MapEntry(key, value.toString())),
      );

    _dailyJournalByDate
      ..clear()
      ..addAll(
        (decoded['dailyJournalByDate'] as Map<String, dynamic>? ??
                <String, dynamic>{})
            .map((key, value) => MapEntry(key, value.toString())),
      );

    _energyByDate
      ..clear()
      ..addAll(
        (decoded['energyByDate'] as Map<String, dynamic>? ??
                <String, dynamic>{})
            .map((key, value) => MapEntry(key, (value as num).toInt())),
      );

    _completedDays
      ..clear()
      ..addAll(
        List<String>.from(
          decoded['completedDays'] as List<dynamic>? ?? const [],
        ),
      );

    _weeklyReviewByWeek
      ..clear()
      ..addAll(
        (decoded['weeklyReviewByWeek'] as Map<String, dynamic>? ??
                <String, dynamic>{})
            .map(
              (key, value) => MapEntry(
                key,
                (value as Map<String, dynamic>).map(
                  (fieldKey, fieldValue) =>
                      MapEntry(fieldKey, fieldValue.toString()),
                ),
              ),
            ),
      );

    selectedModuleId = decoded['selectedModuleId'] as String? ?? 'start-here';
    selectedStageId = decoded['selectedStageId'] as String? ?? currentStage.id;
    selectedLessonId =
        decoded['selectedLessonId'] as String? ??
        data.modulesById[selectedModuleId!]?.lessons.first.id;
  }

  Map<String, dynamic> _buildPayload() {
    return <String, dynamic>{
      'selectedTrack': selectedTrack.storageValue,
      'activeStageByTrack': {
        'saas': _activeStageByTrack[TrackType.saas],
        'digitalProduct': _activeStageByTrack[TrackType.digitalProduct],
      },
      'completedTaskIds': _completedTaskIds.toList(),
      'completedTaskDates': _completedTaskDates,
      'moduleNotes': _moduleNotes,
      'dailyJournalByDate': _dailyJournalByDate,
      'energyByDate': _energyByDate,
      'completedDays': _completedDays.toList(),
      'weeklyReviewByWeek': _weeklyReviewByWeek,
      'selectedModuleId': selectedModuleId,
      'selectedStageId': selectedStageId,
      'selectedLessonId': selectedLessonId,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };
  }

  DateTime _updatedAtFor(Map<String, dynamic> payload) {
    final raw = payload['updatedAt'];
    if (raw is String) {
      return DateTime.tryParse(raw)?.toUtc() ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    }
    return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  }

  Future<void> _saveLocalPayload(Map<String, dynamic> payload) async {
    await _preferences.setString(_storageKey, jsonEncode(payload));
  }

  Future<void> _save() async {
    final payload = _buildPayload();
    await _saveLocalPayload(payload);
    await FounderOsSyncService.instance.saveWorkspaceState(payload);
  }

  Future<void> _hydrateRemoteState() async {
    final remotePayload = await FounderOsSyncService.instance
        .fetchWorkspaceState();
    final localRaw = _preferences.getString(_storageKey);

    if (remotePayload == null) {
      if (localRaw != null && localRaw.isNotEmpty) {
        final localPayload = jsonDecode(localRaw) as Map<String, dynamic>;
        await FounderOsSyncService.instance.saveWorkspaceState(localPayload);
      }
      return;
    }

    if (localRaw == null || localRaw.isEmpty) {
      _applyDecodedState(remotePayload);
      await _saveLocalPayload(remotePayload);
      return;
    }

    final localPayload = jsonDecode(localRaw) as Map<String, dynamic>;
    final remoteUpdatedAt = _updatedAtFor(remotePayload);
    final localUpdatedAt = _updatedAtFor(localPayload);

    if (remoteUpdatedAt.isAfter(localUpdatedAt)) {
      _applyDecodedState(remotePayload);
      await _saveLocalPayload(remotePayload);
      return;
    }

    if (localUpdatedAt.isAfter(remoteUpdatedAt)) {
      await FounderOsSyncService.instance.saveWorkspaceState(localPayload);
    }
  }

  List<Module> get modules => data.modules;

  List<Stage> get stages => data.stages;

  Stage get currentStage =>
      data.stagesById[_activeStageByTrack[selectedTrack]!]!;

  Module get currentModule => data.modulesById[currentStage.moduleId]!;

  String get todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  String get weekKey {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    return '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}';
  }

  String get todayJournal => _dailyJournalByDate[todayKey] ?? '';

  int get todayEnergy => _energyByDate[todayKey] ?? 3;

  bool get isTodayComplete => _completedDays.contains(todayKey);

  String moduleNote(String moduleId) => _moduleNotes[moduleId] ?? '';

  Map<String, String> get weeklyReview =>
      _weeklyReviewByWeek[weekKey] ??
      const <String, String>{
        'built': '',
        'learned': '',
        'signal': '',
        'bottleneck': '',
        'focus': '',
        'stop': '',
      };

  void setSelectedTrack(TrackType track) {
    if (selectedTrack == track) return;
    selectedTrack = track;
    selectedStageId = currentStage.id;
    selectedModuleId = currentStage.moduleId;
    selectedLessonId = currentModule.lessons.first.id;
    _persistAndNotify();
  }

  void setActiveStage(String stageId) {
    _activeStageByTrack[selectedTrack] = stageId;
    selectedStageId = stageId;
    selectedModuleId = data.stagesById[stageId]?.moduleId ?? selectedModuleId;
    final nextModule = data.modulesById[selectedModuleId ?? ''];
    selectedLessonId = nextModule?.lessons.first.id;
    _persistAndNotify();
  }

  void setSelectedModule(String moduleId) {
    selectedModuleId = moduleId;
    final module = data.modulesById[moduleId];
    if (module == null || module.lessons.isEmpty) {
      selectedLessonId = null;
    } else if (!module.lessons.any((lesson) => lesson.id == selectedLessonId)) {
      selectedLessonId = module.lessons.first.id;
    }
    _persistAndNotify();
  }

  void setSelectedLesson(String lessonId) {
    selectedLessonId = lessonId;
    _persistAndNotify();
  }

  void setSelectedStageDetail(String stageId) {
    selectedStageId = stageId;
    _persistAndNotify();
  }

  void toggleTask(String taskId) {
    if (_completedTaskIds.contains(taskId)) {
      _completedTaskIds.remove(taskId);
      _completedTaskDates.remove(taskId);
    } else {
      _completedTaskIds.add(taskId);
      _completedTaskDates[taskId] = todayKey;
    }
    _persistAndNotify();
  }

  void updateModuleNote(String moduleId, String value) {
    _moduleNotes[moduleId] = value;
    _persistAndNotify();
  }

  void updateTodayJournal(String value) {
    _dailyJournalByDate[todayKey] = value;
    _persistAndNotify();
  }

  void updateTodayEnergy(int value) {
    _energyByDate[todayKey] = value;
    _persistAndNotify();
  }

  void toggleDayComplete() {
    if (_completedDays.contains(todayKey)) {
      _completedDays.remove(todayKey);
    } else {
      _completedDays.add(todayKey);
    }
    _persistAndNotify();
  }

  void updateWeeklyReview(String field, String value) {
    final current = Map<String, String>.from(weeklyReview);
    current[field] = value;
    _weeklyReviewByWeek[weekKey] = current;
    _persistAndNotify();
  }

  bool isTaskComplete(String taskId) => _completedTaskIds.contains(taskId);

  double moduleProgress(String moduleId) {
    final module = data.modulesById[moduleId]!;
    if (module.checklist.isEmpty) return 0;
    final completed = module.checklist
        .where((task) => isTaskComplete(task.id))
        .length;
    return completed / module.checklist.length;
  }

  double stageProgress(String stageId) {
    final stage = data.stagesById[stageId]!;
    if (stage.milestones.isEmpty) return 0;
    final completed = stage.milestones
        .where((task) => isTaskComplete(task.id))
        .length;
    return completed / stage.milestones.length;
  }

  double get overallProgress {
    final allTasks = [
      ...data.modules.expand((module) => module.checklist),
      ...data.stages.expand((stage) => stage.milestones),
    ];
    if (allTasks.isEmpty) return 0;
    final completed = allTasks.where((task) => isTaskComplete(task.id)).length;
    return completed / allTasks.length;
  }

  int get completedTaskCount => _completedTaskIds.length;

  List<ChecklistTask> get recentCompletedTasks {
    final entries = _completedTaskDates.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .take(5)
        .map((entry) => data.tasksById[entry.key])
        .whereType<ChecklistTask>()
        .toList();
  }

  List<ChecklistTask> get incompleteTasksForCurrentModule => currentModule
      .checklist
      .where((task) => !_completedTaskIds.contains(task.id))
      .toList(growable: false);

  List<ChecklistTask> get incompleteMilestonesForCurrentStage => currentStage
      .milestones
      .where((task) => !_completedTaskIds.contains(task.id))
      .toList(growable: false);

  Lesson get todayLesson => currentModule.lessons.first;

  ChecklistTask get todayChecklistTask =>
      incompleteMilestonesForCurrentStage.isNotEmpty
      ? incompleteMilestonesForCurrentStage.first
      : (incompleteTasksForCurrentModule.isNotEmpty
            ? incompleteTasksForCurrentModule.first
            : currentModule.checklist.first);

  ResourceLink get recommendedResource => currentModule.resources.first;

  String get todayLearningTask =>
      currentModule.trackVariants[selectedTrack]!.recommendedTask;

  String get todayExecutionTask =>
      incompleteMilestonesForCurrentStage.isNotEmpty
      ? incompleteMilestonesForCurrentStage.first.title
      : todayChecklistTask.title;

  TrackVariant get currentTrackVariant =>
      currentModule.trackVariants[selectedTrack]!;

  Future<void> _persistAndNotify() async {
    await _save();
    notifyListeners();
  }
}
