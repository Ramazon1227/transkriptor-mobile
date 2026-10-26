import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';

part 'pending_file.freezed.dart';

enum UploadSource { upload, recording }

/// A local file about to be sent: a recording, or one picked from the
/// phone.
@freezed
abstract class PendingFile with _$PendingFile {
  const factory PendingFile({
    required String path,

    /// With its extension; the backend reads the type from it.
    required String fileName,
    required int sizeBytes,
    required UploadSource source,

    /// Known for recordings; for a picked file the server measures it.
    Duration? duration,
  }) = _PendingFile;

  const PendingFile._();

  /// `.m4a`, lower case, or empty.
  String get extension {
    final dot = fileName.lastIndexOf('.');
    return dot < 0 ? '' : fileName.substring(dot).toLowerCase();
  }

  /// The name without its extension, for the editable title.
  String get baseName {
    final dot = fileName.lastIndexOf('.');
    return dot <= 0 ? fileName : fileName.substring(0, dot);
  }
}

/// What a send produced: the stored file, and its job when transcription
/// was started.
@freezed
abstract class UploadResult with _$UploadResult {
  const factory UploadResult({
    required String mediaId,
    Job? job,

    /// The file is stored but the job did not start (no minutes, a
    /// limit, no network). Retry starts the job only.
    Failure? startFailure,
  }) = _UploadResult;
}
