/// A piece of an assistant answer: plain text, or a `[mm:ss]` /
/// `[h:mm:ss]` reference the server put there (CH-1: the model cites line
/// ids, the backend turns them into times and drops unknown ones).
sealed class AnswerPart {
  const AnswerPart();
}

class AnswerPlain extends AnswerPart {
  const AnswerPlain(this.text);
  final String text;
}

class AnswerTimecode extends AnswerPart {
  const AnswerTimecode(this.label, this.at);

  /// As written, without the brackets: `12:34` or a range `12:34–13:10`.
  final String label;

  /// Where the player goes — the start of a range.
  final Duration at;
}

/// Same rule as the web (`tr-frontend/src/lib/timecode.ts`): a bracket of
/// times, a list `[12:34, 15:02]` (each is its own link) or a range
/// `[12:34–13:10]`. A bare `14:00` is not a link; seconds above 59 are not
/// a time. Cases shared with the web: test/fixtures/timecode_cases.json.
final RegExp _bracket = RegExp(r'\[([^\[\]\n]{1,120})\]');
final RegExp _clock = RegExp(r'^(\d{1,2}):([0-5]\d)(?::([0-5]\d))?$');
final RegExp _range = RegExp(
  r'^(\d{1,2}:[0-5]\d(?::[0-5]\d)?)\s*[–—-]\s*(\d{1,2}:[0-5]\d(?::[0-5]\d)?)$',
);

Duration? _clockAt(String s) {
  final m = _clock.firstMatch(s);
  if (m == null) return null;
  final a = int.parse(m.group(1)!);
  final b = int.parse(m.group(2)!);
  final c = m.group(3);
  return c == null
      ? Duration(minutes: a, seconds: b)
      : Duration(hours: a, minutes: b, seconds: int.parse(c));
}

/// The links in one bracket, or null when it is not a time citation.
List<AnswerTimecode>? _refs(String inner) {
  final items = inner.split(RegExp('[,;]')).map((s) => s.trim()).toList();
  if (items.any((s) => s.isEmpty)) return null;
  final out = <AnswerTimecode>[];
  for (final item in items) {
    final range = _range.firstMatch(item);
    final at = _clockAt(range?.group(1) ?? item);
    if (at == null) return null;
    out.add(AnswerTimecode(item, at));
  }
  return out;
}

/// Splits [text] into text and timecode parts, in order. A list becomes
/// several timecodes with a space between them.
List<AnswerPart> splitTimecodes(String text) {
  final parts = <AnswerPart>[];
  var last = 0;
  for (final m in _bracket.allMatches(text)) {
    final refs = _refs(m.group(1)!);
    if (refs == null) continue;
    if (m.start > last) parts.add(AnswerPlain(text.substring(last, m.start)));
    for (var i = 0; i < refs.length; i++) {
      if (i > 0) parts.add(const AnswerPlain(' '));
      parts.add(refs[i]);
    }
    last = m.end;
  }
  if (last < text.length) parts.add(AnswerPlain(text.substring(last)));
  return parts;
}
