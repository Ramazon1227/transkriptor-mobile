import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary_template.freezed.dart';

/// System templates are managed from the admin console; user templates
/// («Mening shablonlarim») belong to one person.
enum SummaryTemplateOwner { system, user, unknown }

@freezed
abstract class SummaryTemplate with _$SummaryTemplate {
  const factory SummaryTemplate({
    required String id,
    required String name,
    @Default(SummaryTemplateOwner.unknown) SummaryTemplateOwner owner,
    String? categoryId,

    /// Free-text instructions for the model.
    @Default('') String prompt,
    @Default(0) int position,

    /// Starred by the caller (per user).
    @Default(false) bool favorite,
  }) = _SummaryTemplate;
}

@freezed
abstract class SummaryTemplateCategory with _$SummaryTemplateCategory {
  const factory SummaryTemplateCategory({
    required String id,
    required String name,
    @Default(0) int position,
  }) = _SummaryTemplateCategory;
}

/// `GET /summary-templates`: what the caller may see, already filtered on
/// the server (drafts and other people's templates never arrive).
@freezed
abstract class SummaryTemplateLibrary with _$SummaryTemplateLibrary {
  const factory SummaryTemplateLibrary({
    @Default(<SummaryTemplateCategory>[])
    List<SummaryTemplateCategory> categories,
    @Default(<SummaryTemplate>[]) List<SummaryTemplate> templates,
  }) = _SummaryTemplateLibrary;

  const SummaryTemplateLibrary._();

  List<SummaryTemplate> get favorites =>
      templates.where((t) => t.favorite).toList();

  List<SummaryTemplate> get mine => templates
      .where((t) => t.owner == SummaryTemplateOwner.user)
      .toList();

  List<SummaryTemplate> inCategory(String categoryId) => templates
      .where(
        (t) =>
            t.owner == SummaryTemplateOwner.system &&
            t.categoryId == categoryId,
      )
      .toList();

  /// The template a new summary starts with: the first starred one, else
  /// the first system template in category order. Null when there is
  /// none (the server's default is used).
  SummaryTemplate? get preferred {
    final fav = favorites;
    if (fav.isNotEmpty) return fav.first;
    for (final c in categories) {
      final items = inCategory(c.id);
      if (items.isNotEmpty) return items.first;
    }
    return null;
  }

  SummaryTemplateLibrary withFavorite(String id, {required bool favorite}) =>
      copyWith(
        templates: [
          for (final t in templates)
            if (t.id == id) t.copyWith(favorite: favorite) else t,
        ],
      );
}
