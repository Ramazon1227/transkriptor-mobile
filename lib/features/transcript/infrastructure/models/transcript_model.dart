import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

part 'transcript_model.freezed.dart';
part 'transcript_model.g.dart';

/// `models.Speaker` in the backend.
@freezed
abstract class SpeakerModel with _$SpeakerModel {
  const factory SpeakerModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'label') @Default('') String label,
    @JsonKey(name: 'ordinal') @Default(0) int ordinal,
  }) = _SpeakerModel;

  const SpeakerModel._();

  factory SpeakerModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerModelFromJson(json);

  Speaker toEntity() => Speaker(id: id, label: label, ordinal: ordinal);
}

/// `models.Segment` in the backend. Words are not read: the service gives
/// segment times only, so `words` is always empty.
@freezed
abstract class SegmentModel with _$SegmentModel {
  const factory SegmentModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'start_ms') @Default(0) int startMs,
    @JsonKey(name: 'end_ms') @Default(0) int endMs,
    @JsonKey(name: 'text') @Default('') String text,
    @JsonKey(name: 'speaker_id') String? speakerId,
    @JsonKey(name: 'edited') @Default(false) bool edited,
  }) = _SegmentModel;

  const SegmentModel._();

  factory SegmentModel.fromJson(Map<String, dynamic> json) =>
      _$SegmentModelFromJson(json);

  Segment toEntity() => Segment(
    id: id,
    start: Duration(milliseconds: startMs),
    end: Duration(milliseconds: endMs),
    text: text,
    speakerId: (speakerId?.isEmpty ?? true) ? null : speakerId,
    edited: edited,
  );
}

/// `models.Transcript` in the backend.
@freezed
abstract class TranscriptModel with _$TranscriptModel {
  const factory TranscriptModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'duration_ms') int? durationMs,
    @JsonKey(name: 'speakers')
    @Default(<SpeakerModel>[])
    List<SpeakerModel> speakers,
    @JsonKey(name: 'segments')
    @Default(<SegmentModel>[])
    List<SegmentModel> segments,
    @JsonKey(name: 'revision') @Default(0) int revision,
  }) = _TranscriptModel;

  const TranscriptModel._();

  factory TranscriptModel.fromJson(Map<String, dynamic> json) =>
      _$TranscriptModelFromJson(json);

  Transcript toEntity() => Transcript(
    id: id,
    title: title,
    duration: durationMs == null || durationMs! <= 0
        ? null
        : Duration(milliseconds: durationMs!),
    speakers: speakers.map((s) => s.toEntity()).toList(),
    segments: segments.map((s) => s.toEntity()).toList(),
    revision: revision,
  );
}

/// `handler.SegmentResponse` in the backend. `new_speaker` is there only
/// when the edit was `new_speaker: true`.
@freezed
abstract class SegmentEditModel with _$SegmentEditModel {
  const factory SegmentEditModel({
    @JsonKey(name: 'segment') required SegmentModel segment,
    @JsonKey(name: 'revision') @Default(0) int revision,
    @JsonKey(name: 'new_speaker') SpeakerModel? newSpeaker,
  }) = _SegmentEditModel;

  const SegmentEditModel._();

  factory SegmentEditModel.fromJson(Map<String, dynamic> json) =>
      _$SegmentEditModelFromJson(json);

  SegmentEdit toEntity() => SegmentEdit(
    segment: segment.toEntity(),
    revision: revision,
    newSpeaker: newSpeaker?.toEntity(),
  );
}

/// `handler.SpeakerResponse` in the backend.
@freezed
abstract class SpeakerEditModel with _$SpeakerEditModel {
  const factory SpeakerEditModel({
    @JsonKey(name: 'speaker') required SpeakerModel speaker,
  }) = _SpeakerEditModel;

  factory SpeakerEditModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerEditModelFromJson(json);
}

/// `handler.SplitSegmentResponse` in the backend: always two segments.
@freezed
abstract class SegmentSplitModel with _$SegmentSplitModel {
  const factory SegmentSplitModel({
    @JsonKey(name: 'segments')
    @Default(<SegmentModel>[])
    List<SegmentModel> segments,
    @JsonKey(name: 'revision') @Default(0) int revision,
  }) = _SegmentSplitModel;

  const SegmentSplitModel._();

  factory SegmentSplitModel.fromJson(Map<String, dynamic> json) =>
      _$SegmentSplitModelFromJson(json);

  /// The repository has checked there are two.
  SegmentSplit toEntity() => SegmentSplit(
    first: segments[0].toEntity(),
    second: segments[1].toEntity(),
    revision: revision,
  );
}

/// `handler.MergeSegmentResponse` in the backend.
@freezed
abstract class SegmentMergeModel with _$SegmentMergeModel {
  const factory SegmentMergeModel({
    @JsonKey(name: 'segment') required SegmentModel segment,
    @JsonKey(name: 'removed_id') @Default('') String removedId,
    @JsonKey(name: 'revision') @Default(0) int revision,
  }) = _SegmentMergeModel;

  const SegmentMergeModel._();

  factory SegmentMergeModel.fromJson(Map<String, dynamic> json) =>
      _$SegmentMergeModelFromJson(json);

  SegmentMerge toEntity() => SegmentMerge(
    segment: segment.toEntity(),
    removedId: removedId,
    revision: revision,
  );
}
