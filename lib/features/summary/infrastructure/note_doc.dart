import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';

/// The backend caps a note title at 200 characters (`MaxNoteTitleLen`).
const int noteTitleMaxLength = 200;

/// [sections] as a Tiptap document the note schema accepts: an `h2` per
/// section title, a paragraph, then a bullet list. Only node types from
/// `models.CleanNoteBody` are used.
Map<String, Object?> summaryNoteDoc(List<SummarySection> sections) {
  Map<String, Object?> text(String t) => {'type': 'text', 'text': t};
  Map<String, Object?> paragraph(String t) => {
    'type': 'paragraph',
    if (t.isNotEmpty) 'content': [text(t)],
  };

  final content = <Map<String, Object?>>[];
  for (final s in sections) {
    final title = s.title;
    if (title != null && title.isNotEmpty) {
      content.add({
        'type': 'heading',
        'attrs': {'level': 2},
        'content': [text(title)],
      });
    }
    final p = s.paragraph;
    if (p != null && p.isNotEmpty) content.add(paragraph(p));
    final bullets = s.bullets.where((b) => b.isNotEmpty).toList();
    if (bullets.isNotEmpty) {
      content.add({
        'type': 'bulletList',
        'content': [
          for (final b in bullets)
            {
              'type': 'listItem',
              'content': [paragraph(b)],
            },
        ],
      });
    }
  }
  if (content.isEmpty) content.add(paragraph(''));
  return {'type': 'doc', 'content': content};
}

/// Cut to the server's limit on a character boundary.
String clampNoteTitle(String title) {
  final runes = title.trim().runes.toList();
  if (runes.length <= noteTitleMaxLength) return title.trim();
  return '${String.fromCharCodes(runes.take(noteTitleMaxLength - 1))}…';
}
