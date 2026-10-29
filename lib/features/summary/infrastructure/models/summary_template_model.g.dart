// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SummaryTemplateModel _$SummaryTemplateModelFromJson(
  Map<String, dynamic> json,
) => _SummaryTemplateModel(
  id: json['id'] as String? ?? '',
  owner:
      $enumDecodeNullable(
        _$SummaryTemplateOwnerModelEnumMap,
        json['owner'],
        unknownValue: SummaryTemplateOwnerModel.unknown,
      ) ??
      SummaryTemplateOwnerModel.unknown,
  categoryId: json['category_id'] as String?,
  name: json['name'] as String? ?? '',
  prompt: json['prompt'] as String? ?? '',
  position: (json['position'] as num?)?.toInt() ?? 0,
  favorite: json['favorite'] as bool? ?? false,
);

Map<String, dynamic> _$SummaryTemplateModelToJson(
  _SummaryTemplateModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'owner': _$SummaryTemplateOwnerModelEnumMap[instance.owner]!,
  'category_id': instance.categoryId,
  'name': instance.name,
  'prompt': instance.prompt,
  'position': instance.position,
  'favorite': instance.favorite,
};

const _$SummaryTemplateOwnerModelEnumMap = {
  SummaryTemplateOwnerModel.system: 'SYSTEM',
  SummaryTemplateOwnerModel.user: 'USER',
  SummaryTemplateOwnerModel.unknown: 'unknown',
};

_SummaryTemplateCategoryModel _$SummaryTemplateCategoryModelFromJson(
  Map<String, dynamic> json,
) => _SummaryTemplateCategoryModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  position: (json['position'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SummaryTemplateCategoryModelToJson(
  _SummaryTemplateCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'position': instance.position,
};
