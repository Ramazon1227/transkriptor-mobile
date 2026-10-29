import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The editor's «Oʻrganish». No backend yet: a demo source builds the
/// sets from the transcript text and keeps them for the session.
abstract interface class ILearnFacade {
  Future<Either<Failure, LearnSets>> sets(String transcriptId);

  /// May hold fewer cards than [count] when the text is short; an empty
  /// set means there was nothing to make cards from.
  Future<Either<Failure, FlashcardSet>> createFlashcards(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
  });

  /// [types] must not be empty.
  Future<Either<Failure, QuizSet>> createQuiz(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
    required Set<QuizQuestionType> types,
  });
}
