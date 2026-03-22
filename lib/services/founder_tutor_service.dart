import 'package:supabase_flutter/supabase_flutter.dart';

enum TutorProvider { openAi, gemini }

extension TutorProviderLabel on TutorProvider {
  String get label => switch (this) {
    TutorProvider.openAi => 'OpenAI',
    TutorProvider.gemini => 'Gemini',
  };

  String get wireValue => switch (this) {
    TutorProvider.openAi => 'openai',
    TutorProvider.gemini => 'gemini',
  };
}

class FounderTutorRequest {
  const FounderTutorRequest({
    required this.provider,
    required this.question,
    required this.projectName,
    required this.track,
    required this.stageTitle,
    required this.moduleTitle,
    required this.lessonTitle,
    required this.lessonSummary,
    required this.lessonConcept,
    required this.lessonWhyItMatters,
    required this.moduleTerms,
    required this.lessonTerms,
    required this.moduleNote,
    required this.todayLearningTask,
    required this.todayExecutionTask,
    required this.completedTaskCount,
    required this.overallProgress,
  });

  final TutorProvider provider;
  final String question;
  final String projectName;
  final String track;
  final String stageTitle;
  final String moduleTitle;
  final String lessonTitle;
  final String lessonSummary;
  final String lessonConcept;
  final String lessonWhyItMatters;
  final List<String> moduleTerms;
  final List<String> lessonTerms;
  final String moduleNote;
  final String todayLearningTask;
  final String todayExecutionTask;
  final int completedTaskCount;
  final double overallProgress;

  Map<String, dynamic> toJson() {
    return {
      'provider': provider.wireValue,
      'question': question,
      'projectName': projectName,
      'track': track,
      'stageTitle': stageTitle,
      'moduleTitle': moduleTitle,
      'lessonTitle': lessonTitle,
      'lessonSummary': lessonSummary,
      'lessonConcept': lessonConcept,
      'lessonWhyItMatters': lessonWhyItMatters,
      'moduleTerms': moduleTerms,
      'lessonTerms': lessonTerms,
      'moduleNote': moduleNote,
      'todayLearningTask': todayLearningTask,
      'todayExecutionTask': todayExecutionTask,
      'completedTaskCount': completedTaskCount,
      'overallProgress': overallProgress,
    };
  }
}

class FounderTutorReply {
  const FounderTutorReply({required this.answer});

  final String answer;
}

class FounderTutorService {
  const FounderTutorService();

  Future<FounderTutorReply> ask(FounderTutorRequest request) async {
    final response = await Supabase.instance.client.functions.invoke(
      'founder-tutor',
      body: request.toJson(),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Tutor response was not valid JSON.');
    }

    final answer = data['answer'];
    if (answer is! String || answer.trim().isEmpty) {
      throw const FormatException('Tutor response did not include an answer.');
    }

    return FounderTutorReply(answer: answer.trim());
  }
}
