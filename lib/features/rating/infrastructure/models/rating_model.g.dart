// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => _RatingModel(
  score: (json['score'] as num?)?.toInt() ?? 0,
  note: json['note'] as String? ?? '',
);

Map<String, dynamic> _$RatingModelToJson(_RatingModel instance) =>
    <String, dynamic>{'score': instance.score, 'note': instance.note};

_RatingEnvelopeModel _$RatingEnvelopeModelFromJson(Map<String, dynamic> json) =>
    _RatingEnvelopeModel(
      rating: json['rating'] == null
          ? null
          : RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RatingEnvelopeModelToJson(
  _RatingEnvelopeModel instance,
) => <String, dynamic>{'rating': instance.rating};
