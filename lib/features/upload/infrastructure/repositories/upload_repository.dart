import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/network_names.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/core/utils/idempotency_key.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/models/media_created_model.dart';

@lazySingleton
class UploadRepository {
  UploadRepository(this._dio, @Named(NetworkNames.uploadDio) this._uploadDio);

  final Dio _dio;

  /// No token interceptor: the signed URL is its own authority.
  final Dio _uploadDio;

  Future<Either<Failure, MediaCreatedModel>> createMedia({
    required String workspaceId,
    required String fileName,
    required int sizeBytes,
    required String source,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.media,
        data: {
          'workspace_id': workspaceId,
          'filename': fileName,
          'size_bytes': sizeBytes,
          'source': source,
        },
      );
      return MediaCreatedModel.fromJson(envelopeData(response.data));
    });
  }

  /// Drops a row whose bytes never arrived: for an hour and a half it would
  /// hold a place in the workspace's limit of files not yet transcribed, and
  /// a retry of several files would be refused. Best effort, so nothing to
  /// report: the row expires by itself.
  Future<void> deleteMedia(String id) async {
    await runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(Endpoints.mediaById(id));
      return unit;
    });
  }

  /// Streams the file, so a long recording is never held in memory.
  Future<Either<Failure, Unit>> putFile({
    required String uploadUrl,
    required String path,
    required int sizeBytes,
    required String contentType,
    void Function(int sent, int total)? onProgress,
  }) {
    return runRequest(() async {
      await _uploadDio.put<void>(
        uploadUrl,
        data: File(path).openRead(),
        options: Options(
          headers: {
            Headers.contentLengthHeader: sizeBytes,
            Headers.contentTypeHeader: contentType,
          },
        ),
        onSendProgress: onProgress,
      );
      return unit;
    });
  }

  Future<Either<Failure, Unit>> confirm(String mediaId) {
    return runRequest(() async {
      await _dio.post<Map<String, dynamic>>(Endpoints.mediaConfirm(mediaId));
      return unit;
    });
  }

  /// [youtube] picks `/media/youtube`; otherwise `/media/cloud` (Google
  /// Drive, Dropbox).
  Future<Either<Failure, JobModel>> startLink({
    required String url,
    required String workspaceId,
    required bool youtube,
    int? numSpeakers,
  }) {
    final key = newIdempotencyKey();
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        youtube ? Endpoints.mediaYoutube : Endpoints.mediaCloud,
        data: {
          'url': url,
          'workspace_id': workspaceId,
          'num_speakers': ?numSpeakers,
          'idempotency_key': key,
        },
        options: Options(headers: {'Idempotency-Key': key}),
      );
      return JobModel.fromJson(envelopeData(response.data));
    });
  }
}
