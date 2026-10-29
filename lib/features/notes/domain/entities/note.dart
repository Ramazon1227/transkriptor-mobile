import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';

part 'note.freezed.dart';

/// How a note was made: blank, or as a copy of a transcript.
enum NoteSourceKind {
  @JsonValue('BLANK')
  blank,
  @JsonValue('TRANSCRIPT')
  transcript,
  unknown,
}

/// One row of the notes list: an excerpt instead of the body.
@freezed
abstract class NoteSummary with _$NoteSummary {
  const factory NoteSummary({
    required String id,

    /// May be empty: the list then shows the excerpt.
    @Default('') String title,
    @Default('') String excerpt,
    @Default(NoteSourceKind.unknown) NoteSourceKind sourceKind,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoteSummary;
}

/// One page of the notes list; [nextCursor] null means it was the last.
@freezed
abstract class NotesPage with _$NotesPage {
  const factory NotesPage({
    @Default(<NoteSummary>[]) List<NoteSummary> items,
    String? nextCursor,
  }) = _NotesPage;
}

/// The transcript a note was copied from. The note is a copy, so it
/// outlives the file: [available] false means the transcript is gone.
@freezed
abstract class NoteOrigin with _$NoteOrigin {
  const factory NoteOrigin({
    required String transcriptId,
    @Default('') String title,
    @Default(false) bool available,
  }) = _NoteOrigin;
}

/// A whole note, its body already read into [blocks].
@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    @Default('') String title,
    @Default(<NoteBlock>[]) List<NoteBlock> blocks,
    @Default(NoteSourceKind.unknown) NoteSourceKind sourceKind,
    NoteOrigin? origin,

    /// Sent back with every change; a stale one is refused with 409.
    @Default(0) int revision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Note;
}
