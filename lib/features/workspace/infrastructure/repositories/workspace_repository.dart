import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/workspace/infrastructure/models/workspace_list_model.dart';

@lazySingleton
class WorkspaceRepository {
  WorkspaceRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, WorkspaceListModel>> list() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.workspaces,
      );
      return WorkspaceListModel.fromJson(envelopeData(response.data));
    });
  }
}
