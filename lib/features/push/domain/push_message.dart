import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_message.freezed.dart';

/// What a notification is about. The backend sends `type: "job"` when a
/// transcription finishes or fails.
@freezed
abstract class PushMessage with _$PushMessage {
  const factory PushMessage({
    String? jobId,

    /// Set only when the transcript is ready.
    String? transcriptId,
  }) = _PushMessage;

  const PushMessage._();

  /// The FCM `data` map; anything that is not a job message is null.
  static PushMessage? fromData(Map<String, dynamic> data) {
    if (data['type'] != 'job') return null;
    String? text(String key) {
      final v = data[key];
      return v is String && v.isNotEmpty ? v : null;
    }

    final jobId = text('job_id');
    if (jobId == null) return null;
    return PushMessage(jobId: jobId, transcriptId: text('transcript_id'));
  }
}
