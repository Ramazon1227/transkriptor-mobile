import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Enough to recognise a voice. A longer line plays this much from its
/// start; a shorter one only to its end, because the next voice may be
/// someone else's.
const Duration speakerSampleLength = Duration(seconds: 8);

final RegExp _defaultLabel = RegExp(
  r"^ma['ʼ’ʻ]?ruzachi \d+$",
  caseSensitive: false,
);

/// One row of «Maʼruzachilarni tanishtiring». [start] is null when the
/// speaker has no line with a length: nothing to play.
class SpeakerIntroRow {
  const SpeakerIntroRow({required this.speaker, this.start, this.end});

  final Speaker speaker;
  final Duration? start;
  final Duration? end;
}

/// The rules of the first-open sheet (E-6). No state and no request: the
/// sheet touches neither the AI nor the transcription service.
abstract final class SpeakerIntro {
  /// Nobody has named this speaker yet: `Ma'ruzachi 1` is what the server
  /// writes today, `Maʼruzachi 1` what it will write.
  static bool isDefaultLabel(String label) =>
      _defaultLabel.hasMatch(label.trim());

  /// Speakers who have text, in first-appearance order, each with a sample
  /// from their longest line.
  static List<SpeakerIntroRow> rows(Transcript transcript) {
    final longest = <String, Segment>{};
    for (final s in transcript.segments) {
      final id = s.speakerId;
      if (id == null) continue;
      final best = longest[id];
      if (best == null || s.end - s.start > best.end - best.start) {
        longest[id] = s;
      }
    }
    return [
      for (final MapEntry(key: id, value: line) in longest.entries)
        for (final speaker in transcript.speakers.where((s) => s.id == id))
          _row(speaker, line),
    ];
  }

  static SpeakerIntroRow _row(Speaker speaker, Segment line) {
    final length = line.end - line.start;
    if (length <= Duration.zero) return SpeakerIntroRow(speaker: speaker);
    return SpeakerIntroRow(
      speaker: speaker,
      start: line.start,
      end: length > speakerSampleLength
          ? line.start + speakerSampleLength
          : line.end,
    );
  }

  /// One speaker leaves nothing to ask; a VIEWER cannot rename.
  static bool applies(Transcript transcript) {
    if (!transcript.role.canWrite) return false;
    final all = rows(transcript);
    return all.length >= 2 && all.any((r) => isDefaultLabel(r.speaker.label));
  }

  /// The «…» row: the sheet again, also when every name is given.
  static bool canReopen(Transcript transcript) =>
      transcript.role.canWrite && rows(transcript).length >= 2;
}
