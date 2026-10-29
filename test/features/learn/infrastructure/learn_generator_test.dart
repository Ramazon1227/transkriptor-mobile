import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/domain/learn_rules.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/demo/demo_learn_repository.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/demo/learn_generator.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

import '../../../helpers/transcripts.dart';

void main() {
  const gen = LearnGenerator();
  final t = meetingTranscript();

  group('flashcards', () {
    test('same transcript and settings, same cards', () {
      final a = gen.flashcards(
        t,
        count: 10,
        difficulty: LearnDifficulty.medium,
      );
      final b = gen.flashcards(
        t,
        count: 10,
        difficulty: LearnDifficulty.medium,
      );
      expect(a, b);
    });

    for (final count in learnCounts) {
      test('honours count $count', () {
        for (final d in LearnDifficulty.values) {
          final cards = gen.flashcards(t, count: count, difficulty: d);
          expect(cards, hasLength(count), reason: d.name);
        }
      });
    }

    test('a card blanks a word of a real sentence', () {
      for (final c in gen.flashcards(
        t,
        count: 10,
        difficulty: LearnDifficulty.easy,
      )) {
        expect(c.front, contains(learnBlank));
        expect(c.front.replaceFirst(learnBlank, c.back), c.source);
        expect(meetingLines.any((l) => l.contains(c.source)), isTrue);
        expect(c.back.runes.length, greaterThanOrEqualTo(6));
      }
    });

    test('no repeated (sentence, word) pairs', () {
      final cards = gen.flashcards(
        t,
        count: 20,
        difficulty: LearnDifficulty.hard,
      );
      expect(cards.map((c) => '${c.source}|${c.back}').toSet(), hasLength(20));
    });
  });

  group('quiz', () {
    test('both types, alternating, count honoured', () {
      final qs = gen.quiz(
        t,
        count: 10,
        difficulty: LearnDifficulty.medium,
        types: QuizQuestionType.values.toSet(),
      );
      expect(qs, hasLength(10));
      expect(qs.map((q) => q.type).toSet(), QuizQuestionType.values.toSet());
    });

    test('multiple choice: the right option fills the blank', () {
      final qs = gen.quiz(
        t,
        count: 10,
        difficulty: LearnDifficulty.hard,
        types: {QuizQuestionType.multipleChoice},
      );
      expect(qs, hasLength(10));
      for (final q in qs) {
        expect(q.type, QuizQuestionType.multipleChoice);
        expect(q.options, hasLength(4));
        expect(q.options.toSet(), hasLength(4));
        expect(
          q.prompt.replaceFirst(learnBlank, q.options[q.correctIndex]),
          q.source,
        );
      }
    });

    test('easy multiple choice has three options', () {
      final qs = gen.quiz(
        t,
        count: 5,
        difficulty: LearnDifficulty.easy,
        types: {QuizQuestionType.multipleChoice},
      );
      expect(qs.every((q) => q.options.length == 3), isTrue);
    });

    test('true/false: true is the sentence, false differs from it', () {
      final qs = gen.quiz(
        t,
        count: 20,
        difficulty: LearnDifficulty.medium,
        types: {QuizQuestionType.trueFalse},
      );
      expect(qs, hasLength(20));
      expect(qs.map((q) => q.correctIndex).toSet(), {0, 1});
      for (final q in qs) {
        expect(q.options, isEmpty);
        expect(q.answerCount, 2);
        if (q.correctIndex == 0) {
          expect(q.prompt, q.source);
        } else {
          expect(q.prompt, isNot(q.source));
        }
      }
    });

    test('deterministic', () {
      List<QuizQuestion> make() => gen.quiz(
        t,
        count: 15,
        difficulty: LearnDifficulty.easy,
        types: QuizQuestionType.values.toSet(),
      );
      expect(make(), make());
    });

    test('no types, no questions', () {
      expect(
        gen.quiz(t, count: 5, difficulty: LearnDifficulty.easy, types: {}),
        isEmpty,
      );
    });
  });

  group('short text', () {
    test('the rule refuses fewer than three segments', () {
      expect(canLearn(shortTranscript()), isFalse);
      expect(canLearn(t), isTrue);
    });

    test('sentences too short give nothing, not nonsense', () {
      final tiny = Transcript(
        id: 'x',
        title: 'x',
        segments: [
          for (var i = 0; i < 5; i++)
            Segment(
              id: '$i',
              start: Duration.zero,
              end: Duration.zero,
              text: 'Ha. Yoʻq. Rahmat.',
            ),
        ],
      );
      expect(
        gen.flashcards(tiny, count: 10, difficulty: LearnDifficulty.easy),
        isEmpty,
      );
    });
  });

  test('the demo repository keeps sets per transcript, newest first', () async {
    final repo = DemoLearnRepository.custom(delay: Duration.zero);
    final first = await repo.createFlashcards(
      t,
      count: 5,
      difficulty: LearnDifficulty.easy,
    );
    final quiz = await repo.createQuiz(
      t,
      count: 5,
      difficulty: LearnDifficulty.easy,
      types: {QuizQuestionType.trueFalse},
    );
    final second = await repo.createFlashcards(
      t,
      count: 10,
      difficulty: LearnDifficulty.hard,
    );
    final sets = repo.sets('t1');
    expect(sets.flashcards.map((s) => s.id), [second.id, first.id]);
    expect(sets.quizzes.single.id, quiz.id);
    expect(repo.sets('other').isEmpty, isTrue);
  });
}
