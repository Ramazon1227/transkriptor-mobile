import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/rating/domain/entities/rating.dart';
import 'package:transkriptor_uz/features/rating/domain/i_rating_facade.dart';
import 'package:transkriptor_uz/features/rating/infrastructure/repositories/rating_repository.dart';

@LazySingleton(as: IRatingFacade)
class RatingFacade implements IRatingFacade {
  RatingFacade(this._repository);

  final RatingRepository _repository;

  @override
  Future<Either<Failure, Rating?>> myRating(String transcriptId) async {
    final result = await _repository.myRating(transcriptId);
    return result.map((m) => m?.toEntity());
  }

  @override
  Future<Either<Failure, Rating>> setRating(
    String transcriptId,
    Rating rating,
  ) async {
    final result = await _repository.setRating(
      transcriptId,
      score: rating.score,
      note: rating.note,
    );
    return result.fold<Either<Failure, Rating>>(Left.new, (m) {
      final stored = m.toEntity();
      return stored == null ? const Left(Failure.parsing()) : Right(stored);
    });
  }
}
