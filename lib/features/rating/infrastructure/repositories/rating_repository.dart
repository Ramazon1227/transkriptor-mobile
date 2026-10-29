import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/rating/infrastructure/models/rating_model.dart';

@lazySingleton
class RatingRepository {
  RatingRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, RatingModel?>> myRating(String transcriptId) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.transcriptRating(transcriptId),
      );
      return RatingEnvelopeModel.fromJson(envelopeData(response.data)).rating;
    });
  }

  /// An answer without the stored rating is a parsing failure.
  Future<Either<Failure, RatingModel>> setRating(
    String transcriptId, {
    required int score,
    required String note,
  }) {
    return runRequest(() async {
      final response = await _dio.put<Map<String, dynamic>>(
        Endpoints.transcriptRating(transcriptId),
        data: {'score': score, 'note': note},
      );
      final rating = RatingEnvelopeModel.fromJson(envelopeData(response.data))
          .rating;
      if (rating == null) throw const FormatException('rating: missing');
      return rating;
    });
  }
}
