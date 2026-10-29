import 'package:freezed_annotation/freezed_annotation.dart';

part 'sentiment.freezed.dart';

/// `PENDING` until the backend's queue writes the labels. A `PENDING`
/// that outlived its deadline comes back as `FAILED`.
enum SentimentStatus { pending, done, failed, unknown }

/// One segment's label. Neutral carries no colour in the UI.
enum SentimentLabel { positive, neutral, negative, unknown }

/// Fractions (0..1) of the talk time of the analysed segments.
/// [score] = positive − negative, −1..1.
@freezed
abstract class SentimentShare with _$SentimentShare {
  const factory SentimentShare({
    @Default(0) double positive,
    @Default(0) double neutral,
    @Default(0) double negative,
    @Default(0) double score,
  }) = _SentimentShare;

  const SentimentShare._();

  /// Nothing was analysed (all three are zero).
  bool get isEmpty => positive + neutral + negative <= 0;
}

/// One speaker's shares, from the transcript's *current* speaker
/// assignment. [speakerId] is null for segments without a speaker.
@freezed
abstract class SpeakerSentiment with _$SpeakerSentiment {
  const factory SpeakerSentiment({
    String? speakerId,
    @Default('') String label,
    @Default(Duration.zero) Duration talk,
    @Default(SentimentShare()) SentimentShare share,
  }) = _SpeakerSentiment;
}

/// `GET /transcript/:id/sentiment` when one was ever requested.
@freezed
abstract class SentimentAnalysis with _$SentimentAnalysis {
  const factory SentimentAnalysis({
    required SentimentStatus status,

    /// A 1–2 sentence Uzbek note from the model; empty until `DONE`.
    @Default('') String note,

    /// A fixed Uzbek sentence from the server when the run `FAILED`.
    String? error,
    @Default(0) int attempt,
    @Default('') String model,

    /// The transcript text changed after the analysis: offer a re-run.
    @Default(false) bool outdated,

    /// Segments created after the analysis (a split): not counted.
    @Default(0) int unlabeled,
    @Default(SentimentShare()) SentimentShare overall,
    @Default(<SpeakerSentiment>[]) List<SpeakerSentiment> speakers,

    /// Segment id → label, in the server's order. Empty unless `DONE`.
    @Default(<String, SentimentLabel>{}) Map<String, SentimentLabel> labels,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SentimentAnalysis;

  const SentimentAnalysis._();

  bool get isPending => status == SentimentStatus.pending;
  bool get isDone => status == SentimentStatus.done;
}
