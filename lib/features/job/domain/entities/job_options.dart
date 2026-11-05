import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_options.freezed.dart';

/// «Sarvar: 0:15–0:25» — an interval of one file tied to a person, marked
/// before transcription (ClickUp A-3). Only a time and a name, no voice
/// print. The STT service does not take them yet: the backend stores them
/// with the job and sends them only behind an off-by-default flag.
@freezed
abstract class SpeakerHint with _$SpeakerHint {
  const factory SpeakerHint({
    required String label,
    required int startMs,
    required int endMs,
  }) = _SpeakerHint;
}

/// The job options of the «Qoʻshimcha sozlamalar» panel that travel with
/// `POST /job`, `/media/youtube` and `/media/cloud` (A-1, A-3). Empty ones
/// are not sent: an old server ignores the fields, a new one reads absent
/// as none. Value equality (lists included), so it can be part of an
/// idempotency key's subject.
@freezed
abstract class JobOptions with _$JobOptions {
  const factory JobOptions({
    /// A live «Atamalar» list of the job's workspace.
    String? glossaryId,

    /// Terms for this file only, already cleaned (`AdvancedRules`).
    @Default(<String>[]) List<String> terms,

    /// This file's speaker hints, sorted by start.
    @Default(<SpeakerHint>[]) List<SpeakerHint> speakerHints,
  }) = _JobOptions;

  const JobOptions._();

  bool get isEmpty =>
      (glossaryId == null || glossaryId!.isEmpty) &&
      terms.isEmpty &&
      speakerHints.isEmpty;
}
