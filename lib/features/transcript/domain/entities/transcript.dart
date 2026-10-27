import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript.freezed.dart';

@freezed
abstract class Speaker with _$Speaker {
  const factory Speaker({
    required String id,

    /// "Maʼruzachi 1" until someone renames it.
    required String label,

    /// First-appearance order, from 1. Picks the speaker colour.
    @Default(0) int ordinal,
  }) = _Speaker;
}

@freezed
abstract class Segment with _$Segment {
  const factory Segment({
    required String id,
    required Duration start,
    required Duration end,
    required String text,

    /// Null without diarization: there is no fake single speaker.
    String? speakerId,
    @Default(false) bool edited,
  }) = _Segment;
}

@freezed
abstract class Transcript with _$Transcript {
  const factory Transcript({
    required String id,
    required String title,
    Duration? duration,
    @Default(<Speaker>[]) List<Speaker> speakers,

    /// In position order, as the API returns them.
    @Default(<Segment>[]) List<Segment> segments,

    /// Optimistic lock for segment text. Sent with every text edit; the
    /// server answers 409 when someone saved in between.
    @Default(0) int revision,
  }) = _Transcript;
}

/// The answer to a segment text edit: the stored segment and the
/// transcript's new revision.
@freezed
abstract class SegmentEdit with _$SegmentEdit {
  const factory SegmentEdit({required Segment segment, required int revision}) =
      _SegmentEdit;
}
