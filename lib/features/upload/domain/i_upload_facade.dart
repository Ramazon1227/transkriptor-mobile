import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/upload_cancel.dart';

/// The extensions the backend accepts (`models.ClassifyFile`).
const List<String> supportedExtensions = [
  'mp3',
  'm4a',
  'wav',
  'webm',
  'mp4',
  'mov',
  'mkv',
];

abstract interface class IUploadFacade {
  /// Opens the system picker; several files can be marked. An empty list
  /// when the person closed it.
  Future<Either<Failure, List<PendingFile>>> pickFiles();

  /// Creates the media row, uploads the bytes to the signed URL, confirms,
  /// and — when [startTranscription] — starts a job with [jobKey] as its
  /// idempotency key; a retry of that start ([startTranscription]) sends
  /// the same key. [title] replaces the file name; the extension is kept.
  /// [onProgress] gets 0–1. [cancel] stops it: the half-made row is
  /// deleted, no job starts, and the answer is `Failure.cancelled()`.
  /// [folderId] goes with the media row (null: no folder); [options] with
  /// the job (A-1, A-3).
  Future<Either<Failure, UploadResult>> upload({
    required PendingFile file,
    required String workspaceId,
    required String title,
    required bool startTranscription,
    required String jobKey,
    String? folderId,
    int? numSpeakers,
    JobService? service,
    JobOptions options = const JobOptions(),
    void Function(double progress)? onProgress,
    UploadCancel? cancel,
  });

  /// [service] null lets the server decide (the file's previous job, else
  /// transcription); the pages always send it.
  /// Starts transcription of a file already stored (a retry after
  /// `UploadResult.startFailure`). A file that already has a queued or
  /// running job is `Failure.jobActive`.
  Future<Either<Failure, Job>> startTranscription({
    required String mediaId,
    required String idempotencyKey,
    int? numSpeakers,
    JobService? service,
    JobOptions options = const JobOptions(),
  });

  /// Deletes a file that holds a place in the limit
  /// (`Failure.pendingLimit`).
  Future<Either<Failure, Unit>> deleteHeld(String mediaId);

  /// Hands a YouTube, Google Drive or Dropbox link to the server, which
  /// downloads it itself. [idempotencyKey] is the action's, as above.
  Future<Either<Failure, Job>> startLink({
    required String url,
    required String workspaceId,
    required String idempotencyKey,
    String? folderId,
    int? numSpeakers,
    JobService? service,
    JobOptions options = const JobOptions(),
  });
}
