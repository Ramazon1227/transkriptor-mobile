import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';

/// A transcript's sentiment analysis. Started only by a button; the
/// labels are written in the background and the client polls [get].
abstract interface class ISentimentFacade {
  /// Null: never requested. Any workspace member may read it.
  Future<Either<Failure, SentimentAnalysis?>> get(String transcriptId);

  /// Starts or restarts the analysis (answer is `PENDING`). 403 for a
  /// VIEWER, 409 while one runs or when there is no text, 503 when the
  /// AI is off or its queue is full.
  Future<Either<Failure, SentimentAnalysis>> analyze(String transcriptId);
}
