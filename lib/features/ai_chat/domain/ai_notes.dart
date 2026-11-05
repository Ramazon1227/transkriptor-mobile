/// The notes the server appends to an answer (backend `models/ai.go`): the
/// recording did not fit the model, or the answer hit its length limit.
/// They are not the answer's text and are shown apart from it (CH-11).
///
/// A port of `tr-frontend/src/lib/ai-notes.ts` (and the backend's
/// `models.StripAINotes`); both pass the same cases
/// (`test/fixtures/ai_notes_cases.json` is a copy of the web's
/// `ai-notes.fixtures.json` — copy it again, do not edit it by hand).
library;

const truncatedNote =
    '(Javob uzunlik chegarasida qisqartirildi — savolni aniqroq bering.)';
const _cutPrefix = '(AI yozuvning faqat boshidan ';
const _cutTail =
    " gacha qismini ko'rdi — undan keyingi qism javobga kirmagan.)";

String _trimEnd(String s) => s.replaceFirst(RegExp(r'[ \n]+$'), '');

/// The answer without the server's notes, and the notes in order.
({String body, List<String> notes}) splitAiNotes(String content) {
  var s = _trimEnd(content);
  final notes = <String>[];
  final i = s.lastIndexOf(_cutPrefix);
  if (i >= 0 && s.endsWith(_cutTail) && !s.substring(i).contains('\n')) {
    notes.insert(0, s.substring(i));
    s = _trimEnd(s.substring(0, i));
  }
  if (s.endsWith(truncatedNote)) {
    notes.insert(0, truncatedNote);
    s = _trimEnd(s.substring(0, s.length - truncatedNote.length));
  }
  return (body: s, notes: notes);
}
