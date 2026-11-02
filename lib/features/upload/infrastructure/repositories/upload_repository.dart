import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/network_names.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/core/utils/idempotency_key.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/models/held_file_model.dart';
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
  }) async {
    Object? refused;
    final result = await runRequest(() async {
      try {
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
      } on DioException catch (e) {
        refused = e.response?.data;
        rethrow;
      }
    });
    return result.leftMap((failure) => _pendingLimit(failure, refused));
  }

  /// The shared mapper reads only `description`; the list is in `data.held`.
  /// A list that cannot be read still leaves the reason.
  static Failure _pendingLimit(Failure failure, Object? body) {
    if (body is! Map<String, dynamic> || body['status'] != 'PENDING_LIMIT') {
      return failure;
    }
    final data = body['data'];
    final raw = data is Map<String, dynamic> ? data['held'] : null;
    try {
      final held = raw is List ? raw : const <Object?>[];
      return Failure.pendingLimit(
        held: <HeldFile>[
          for (final row in held)
            HeldFileModel.fromJson(row! as Map<String, dynamic>).toEntity(),
        ],
      );
      // fromJson on a mis-shaped body throws a TypeError (CLAUDE.md §3).
      // ignore: avoid_catching_errors
    } on TypeError {
      return const Failure.pendingLimit();
    }
  }

  /// Drops a media row. For a row whose bytes never arrived this is best
  /// effort: for an hour and a half it would count towards the workspace's
  /// limit of bytes not yet transcribed, and then it expires by itself.
  Future<Either<Failure, Unit>> deleteMedia(String id) {
    return runRequest(() async {
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
