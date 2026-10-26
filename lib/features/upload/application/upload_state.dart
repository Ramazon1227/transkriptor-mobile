part of 'upload_bloc.dart';

enum UploadStatus {
  initial,
  uploading,

  /// The file is on the server; the job did not start. [failure] says why.
  stored,

  /// Starting the job for a stored file.
  starting,
  success,
  failure,
}

@freezed
abstract class UploadState with _$UploadState {
  const factory UploadState({
    @Default(UploadStatus.initial) UploadStatus status,

    /// 0–1, bytes sent of the file.
    @Default(0) double progress,
    String? mediaId,

    /// Set when transcription was started.
    Job? job,

    /// The link is not one the backend can fetch.
    @Default(false) bool linkInvalid,
    Failure? failure,
  }) = _UploadState;
}
