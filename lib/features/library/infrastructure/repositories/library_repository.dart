import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/library/infrastructure/models/library_item_model.dart';

@lazySingleton
class LibraryRepository {
  LibraryRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, List<LibraryItemModel>>> getItems({
    required String workspaceId,
  }) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.library,
        queryParameters: {'workspace_id': workspaceId},
      );
      final items = envelopeData(response.data)['items'];
      return ((items as List<dynamic>?) ?? const [])
          .cast<Map<String, dynamic>>()
          .map(LibraryItemModel.fromJson)
          .toList();
    });
  }
}
