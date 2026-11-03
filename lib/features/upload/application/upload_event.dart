part of 'upload_bloc.dart';

sealed class UploadEvent {
  const UploadEvent();
}

/// Sending work: one at a time, a second tap while one runs is ignored.
sealed class UploadSendEvent extends UploadEvent {
  const UploadSendEvent();
}

final class UploadFileSubmitted extends UploadSendEvent {
  const UploadFileSubmitted({
    required this.file,
    required this.workspaceId,
    required this.title,
    required this.startTranscription,
    this.numSpeakers,
  });

  final PendingFile file;
  final String workspaceId;
  final String title;

  /// False for "save only": the file is stored, no minutes are reserved.
  final bool startTranscription;

  /// Null lets the server decide.
  final int? numSpeakers;
}

final class UploadLinkSubmitted extends UploadSendEvent {
  const UploadLinkSubmitted({
    required this.url,
    required this.workspaceId,
    this.numSpeakers,
  });

  final String url;
  final String workspaceId;
  final int? numSpeakers;
}

/// Start transcription of a file that was stored when the first start
/// failed.
final class UploadStartRetried extends UploadSendEvent {
  const UploadStartRetried({required this.mediaId, this.numSpeakers});

  final String mediaId;
  final int? numSpeakers;
}

/// Stops the file upload that is running (U-2). Its own handler, so the
/// send transformer does not drop it while the upload runs. A job whose
/// start was already sent is not taken back.
final class UploadCancelRequested extends UploadEvent {
  const UploadCancelRequested();
}
