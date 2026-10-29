import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/player/infrastructure/models/media_url_model.dart';

@lazySingleton
class PlayerRepository {
  PlayerRepository(this._dio);

  final Dio _dio;

  /// An answer without a link is a parsing failure: nothing to play.
  Future<Either<Failure, MediaUrlModel>> mediaUrl(String mediaId) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.mediaUrl(mediaId),
      );
      final model = MediaUrlModel.fromJson(envelopeData(response.data));
      if (model.url.isEmpty) {
        throw const FormatException('media url: no url');
      }
      return model;
    });
  }
}
