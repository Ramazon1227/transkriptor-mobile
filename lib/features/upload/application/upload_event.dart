part of 'upload_bloc.dart';

sealed class UploadEvent {
  const UploadEvent();
}

final class UploadFileSubmitted extends UploadEvent {
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

final class UploadLinkSubmitted extends UploadEvent {
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
final class UploadStartRetried extends UploadEvent {
  const UploadStartRetried({required this.mediaId, this.numSpeakers});

  final String mediaId;
  final int? numSpeakers;
}
