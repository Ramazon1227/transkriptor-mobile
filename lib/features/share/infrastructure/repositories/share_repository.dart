import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/share/infrastructure/models/share_link_model.dart';

@lazySingleton
class ShareRepository {
  ShareRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, List<ShareLinkModel>>> listLinks(String transcriptId) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.transcriptShares(transcriptId),
      );
      final items = envelopeData(response.data)['items'] as List<dynamic>?;
      return (items ?? const [])
          .cast<Map<String, dynamic>>()
          .map(ShareLinkModel.fromJson)
          .toList();
    });
  }

  Future<Either<Failure, ShareLinkModel>> createLink({
    required String transcriptId,
    required bool includeMedia,
    required int expiresDays,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptShares(transcriptId),
        data: {'include_media': includeMedia, 'expires_days': expiresDays},
      );
      final link = envelopeData(response.data)['link'];
      if (link is! Map<String, dynamic>) {
        throw const FormatException('response has no link object');
      }
      return ShareLinkModel.fromJson(link);
    });
  }

  Future<Either<Failure, Unit>> revokeLink(String linkId) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(Endpoints.share(linkId));
      return unit;
    });
  }
}
