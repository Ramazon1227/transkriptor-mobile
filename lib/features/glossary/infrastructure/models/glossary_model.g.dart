// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlossaryModel _$GlossaryModelFromJson(Map<String, dynamic> json) =>
    _GlossaryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      termCount: (json['term_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GlossaryModelToJson(_GlossaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'term_count': instance.termCount,
    };
