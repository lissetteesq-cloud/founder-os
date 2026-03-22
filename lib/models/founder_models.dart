import 'package:flutter/material.dart';

enum TrackType { saas, digitalProduct }

extension TrackTypeLabel on TrackType {
  String get label => switch (this) {
    TrackType.saas => 'App / SaaS',
    TrackType.digitalProduct => 'Digital Product',
  };

  String get shortLabel => switch (this) {
    TrackType.saas => 'SaaS',
    TrackType.digitalProduct => 'Digital',
  };

  String get storageValue => switch (this) {
    TrackType.saas => 'saas',
    TrackType.digitalProduct => 'digitalProduct',
  };

  static TrackType fromStorage(String value) => switch (value) {
    'digitalProduct' => TrackType.digitalProduct,
    _ => TrackType.saas,
  };
}

class TrackVariant {
  const TrackVariant({
    required this.focus,
    required this.differs,
    required this.recommendedTask,
  });

  final String focus;
  final String differs;
  final String recommendedTask;
}

class ResourceLink {
  const ResourceLink({
    required this.title,
    required this.url,
    required this.type,
  });

  final String title;
  final String url;
  final String type;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.summary,
    required this.battleTask,
  });

  final String id;
  final String title;
  final String summary;
  final String battleTask;
}

class ChecklistTask {
  const ChecklistTask({
    required this.id,
    required this.title,
    required this.detail,
  });

  final String id;
  final String title;
  final String detail;
}

class Module {
  const Module({
    required this.id,
    required this.title,
    required this.telemetry,
    required this.icon,
    required this.explanation,
    required this.whyItMatters,
    required this.keyTerms,
    required this.lessons,
    required this.checklist,
    required this.companyPatterns,
    required this.soloFounderMisses,
    required this.resources,
    required this.aiPrompts,
    required this.trackVariants,
  });

  final String id;
  final String title;
  final String telemetry;
  final IconData icon;
  final String explanation;
  final String whyItMatters;
  final List<String> keyTerms;
  final List<Lesson> lessons;
  final List<ChecklistTask> checklist;
  final List<String> companyPatterns;
  final List<String> soloFounderMisses;
  final List<ResourceLink> resources;
  final List<String> aiPrompts;
  final Map<TrackType, TrackVariant> trackVariants;
}

class Stage {
  const Stage({
    required this.id,
    required this.order,
    required this.title,
    required this.telemetry,
    required this.meaning,
    required this.successLooksLike,
    required this.commonMistakes,
    required this.milestones,
    required this.moveOnWhen,
    required this.focusStatement,
    required this.priorities,
    required this.blockedItems,
    required this.biggestRisk,
    required this.moduleId,
  });

  final String id;
  final int order;
  final String title;
  final String telemetry;
  final String meaning;
  final String successLooksLike;
  final List<String> commonMistakes;
  final List<ChecklistTask> milestones;
  final String moveOnWhen;
  final String focusStatement;
  final List<String> priorities;
  final List<String> blockedItems;
  final String biggestRisk;
  final String moduleId;
}

class GlossaryTerm {
  const GlossaryTerm({
    required this.term,
    required this.category,
    required this.definition,
  });

  final String term;
  final String category;
  final String definition;
}

class DecisionFramework {
  const DecisionFramework({
    required this.title,
    required this.description,
    required this.questions,
    required this.output,
  });

  final String title;
  final String description;
  final List<String> questions;
  final String output;
}

class FounderSeedData {
  const FounderSeedData({
    required this.modules,
    required this.stages,
    required this.glossary,
    required this.frameworks,
  });

  final List<Module> modules;
  final List<Stage> stages;
  final List<GlossaryTerm> glossary;
  final List<DecisionFramework> frameworks;

  Map<String, Module> get modulesById => {
    for (final module in modules) module.id: module,
  };

  Map<String, Stage> get stagesById => {
    for (final stage in stages) stage.id: stage,
  };

  Map<String, ChecklistTask> get tasksById => {
    for (final task in [
      ...modules.expand((module) => module.checklist),
      ...stages.expand((stage) => stage.milestones),
    ])
      task.id: task,
  };
}
