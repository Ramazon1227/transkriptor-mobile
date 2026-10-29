// DEMO SOURCE — replaced when a learn endpoint exists.
//
// There is no flashcard/quiz API. This repository builds the sets with
// `LearnGenerator` from the transcript text, after a fake delay, and keeps
// them in memory per transcript for the app session (a lazy singleton).
// When an endpoint exists, write a `LearnRepository` against it and point
// `LearnFacade` at it; the cubits and the tab do not change.

import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/demo/learn_generator.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

@lazySingleton
class DemoLearnRepository {
  DemoLearnRepository() : delay = const Duration(milliseconds: 900);

  DemoLearnRepository.custom({required this.delay});

  final Duration delay;
  final LearnGenerator _generator = const LearnGenerator();
  final Map<String, LearnSets> _sets = {};
  int _next = 0;

  LearnSets sets(String transcriptId) =>
      _sets[transcriptId] ?? const LearnSets();

  Future<FlashcardSet> createFlashcards(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
  }) async {
    await Future<void>.delayed(delay);
    final set = FlashcardSet(
      id: '${transcript.id}-f${++_next}',
      difficulty: difficulty,
      createdAt: DateTime.now(),
      cards: _generator.flashcards(
        transcript,
        count: count,
        difficulty: difficulty,
      ),
    );
    if (set.cards.isNotEmpty) {
      final current = sets(transcript.id);
      _sets[transcript.id] = current.copyWith(
        flashcards: [set, ...current.flashcards],
      );
    }
    return set;
  }

  Future<QuizSet> createQuiz(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
    required Set<QuizQuestionType> types,
  }) async {
    await Future<void>.delayed(delay);
    final ordered = QuizQuestionType.values.where(types.contains).toList();
    final set = QuizSet(
      id: '${transcript.id}-q${++_next}',
      difficulty: difficulty,
      createdAt: DateTime.now(),
      types: ordered,
      questions: _generator.quiz(
        transcript,
        count: count,
        difficulty: difficulty,
        types: types,
      ),
    );
    if (set.questions.isNotEmpty) {
      final current = sets(transcript.id);
      _sets[transcript.id] = current.copyWith(
        quizzes: [set, ...current.quizzes],
      );
    }
    return set;
  }
}
