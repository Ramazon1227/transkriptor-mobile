import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/rating/domain/entities/rating.dart';

abstract interface class IRatingFacade {
  /// Null: not rated yet.
  Future<Either<Failure, Rating?>> myRating(String transcriptId);

  Future<Either<Failure, Rating>> setRating(String transcriptId, Rating rating);
}
