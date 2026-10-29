import 'package:dartz/dartz.dart' show Either, Right;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/domain/i_learn_facade.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/demo/demo_learn_repository.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Backed by the demo source only; see the comment at the top of
/// `demo_learn_repository.dart`.
@LazySingleton(as: ILearnFacade)
class LearnFacade implements ILearnFacade {
  LearnFacade(this._demo);

  final DemoLearnRepository _demo;

  @override
  Future<Either<Failure, LearnSets>> sets(String transcriptId) async =>
      Right(_demo.sets(transcriptId));

  @override
  Future<Either<Failure, FlashcardSet>> createFlashcards(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
  }) async => Right(
    await _demo.createFlashcards(
      transcript,
      count: count,
      difficulty: difficulty,
    ),
  );

  @override
  Future<Either<Failure, QuizSet>> createQuiz(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
    required Set<QuizQuestionType> types,
  }) async => Right(
    await _demo.createQuiz(
      transcript,
      count: count,
      difficulty: difficulty,
      types: types,
    ),
  );
}
