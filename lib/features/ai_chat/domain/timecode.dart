/// A piece of an assistant answer: plain text, or a `[mm:ss]` /
/// `[h:mm:ss]` reference the model was told to write.
sealed class AnswerPart {
  const AnswerPart();
}

class AnswerPlain extends AnswerPart {
  const AnswerPlain(this.text);
  final String text;
}

class AnswerTimecode extends AnswerPart {
  const AnswerTimecode(this.label, this.at);

  /// As written, without the brackets: `12:34`.
  final String label;
  final Duration at;
}

/// Same pattern as the web chat (`ai-chat.tsx`) and the backend prompt.
final RegExp _timecode = RegExp(r'\[(?:(\d{1,2}):)?(\d{1,2}):(\d{2})\]');

/// Splits [text] into text and timecode parts, in order. Seconds above 59
/// are not a timecode and stay text.
List<AnswerPart> splitTimecodes(String text) {
  final parts = <AnswerPart>[];
  var last = 0;
  for (final m in _timecode.allMatches(text)) {
    final h = int.parse(m.group(1) ?? '0');
    final min = int.parse(m.group(2)!);
    final s = int.parse(m.group(3)!);
    if (s > 59 || (m.group(1) != null && min > 59)) continue;
    if (m.start > last) parts.add(AnswerPlain(text.substring(last, m.start)));
    final label = m.group(0)!.substring(1, m.group(0)!.length - 1);
    parts.add(
      AnswerTimecode(label, Duration(hours: h, minutes: min, seconds: s)),
    );
    last = m.end;
  }
  if (last < text.length) parts.add(AnswerPlain(text.substring(last)));
  return parts;
}
