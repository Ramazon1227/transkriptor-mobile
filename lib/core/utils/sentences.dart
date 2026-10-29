/// Splits transcript text into sentences on `.`, `!`, `?` and `…`
/// followed by a space. Good enough for the demo summary and learn
/// sources; not a linguistic tokenizer.
List<String> splitSentences(String text) {
  final out = <String>[];
  final normalized = text.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (normalized.isEmpty) return out;
  final pattern = RegExp(r'[^.!?…]+(?:[.!?…]+|$)');
  for (final m in pattern.allMatches(normalized)) {
    final s = m.group(0)!.trim();
    if (s.isNotEmpty) out.add(s);
  }
  return out;
}

/// Words of [sentence] without the punctuation around them. Apostrophes
/// (U+02BB, U+02BC, `'`) stay: they are letters in Uzbek.
List<String> sentenceWords(String sentence) => [
  for (final raw in sentence.split(' '))
    if (_strip(raw).isNotEmpty) _strip(raw),
];

final RegExp _edges = RegExp(
  r"^[^\p{L}\p{N}ʻʼ']+|[^\p{L}\p{N}ʻʼ']+$",
  unicode: true,
);

String _strip(String word) => word.replaceAll(_edges, '');
