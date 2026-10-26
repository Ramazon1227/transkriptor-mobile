import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';

/// `job_status` in the backend schema.
enum JobStatus {
  @JsonValue('QUEUED')
  queued,
  @JsonValue('RUNNING')
  running,
  @JsonValue('SUCCEEDED')
  succeeded,
  @JsonValue('FAILED')
  failed,
  @JsonValue('CANCELLED')
  cancelled,
  unknown;

  /// No further change will come; polling stops here.
  bool get isTerminal =>
      this == succeeded || this == failed || this == cancelled;
}

@freezed
abstract class Job with _$Job {
  const factory Job({
    required String id,
    required JobStatus status,
    @Default('') String mediaId,

    /// 0–100, as the backend reports it.
    @Default(0) int progress,

    /// A clean sentence for the person; the raw error stays on the server.
    String? errorMessage,
    String? transcriptId,
  }) = _Job;
}
