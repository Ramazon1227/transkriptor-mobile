import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

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
  /// Opens the system picker. `Right(null)` when the person closed it.
  Future<Either<Failure, PendingFile?>> pickFile();

  /// Creates the media row, uploads the bytes to the signed URL, confirms,
  /// and — when [startTranscription] — starts a job. [title] replaces the
  /// file name; the extension is kept. [onProgress] gets 0–1.
  Future<Either<Failure, UploadResult>> upload({
    required PendingFile file,
    required String workspaceId,
    required String title,
    required bool startTranscription,
    int? numSpeakers,
    void Function(double progress)? onProgress,
  });

  /// Starts transcription of a file already stored (a retry after
  /// `UploadResult.startFailure`).
  Future<Either<Failure, Job>> startTranscription({
    required String mediaId,
    int? numSpeakers,
  });

  /// Hands a YouTube, Google Drive or Dropbox link to the server, which
  /// downloads it itself.
  Future<Either<Failure, Job>> startLink({
    required String url,
    required String workspaceId,
    int? numSpeakers,
  });
}
