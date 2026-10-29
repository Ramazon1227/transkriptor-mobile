import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/rating/domain/entities/rating.dart';

part 'rating_model.freezed.dart';
part 'rating_model.g.dart';

/// `models.Rating` in the backend.
@freezed
abstract class RatingModel with _$RatingModel {
  const factory RatingModel({
    @JsonKey(name: 'score') @Default(0) int score,
    @JsonKey(name: 'note') @Default('') String note,
  }) = _RatingModel;

  const RatingModel._();

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  /// A score outside 1–5 is read as "not rated".
  Rating? toEntity() =>
      score < 1 || score > 5 ? null : Rating(score: score, note: note);
}

/// `handler.RatingResponse`: `rating` is null until the caller rates.
@freezed
abstract class RatingEnvelopeModel with _$RatingEnvelopeModel {
  const factory RatingEnvelopeModel({
    @JsonKey(name: 'rating') RatingModel? rating,
  }) = _RatingEnvelopeModel;

  factory RatingEnvelopeModel.fromJson(Map<String, dynamic> json) =>
      _$RatingEnvelopeModelFromJson(json);
}
