import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';

/// The limits of the «Qoʻshimcha sozlamalar» panel — the backend's
/// `models.CleanJobTerms` and `models.CleanSpeakerHints`, so the panel
/// refuses what the server would. Lengths count characters (runes), as Go
/// counts them: a Cyrillic letter is one.
abstract final class AdvancedRules {
  static const int maxTerms = 200;
  static const int maxTermLength = 120;
  static const int maxHints = 100;
  static const int maxHintLabel = 60;
  static const int minHintMs = 1000;
  static const int maxHintMs = 10 * 60 * 1000;
  static const int maxPeople = 10;

  /// The speaker counts the picker offers (null = Auto).
  static const int maxSpeakers = 10;

  static String collapse(String s) =>
      s.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).join(' ');

  /// Free text → terms: one per line, inner spaces collapsed, empty lines
  /// and case-insensitive repeats dropped, the first spelling kept.
  static List<String> parseTerms(String text) {
    final seen = <String>{};
    final out = <String>[];
    for (final line in text.split('\n')) {
      final term = collapse(line);
      if (term.isEmpty || !seen.add(term.toLowerCase())) continue;
      out.add(term);
    }
    return out;
  }

  /// What is wrong with the free text, or null.
  static AdvancedProblem? termsProblem(String text) {
    final terms = parseTerms(text);
    for (final term in terms) {
      if (term.runes.length > maxTermLength) {
        return TermTooLong(String.fromCharCodes(term.runes.take(24)));
      }
    }
    if (terms.length > maxTerms) return TooManyTerms(terms.length);
    return null;
  }

  /// The people of [hints]: names compared case-insensitively, the first
  /// spelling kept, in first-appearance order.
  static List<String> people(List<SpeakerHint> hints) {
    final seen = <String, String>{};
    for (final h in hints) {
      final label = collapse(h.label);
      if (label.isNotEmpty) seen.putIfAbsent(label.toLowerCase(), () => label);
    }
    return seen.values.toList();
  }

  /// What stops [next] from joining [existing], or null. [speakers] is the
  /// chosen speaker count; null is Auto.
  static AdvancedProblem? hintProblem(
    SpeakerHint next,
    List<SpeakerHint> existing,
    int? speakers,
  ) {
    final label = collapse(next.label);
    if (label.isEmpty) return const HintNoName();
    if (label.runes.length > maxHintLabel) return const HintNameTooLong();
    if (next.startMs < 0 || next.endMs <= next.startMs) {
      return const HintEndBeforeStart();
    }
    final length = next.endMs - next.startMs;
    if (length < minHintMs) return const HintTooShort();
    if (length > maxHintMs) return const HintTooLong();
    if (existing.length >= maxHints) return const TooManyHints();
    final key = label.toLowerCase();
    for (final h in existing) {
      final other = collapse(h.label);
      if (other.toLowerCase() != key &&
          next.startMs < h.endMs &&
          h.startMs < next.endMs) {
        return HintOverlap(other);
      }
    }
    final names = people([...existing, next.copyWith(label: label)]);
    if (names.length > maxPeople) return const TooManyPeople();
    if (speakers != null && names.length > speakers) {
      return MorePeopleThanSpeakers(speakers: speakers, people: names.length);
    }
    return null;
  }

  /// [existing] with [next] added: one person's overlapping intervals
  /// merge into one (the server does the same), the name takes the
  /// spelling already used, the list stays sorted by start. Check
  /// [hintProblem] first.
  static List<SpeakerHint> addHint(
    SpeakerHint next,
    List<SpeakerHint> existing,
  ) {
    final label = collapse(next.label);
    final key = label.toLowerCase();
    final spelled = people(existing)
        .firstWhere((n) => n.toLowerCase() == key, orElse: () => label);
    var merged = SpeakerHint(
      label: spelled,
      startMs: next.startMs,
      endMs: next.endMs,
    );
    final kept = <SpeakerHint>[];
    for (final h in existing) {
      final same = collapse(h.label).toLowerCase() == key;
      if (same && h.startMs < merged.endMs && merged.startMs < h.endMs) {
        merged = merged.copyWith(
          startMs: h.startMs < merged.startMs ? h.startMs : merged.startMs,
          endMs: h.endMs > merged.endMs ? h.endMs : merged.endMs,
        );
      } else {
        kept.add(h);
      }
    }
    return sorted([...kept, merged]);
  }

  /// By start, then end — the order the server stores.
  static List<SpeakerHint> sorted(List<SpeakerHint> hints) => [...hints]
    ..sort(
      (a, b) => a.startMs != b.startMs
          ? a.startMs.compareTo(b.startMs)
          : a.endMs.compareTo(b.endMs),
    );

  /// Everything, before «Saqlash»: the speaker count may have been lowered
  /// after hints were marked.
  static AdvancedProblem? saveProblem({
    required String termsText,
    required int? speakers,
    required Iterable<List<SpeakerHint>> hints,
  }) {
    final terms = termsProblem(termsText);
    if (terms != null) return terms;
    if (speakers != null) {
      for (final perFile in hints) {
        final n = people(perFile).length;
        if (n > speakers) {
          return PeopleExceedSpeakers(people: n, speakers: speakers);
        }
      }
    }
    return null;
  }

  /// «0:15», «1:02:03», with a tenth of a second when there is one
  /// («0:15.4»).
  static String formatTime(int ms) {
    final tenths = (ms < 0 ? 0 : ms / 100).round();
    final whole = tenths ~/ 10;
    final tenth = tenths % 10;
    final h = whole ~/ 3600;
    final m = (whole % 3600) ~/ 60;
    final s = whole % 60;
    final ss = s.toString().padLeft(2, '0') + (tenth == 0 ? '' : '.$tenth');
    return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$ss' : '$m:$ss';
  }

  /// «1:05», «0:15.5», «1:02:03», «75» → ms; null when it is not a time.
  static int? parseTime(String text) {
    final parts = text.trim().split(':');
    if (parts.isEmpty || parts.length > 3) return null;
    final number = RegExp(r'^\d+(\.\d+)?$');
    if (parts.any((p) => !number.hasMatch(p))) return null;
    final nums = parts.map(double.parse).toList();
    // Only the last part may have a fraction; the others are whole.
    for (var i = 0; i < nums.length - 1; i++) {
      if (nums[i] != nums[i].truncateToDouble()) return null;
    }
    // Minutes and seconds after the first part stay under 60.
    for (var i = 1; i < nums.length; i++) {
      if (nums[i] >= 60) return null;
    }
    final seconds = nums.fold<double>(0, (acc, n) => acc * 60 + n);
    return (seconds * 1000).round();
  }
}

/// Why the panel refuses something. The page turns it into a sentence.
sealed class AdvancedProblem {
  const AdvancedProblem();
}

/// A term over [AdvancedRules.maxTermLength] characters; [start] is its
/// beginning, to find it.
final class TermTooLong extends AdvancedProblem {
  const TermTooLong(this.start);
  final String start;
}

final class TooManyTerms extends AdvancedProblem {
  const TooManyTerms(this.count);
  final int count;
}

final class HintNoName extends AdvancedProblem {
  const HintNoName();
}

final class HintNameTooLong extends AdvancedProblem {
  const HintNameTooLong();
}

final class HintEndBeforeStart extends AdvancedProblem {
  const HintEndBeforeStart();
}

final class HintTooShort extends AdvancedProblem {
  const HintTooShort();
}

final class HintTooLong extends AdvancedProblem {
  const HintTooLong();
}

final class TooManyHints extends AdvancedProblem {
  const TooManyHints();
}

/// Overlaps the interval of another person, [name].
final class HintOverlap extends AdvancedProblem {
  const HintOverlap(this.name);
  final String name;
}

final class TooManyPeople extends AdvancedProblem {
  const TooManyPeople();
}

/// Adding the hint would name more people than the chosen count.
final class MorePeopleThanSpeakers extends AdvancedProblem {
  const MorePeopleThanSpeakers({required this.speakers, required this.people});
  final int speakers;
  final int people;
}

/// A start or end that is not a time.
final class HintBadTime extends AdvancedProblem {
  const HintBadTime();
}

/// The interval ends after the file does.
final class HintPastEnd extends AdvancedProblem {
  const HintPastEnd();
}

/// On «Saqlash»: a file names more people than the chosen count.
final class PeopleExceedSpeakers extends AdvancedProblem {
  const PeopleExceedSpeakers({required this.people, required this.speakers});
  final int people;
  final int speakers;
}
