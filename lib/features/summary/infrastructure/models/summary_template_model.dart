import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';

part 'summary_template_model.freezed.dart';
part 'summary_template_model.g.dart';

enum SummaryTemplateOwnerModel {
  @JsonValue('SYSTEM')
  system,
  @JsonValue('USER')
  user,
  unknown,
}

/// `models.SummaryTemplate` in the backend. `published`, timestamps and
/// `source_template_id` are not read: the list only carries what the
/// caller may use.
@freezed
abstract class SummaryTemplateModel with _$SummaryTemplateModel {
  const factory SummaryTemplateModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown)
    @Default(SummaryTemplateOwnerModel.unknown)
    SummaryTemplateOwnerModel owner,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'prompt') @Default('') String prompt,
    @JsonKey(name: 'position') @Default(0) int position,
    @JsonKey(name: 'favorite') @Default(false) bool favorite,
  }) = _SummaryTemplateModel;

  const SummaryTemplateModel._();

  factory SummaryTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryTemplateModelFromJson(json);

  SummaryTemplate toEntity() => SummaryTemplate(
    id: id,
    name: name,
    owner: switch (owner) {
      SummaryTemplateOwnerModel.system => SummaryTemplateOwner.system,
      SummaryTemplateOwnerModel.user => SummaryTemplateOwner.user,
      SummaryTemplateOwnerModel.unknown => SummaryTemplateOwner.unknown,
    },
    categoryId: (categoryId?.isEmpty ?? true) ? null : categoryId,
    prompt: prompt,
    position: position,
    favorite: favorite,
  );
}

/// `models.SummaryTemplateCategory`; `templates` (an admin count) is not
/// read.
@freezed
abstract class SummaryTemplateCategoryModel
    with _$SummaryTemplateCategoryModel {
  const factory SummaryTemplateCategoryModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'position') @Default(0) int position,
  }) = _SummaryTemplateCategoryModel;

  const SummaryTemplateCategoryModel._();

  factory SummaryTemplateCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryTemplateCategoryModelFromJson(json);

  SummaryTemplateCategory toEntity() =>
      SummaryTemplateCategory(id: id, name: name, position: position);
}
