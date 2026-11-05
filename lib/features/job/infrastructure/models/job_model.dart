import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

/// `handler.JobResponse` in the backend.
@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'media_id') @Default('') String mediaId,
    @JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown)
    @Default(JobStatus.unknown)
    JobStatus status,
    @JsonKey(name: 'progress') @Default(0) int progress,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'transcript_id') String? transcriptId,
    @JsonKey(name: 'num_speakers') int? numSpeakers,
    @JsonKey(name: 'eta_seconds') int? etaSeconds,
    @JsonKey(name: 'slow') @Default(false) bool slow,
    // The panel's options (A-1, A-3). An older server sends none of them;
    // the lists are read element by element, so one odd entry is skipped
    // instead of failing the whole job.
    @JsonKey(name: 'glossary_id') String? glossaryId,
    @JsonKey(name: 'terms') @Default(<Object?>[]) List<Object?> terms,
    @JsonKey(name: 'terms_applied') @Default(0) int termsApplied,
    @JsonKey(name: 'speaker_hints')
    @Default(<Object?>[])
    List<Object?> speakerHints,
  }) = _JobModel;

  const JobModel._();

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Job toEntity() => Job(
    id: id,
    mediaId: mediaId,
    status: status,
    progress: progress.clamp(0, 100),
    errorMessage: (errorMessage?.isEmpty ?? true) ? null : errorMessage,
    transcriptId: (transcriptId?.isEmpty ?? true) ? null : transcriptId,
    numSpeakers: numSpeakers,
    etaSeconds: etaSeconds == null || etaSeconds! < 0 ? null : etaSeconds,
    slow: slow,
    glossaryId: (glossaryId?.isEmpty ?? true) ? null : glossaryId,
    terms: [
      for (final t in terms)
        if (t is String && t.trim().isNotEmpty) t,
    ],
    termsApplied: termsApplied < 0 ? 0 : termsApplied,
    speakerHints: [
      for (final h in speakerHints)
        if (_hint(h) case final SpeakerHint hint) hint,
    ],
  );

  /// One `{label, start_ms, end_ms}`; null when it is not one.
  static SpeakerHint? _hint(Object? raw) {
    if (raw is! Map) return null;
    final label = raw['label'];
    final start = raw['start_ms'];
    final end = raw['end_ms'];
    if (label is! String || label.isEmpty || start is! num || end is! num) {
      return null;
    }
    if (end <= start || start < 0) return null;
    return SpeakerHint(
      label: label,
      startMs: start.round(),
      endMs: end.round(),
    );
  }
}
