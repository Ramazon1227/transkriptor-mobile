import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/library/infrastructure/models/folder_model.dart';
import 'package:transkriptor_uz/features/library/infrastructure/models/library_item_model.dart';

@lazySingleton
class LibraryRepository {
  LibraryRepository(this._dio);

  final Dio _dio;

  /// [folderId] null lists every file, folders included. [source] is the
  /// backend's `media_source` (UPLOAD, URL, RECORDING, API); null is all.
  Future<Either<Failure, List<LibraryItemModel>>> getItems({
    required String workspaceId,
    String? folderId,
    String? source,
  }) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.library,
        queryParameters: {
          'workspace_id': workspaceId,
          'folder_id': ?folderId,
          'source': ?source,
        },
      );
      final items = envelopeData(response.data)['items'];
      return ((items as List<dynamic>?) ?? const [])
          .cast<Map<String, dynamic>>()
          .map(LibraryItemModel.fromJson)
          .toList();
    });
  }

  Future<Either<Failure, List<FolderModel>>> getFolders({
    required String workspaceId,
  }) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.workspaceFolders(workspaceId),
      );
      final items = envelopeData(response.data)['items'];
      return ((items as List<dynamic>?) ?? const [])
          .cast<Map<String, dynamic>>()
          .map(FolderModel.fromJson)
          .toList();
    });
  }

  Future<Either<Failure, FolderModel>> createFolder({
    required String workspaceId,
    required String name,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.workspaceFolders(workspaceId),
        data: {'name': name},
      );
      return _folder(response.data);
    });
  }

  Future<Either<Failure, FolderModel>> renameFolder({
    required String workspaceId,
    required String folderId,
    required String name,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.workspaceFolder(workspaceId, folderId),
        data: {'name': name},
      );
      return _folder(response.data);
    });
  }

  /// The files inside move out of the folder; they are not deleted.
  Future<Either<Failure, Unit>> deleteFolder({
    required String workspaceId,
    required String folderId,
  }) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(
        Endpoints.workspaceFolder(workspaceId, folderId),
      );
      return unit;
    });
  }

  /// `PATCH /media/:id`. Only the keys in [patch] change; `folder_id: null`
  /// moves the file out of its folder, which is why the body is a map.
  Future<Either<Failure, LibraryItemModel>> updateMedia({
    required String mediaId,
    required Map<String, Object?> patch,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.mediaById(mediaId),
        data: patch,
      );
      return LibraryItemModel.fromJson(
        envelopeData(response.data)['item'] as Map<String, dynamic>,
      );
    });
  }

  /// `DELETE /media/:id`: the file and its transcript go, a running job
  /// is cancelled and its minutes refunded.
  Future<Either<Failure, Unit>> deleteMedia(String mediaId) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(Endpoints.mediaById(mediaId));
      return unit;
    });
  }

  static FolderModel _folder(Map<String, dynamic>? body) =>
      FolderModel.fromJson(
        envelopeData(body)['folder'] as Map<String, dynamic>,
      );
}
