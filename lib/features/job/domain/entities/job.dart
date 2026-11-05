import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';

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

    /// The speaker count chosen at upload; null lets the server decide.
    int? numSpeakers,

    /// Estimated seconds left while running; null when the server has no
    /// estimate.
    int? etaSeconds,

    /// The usual time has passed and the job is still running.
    @Default(false) bool slow,

    /// The «Atamalar» list chosen at upload (A-1); null when none, or when
    /// it was deleted since.
    String? glossaryId,

    /// Terms written for this file only (A-1).
    @Default(<String>[]) List<String> terms,

    /// How many replacements the chosen list made in the result.
    @Default(0) int termsApplied,

    /// The speaker hints marked before transcription (A-3).
    @Default(<SpeakerHint>[]) List<SpeakerHint> speakerHints,
  }) = _Job;

  const Job._();

  /// What a retry sends again, so the new job is started like this one.
  JobOptions get options => JobOptions(
    glossaryId: glossaryId,
    terms: terms,
    speakerHints: speakerHints,
  );
}
