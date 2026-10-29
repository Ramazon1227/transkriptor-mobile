import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';

part 'sentiment_model.freezed.dart';
part 'sentiment_model.g.dart';

enum SentimentStatusModel {
  @JsonValue('PENDING')
  pending,
  @JsonValue('DONE')
  done,
  @JsonValue('FAILED')
  failed,
  unknown,
}

enum SentimentLabelModel {
  @JsonValue('POSITIVE')
  positive,
  @JsonValue('NEUTRAL')
  neutral,
  @JsonValue('NEGATIVE')
  negative,
  unknown,
}

/// `models.SentimentShare`.
@freezed
abstract class SentimentShareModel with _$SentimentShareModel {
  const factory SentimentShareModel({
    @JsonKey(name: 'positive') @Default(0) double positive,
    @JsonKey(name: 'neutral') @Default(0) double neutral,
    @JsonKey(name: 'negative') @Default(0) double negative,
    @JsonKey(name: 'score') @Default(0) double score,
  }) = _SentimentShareModel;

  const SentimentShareModel._();

  factory SentimentShareModel.fromJson(Map<String, dynamic> json) =>
      _$SentimentShareModelFromJson(json);

  SentimentShare toEntity() => SentimentShare(
    positive: positive,
    neutral: neutral,
    negative: negative,
    score: score,
  );
}

/// `models.SpeakerSentiment`: the share fields sit flat beside the
/// speaker's own (Go embeds `SentimentShare`).
@freezed
abstract class SpeakerSentimentModel with _$SpeakerSentimentModel {
  const factory SpeakerSentimentModel({
    @JsonKey(name: 'speaker_id') String? speakerId,
    @JsonKey(name: 'label') @Default('') String label,
    @JsonKey(name: 'talk_ms') @Default(0) int talkMs,
    @JsonKey(name: 'positive') @Default(0) double positive,
    @JsonKey(name: 'neutral') @Default(0) double neutral,
    @JsonKey(name: 'negative') @Default(0) double negative,
    @JsonKey(name: 'score') @Default(0) double score,
  }) = _SpeakerSentimentModel;

  const SpeakerSentimentModel._();

  factory SpeakerSentimentModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerSentimentModelFromJson(json);

  SpeakerSentiment toEntity() => SpeakerSentiment(
    speakerId: (speakerId?.isEmpty ?? true) ? null : speakerId,
    label: label,
    talk: Duration(milliseconds: talkMs < 0 ? 0 : talkMs),
    share: SentimentShare(
      positive: positive,
      neutral: neutral,
      negative: negative,
      score: score,
    ),
  );
}

/// `models.SegmentSentiment`.
@freezed
abstract class SegmentSentimentModel with _$SegmentSentimentModel {
  const factory SegmentSentimentModel({
    @JsonKey(name: 'segment_id') @Default('') String segmentId,
    @JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown)
    @Default(SentimentLabelModel.unknown)
    SentimentLabelModel label,
  }) = _SegmentSentimentModel;

  factory SegmentSentimentModel.fromJson(Map<String, dynamic> json) =>
      _$SegmentSentimentModelFromJson(json);
}

/// `models.Sentiment` in the backend.
@freezed
abstract class SentimentModel with _$SentimentModel {
  const factory SentimentModel({
    @JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown)
    @Default(SentimentStatusModel.unknown)
    SentimentStatusModel status,
    @JsonKey(name: 'note') @Default('') String note,
    @JsonKey(name: 'error') String? error,
    @JsonKey(name: 'attempt') @Default(0) int attempt,
    @JsonKey(name: 'model') @Default('') String model,
    @JsonKey(name: 'outdated') @Default(false) bool outdated,
    @JsonKey(name: 'unlabeled') @Default(0) int unlabeled,
    @JsonKey(name: 'overall') SentimentShareModel? overall,
    @JsonKey(name: 'speakers')
    @Default(<SpeakerSentimentModel>[])
    List<SpeakerSentimentModel> speakers,
    @JsonKey(name: 'segments')
    @Default(<SegmentSentimentModel>[])
    List<SegmentSentimentModel> segments,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SentimentModel;

  const SentimentModel._();

  factory SentimentModel.fromJson(Map<String, dynamic> json) =>
      _$SentimentModelFromJson(json);

  SentimentAnalysis toEntity() => SentimentAnalysis(
    status: switch (status) {
      SentimentStatusModel.pending => SentimentStatus.pending,
      SentimentStatusModel.done => SentimentStatus.done,
      SentimentStatusModel.failed => SentimentStatus.failed,
      SentimentStatusModel.unknown => SentimentStatus.unknown,
    },
    note: note.trim(),
    error: (error?.trim().isEmpty ?? true) ? null : error!.trim(),
    attempt: attempt,
    model: model,
    outdated: outdated,
    unlabeled: unlabeled < 0 ? 0 : unlabeled,
    overall: overall?.toEntity() ?? const SentimentShare(),
    speakers: speakers.map((s) => s.toEntity()).toList(),
    labels: {
      for (final s in segments)
        if (s.segmentId.isNotEmpty)
          s.segmentId: switch (s.label) {
            SentimentLabelModel.positive => SentimentLabel.positive,
            SentimentLabelModel.neutral => SentimentLabel.neutral,
            SentimentLabelModel.negative => SentimentLabel.negative,
            SentimentLabelModel.unknown => SentimentLabel.unknown,
          },
    },
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
