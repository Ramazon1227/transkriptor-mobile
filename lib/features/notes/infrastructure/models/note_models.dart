import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';

part 'note_models.freezed.dart';
part 'note_models.g.dart';

/// `models.NoteSummary` in the backend.
@freezed
abstract class NoteSummaryModel with _$NoteSummaryModel {
  const factory NoteSummaryModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'excerpt') @Default('') String excerpt,
    @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)
    @Default(NoteSourceKind.unknown)
    NoteSourceKind sourceKind,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _NoteSummaryModel;

  const NoteSummaryModel._();

  factory NoteSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$NoteSummaryModelFromJson(json);

  NoteSummary toEntity() => NoteSummary(
    id: id,
    title: title,
    excerpt: excerpt,
    sourceKind: sourceKind,
    createdAt: _date(createdAt),
    updatedAt: _date(updatedAt),
  );
}

/// `handler.NoteList`: one page and the cursor for the next.
@freezed
abstract class NoteListModel with _$NoteListModel {
  const factory NoteListModel({
    @JsonKey(name: 'items')
    @Default(<NoteSummaryModel>[])
    List<NoteSummaryModel> items,
    @JsonKey(name: 'next_cursor') String? nextCursor,
  }) = _NoteListModel;

  const NoteListModel._();

  factory NoteListModel.fromJson(Map<String, dynamic> json) =>
      _$NoteListModelFromJson(json);

  NotesPage toEntity() => NotesPage(
    items: items.map((m) => m.toEntity()).toList(),
    nextCursor: (nextCursor?.isEmpty ?? true) ? null : nextCursor,
  );
}

/// `models.NoteSource`.
@freezed
abstract class NoteOriginModel with _$NoteOriginModel {
  const factory NoteOriginModel({
    @JsonKey(name: 'transcript_id') @Default('') String transcriptId,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'available') @Default(false) bool available,
  }) = _NoteOriginModel;

  factory NoteOriginModel.fromJson(Map<String, dynamic> json) =>
      _$NoteOriginModelFromJson(json);
}

/// `models.Note`. `body` is the Tiptap document, kept as raw JSON here and
/// read into blocks by [NoteDocument].
@freezed
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'body') Map<String, dynamic>? body,
    @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)
    @Default(NoteSourceKind.unknown)
    NoteSourceKind sourceKind,
    @JsonKey(name: 'source') NoteOriginModel? source,
    @JsonKey(name: 'revision') @Default(0) int revision,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _NoteModel;

  const NoteModel._();

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Note toEntity() {
    final origin = source;
    return Note(
      id: id,
      title: title,
      blocks: NoteDocument.parse(body),
      sourceKind: sourceKind,
      origin: origin == null || origin.transcriptId.isEmpty
          ? null
          : NoteOrigin(
              transcriptId: origin.transcriptId,
              title: origin.title,
              available: origin.available,
            ),
      revision: revision,
      createdAt: _date(createdAt),
      updatedAt: _date(updatedAt),
    );
  }
}

DateTime? _date(String? raw) => raw == null ? null : DateTime.tryParse(raw);
