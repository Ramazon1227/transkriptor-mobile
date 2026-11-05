import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/glossary/domain/entities/glossary.dart';

part 'glossary_model.freezed.dart';
part 'glossary_model.g.dart';

/// `models.Glossary` in the backend; the fields mobile does not use
/// (`workspace_id`, `is_default`, dates) are left unread.
@freezed
abstract class GlossaryModel with _$GlossaryModel {
  const factory GlossaryModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'term_count') @Default(0) int termCount,
  }) = _GlossaryModel;

  const GlossaryModel._();

  factory GlossaryModel.fromJson(Map<String, dynamic> json) =>
      _$GlossaryModelFromJson(json);

  Glossary toEntity() => Glossary(id: id, name: name, termCount: termCount);
}
