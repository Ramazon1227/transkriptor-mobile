import 'package:freezed_annotation/freezed_annotation.dart';

part 'learn.freezed.dart';

enum LearnDifficulty { easy, medium, hard }

enum QuizQuestionType { multipleChoice, trueFalse }

/// Question counts offered when creating a set.
const List<int> learnCounts = [5, 10, 15, 20];

/// A study card: a sentence from the transcript with one word blanked
/// out on the front, the word on the back.
@freezed
abstract class Flashcard with _$Flashcard {
  const factory Flashcard({
    required String front,
    required String back,

    /// The sentence as it was said.
    required String source,
  }) = _Flashcard;
}

/// One quiz question. Multiple choice: [options] with [correctIndex].
/// True/false: [options] is empty, [correctIndex] 0 = true, 1 = false
/// (the UI names the two answers).
@freezed
abstract class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required QuizQuestionType type,
    required String prompt,
    required int correctIndex,
    required String source,
    @Default(<String>[]) List<String> options,
  }) = _QuizQuestion;

  const QuizQuestion._();

  /// How many answers there are to choose from.
  int get answerCount =>
      type == QuizQuestionType.trueFalse ? 2 : options.length;
}

@freezed
abstract class FlashcardSet with _$FlashcardSet {
  const factory FlashcardSet({
    required String id,
    required LearnDifficulty difficulty,
    required DateTime createdAt,
    @Default(<Flashcard>[]) List<Flashcard> cards,
  }) = _FlashcardSet;
}

@freezed
abstract class QuizSet with _$QuizSet {
  const factory QuizSet({
    required String id,
    required LearnDifficulty difficulty,
    required DateTime createdAt,
    @Default(<QuizQuestionType>[]) List<QuizQuestionType> types,
    @Default(<QuizQuestion>[]) List<QuizQuestion> questions,
  }) = _QuizSet;
}

/// The sets made for one transcript this session, newest first.
@freezed
abstract class LearnSets with _$LearnSets {
  const factory LearnSets({
    @Default(<FlashcardSet>[]) List<FlashcardSet> flashcards,
    @Default(<QuizSet>[]) List<QuizSet> quizzes,
  }) = _LearnSets;

  const LearnSets._();

  bool get isEmpty => flashcards.isEmpty && quizzes.isEmpty;
}
