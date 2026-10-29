import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/learn/application/flashcards_cubit.dart';
import 'package:transkriptor_uz/features/learn/application/learn_cubit.dart';
import 'package:transkriptor_uz/features/learn/application/quiz_cubit.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/demo/demo_learn_repository.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/facades/learn_facade.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

import '../../../helpers/transcripts.dart';

final _set = FlashcardSet(
  id: 'f1',
  difficulty: LearnDifficulty.easy,
  createdAt: DateTime(2026),
  cards: const [
    Flashcard(front: 'a _____', back: '1', source: 'a 1'),
    Flashcard(front: 'b _____', back: '2', source: 'b 2'),
    Flashcard(front: 'c _____', back: '3', source: 'c 3'),
  ],
);

final _quiz = QuizSet(
  id: 'q1',
  difficulty: LearnDifficulty.easy,
  createdAt: DateTime(2026),
  questions: const [
    QuizQuestion(
      type: QuizQuestionType.multipleChoice,
      prompt: 'x _____',
      options: ['a', 'b', 'c'],
      correctIndex: 1,
      source: 'x b',
    ),
    QuizQuestion(
      type: QuizQuestionType.trueFalse,
      prompt: 'y',
      correctIndex: 0,
      source: 'y',
    ),
  ],
);

void main() {
  group('LearnCubit', () {
    LearnCubit make() => LearnCubit(
      LearnFacade(DemoLearnRepository.custom(delay: Duration.zero)),
    );

    test('a short transcript is refused', () async {
      final cubit = make();
      addTearDown(cubit.close);
      await cubit.start(shortTranscript());
      expect(cubit.state.status, LearnStatus.tooShort);
      expect(
        await cubit.createFlashcards(
          count: 5,
          difficulty: LearnDifficulty.easy,
        ),
        isNull,
      );
    });

    test('created sets are returned and listed', () async {
      final cubit = make();
      addTearDown(cubit.close);
      await cubit.start(meetingTranscript());
      final cards = await cubit.createFlashcards(
        count: 5,
        difficulty: LearnDifficulty.easy,
      );
      final quiz = await cubit.createQuiz(
        count: 5,
        difficulty: LearnDifficulty.medium,
        types: {QuizQuestionType.multipleChoice},
      );
      expect(cards!.cards, hasLength(5));
      expect(quiz!.questions, hasLength(5));
      expect(cubit.state.sets.flashcards.single, cards);
      expect(cubit.state.sets.quizzes.single, quiz);
      expect(cubit.state.createStatus, LearnCreateStatus.idle);
    });

    test('text with nothing to ask about is "empty", not a set', () async {
      final cubit = make();
      addTearDown(cubit.close);
      await cubit.start(
        Transcript(
          id: 'x',
          title: 'x',
          segments: [
            for (var i = 0; i < 4; i++)
              Segment(
                id: '$i',
                start: Duration.zero,
                end: Duration.zero,
                text: 'Ha, rahmat.',
              ),
          ],
        ),
      );
      final set = await cubit.createFlashcards(
        count: 5,
        difficulty: LearnDifficulty.easy,
      );
      expect(set, isNull);
      expect(cubit.state.createStatus, LearnCreateStatus.empty);
      expect(cubit.state.sets.isEmpty, isTrue);
    });
  });

  group('FlashcardsCubit', () {
    test('flip, mark, finish, and restart only the repeats', () {
      final cubit = FlashcardsCubit()..start(_set);
      addTearDown(cubit.close);
      cubit.flip();
      expect(cubit.state.flipped, isTrue);
      cubit.mark(known: true);
      expect(cubit.state.index, 1);
      expect(cubit.state.flipped, isFalse);
      cubit
        ..mark(known: false)
        ..previous();
      expect(cubit.state.index, 1);
      // Re-marking moves the card between the two counts.
      cubit.mark(known: true);
      expect(cubit.state.known, {0, 1});
      expect(cubit.state.repeat, isEmpty);
      cubit.mark(known: false);
      expect(cubit.state.finished, isTrue);
      expect(cubit.state.current, isNull);
      cubit.restart(onlyRepeat: true);
      expect(cubit.state.cards.single.back, '3');
      expect(cubit.state.known, isEmpty);
    });

    test('previous from the result goes back to the last card', () {
      final cubit = FlashcardsCubit()..start(_set);
      addTearDown(cubit.close);
      cubit
        ..next()
        ..next()
        ..next();
      expect(cubit.state.finished, isTrue);
      cubit.previous();
      expect(cubit.state.finished, isFalse);
      expect(cubit.state.index, 2);
    });
  });

  group('QuizCubit', () {
    test('an answer is final, next needs one, score counts right ones', () {
      final cubit = QuizCubit()..start(_quiz);
      addTearDown(cubit.close);
      cubit.next();
      expect(cubit.state.index, 0, reason: 'not answered yet');
      cubit
        ..choose(0)
        ..choose(1);
      expect(cubit.state.currentAnswer, 0, reason: 'first choice sticks');
      cubit
        ..next()
        ..choose(5); // out of range
      expect(cubit.state.currentAnswer, isNull);
      cubit
        ..choose(0)
        ..next();
      expect(cubit.state.finished, isTrue);
      expect(cubit.state.score, 1);
      cubit.restart();
      expect(cubit.state.answers, [null, null]);
      expect(cubit.state.finished, isFalse);
    });
  });
}
