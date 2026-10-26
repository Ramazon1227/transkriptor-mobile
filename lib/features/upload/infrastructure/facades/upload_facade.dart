import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/media_picker.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart';

@LazySingleton(as: IUploadFacade)
class UploadFacade implements IUploadFacade {
  UploadFacade(this._repository, this._jobs, this._picker, this._changes);

  final UploadRepository _repository;
  final JobRepository _jobs;
  final MediaPicker _picker;
  final LibraryChanges _changes;

  @override
  Future<Either<Failure, PendingFile?>> pickFile() async {
    try {
      return Right(await _picker.pick());
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<Either<Failure, UploadResult>> upload({
    required PendingFile file,
    required String workspaceId,
    required String title,
    required bool startTranscription,
    int? numSpeakers,
    void Function(double progress)? onProgress,
  }) async {
    final cleanTitle = title.trim().isEmpty ? file.baseName : title.trim();
    final created = await _repository.createMedia(
      workspaceId: workspaceId,
      fileName: '$cleanTitle${file.extension}',
      sizeBytes: file.sizeBytes,
      source: file.source == UploadSource.recording ? 'RECORDING' : 'UPLOAD',
    );
    final media = created.fold((_) => null, (m) => m);
    if (media == null || media.id.isEmpty || media.uploadUrl.isEmpty) {
      return Left(_failureOf(created));
    }

    final put = await _repository.putFile(
      uploadUrl: media.uploadUrl,
      path: file.path,
      sizeBytes: file.sizeBytes,
      contentType: _contentType(file.extension),
      onProgress: onProgress == null
          ? null
          : (sent, total) {
              final whole = total > 0 ? total : file.sizeBytes;
              if (whole > 0) onProgress((sent / whole).clamp(0.0, 1.0));
            },
    );
    if (put.isLeft()) return Left(_failureOf(put));

    final confirmed = await _repository.confirm(media.id);
    if (confirmed.isLeft()) return Left(_failureOf(confirmed));

    // The server has the file now; our own recording copy is no longer
    // needed. A picked file is the person's own and is never touched.
    if (file.source == UploadSource.recording) await _deleteQuietly(file.path);
    _changes.notify();

    if (!startTranscription) return Right(UploadResult(mediaId: media.id));

    // A failed start is not a failed send: the file is stored, and a retry
    // must start the job, not upload the bytes again.
    final job = await _startJob(media.id, numSpeakers);
    return Right(
      job.fold(
        (failure) => UploadResult(mediaId: media.id, startFailure: failure),
        (j) => UploadResult(mediaId: media.id, job: j),
      ),
    );
  }

  @override
  Future<Either<Failure, Job>> startTranscription({
    required String mediaId,
    int? numSpeakers,
  }) => _startJob(mediaId, numSpeakers);

  Future<Either<Failure, Job>> _startJob(
    String mediaId,
    int? numSpeakers,
  ) async {
    final result = await _jobs.createJob(
      mediaId: mediaId,
      numSpeakers: numSpeakers,
    );
    // Minutes were reserved and the file now has a job.
    if (result.isRight()) _changes.notify();
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Job>> startLink({
    required String url,
    required String workspaceId,
    int? numSpeakers,
  }) async {
    final host = Uri.tryParse(url.trim())?.host.toLowerCase() ?? '';
    final youtube = host.endsWith('youtube.com') || host == 'youtu.be';
    final result = await _repository.startLink(
      url: url.trim(),
      workspaceId: workspaceId,
      youtube: youtube,
      numSpeakers: numSpeakers,
    );
    if (result.isRight()) _changes.notify();
    return result.map((m) => m.toEntity());
  }

  static Future<void> _deleteQuietly(String path) async {
    try {
      await File(path).delete();
    } on Object {
      // A leftover file costs space, not correctness.
    }
  }

  static Failure _failureOf<T>(Either<Failure, T> result) =>
      result.fold((f) => f, (_) => const Failure.parsing());

  static String _contentType(String extension) => switch (extension) {
    '.m4a' => 'audio/mp4',
    '.mp3' => 'audio/mpeg',
    '.wav' => 'audio/wav',
    '.webm' => 'audio/webm',
    '.mp4' => 'video/mp4',
    '.mov' => 'video/quicktime',
    '.mkv' => 'video/x-matroska',
    _ => 'application/octet-stream',
  };
}
