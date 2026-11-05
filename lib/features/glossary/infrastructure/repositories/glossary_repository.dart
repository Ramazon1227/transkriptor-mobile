import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/glossary/infrastructure/models/glossary_model.dart';

@lazySingleton
class GlossaryRepository {
  GlossaryRepository(this._dio);

  final Dio _dio;

  /// `data.items` may be null for a workspace without lists.
  Future<Either<Failure, List<GlossaryModel>>> glossaries({
    required String workspaceId,
  }) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.glossaries,
        queryParameters: {'workspace_id': workspaceId},
      );
      final items = envelopeData(response.data)['items'];
      return ((items as List<dynamic>?) ?? const [])
          .cast<Map<String, dynamic>>()
          .map(GlossaryModel.fromJson)
          // A row without an id cannot be sent back as `glossary_id`.
          .where((m) => m.id.isNotEmpty)
          .toList();
    });
  }
}
