import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/domain/i_sentiment_facade.dart';
import 'package:transkriptor_uz/features/sentiment/infrastructure/repositories/sentiment_repository.dart';

@LazySingleton(as: ISentimentFacade)
class SentimentFacade implements ISentimentFacade {
  SentimentFacade(this._repository);

  final SentimentRepository _repository;

  @override
  Future<Either<Failure, SentimentAnalysis?>> get(String transcriptId) async {
    final result = await _repository.get(transcriptId);
    return result.map((m) => m?.toEntity());
  }

  @override
  Future<Either<Failure, SentimentAnalysis>> analyze(
    String transcriptId,
  ) async {
    final result = await _repository.analyze(transcriptId);
    return result.map((m) => m.toEntity());
  }
}
