import 'dart:convert';

/// The backend's `models.CleanSegmentText` / `CleanSpeakerLabel` limits,
/// mirrored so the form can refuse before a request. Go's len() counts
/// bytes, so these are bytes, not characters: an Uzbek ʻ is two.
abstract final class EditRules {
  static const int maxSegmentTextBytes = 5000;
  static const int maxSpeakerLabelBytes = 80;

  /// `models.MaxTitleLen`, counted in bytes like Go's `len`.
  static const int maxTitleBytes = 200;

  /// Whitespace collapsed the way the server does it, so "unchanged" and
  /// "too long" are judged on what would actually be stored.
  static String clean(String text) =>
      text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).join(' ');

  static bool segmentTextTooLong(String text) =>
      utf8.encode(clean(text)).length > maxSegmentTextBytes;

  static bool speakerLabelTooLong(String label) =>
      utf8.encode(clean(label)).length > maxSpeakerLabelBytes;

  static bool titleTooLong(String title) =>
      utf8.encode(clean(title)).length > maxTitleBytes;

  /// The web's `serverOffset`: where [cursor] (a UTF-16 index into the
  /// draft, as a text field reports it) falls in the text the server will
  /// store — whitespace collapsed, counted in runes like Go.
  static int serverOffset(String draft, int cursor) {
    final before = draft.substring(0, cursor.clamp(0, draft.length));
    final words = before.split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    final joined = words.join(' ');
    // A cursor in the gap after a word counts that gap too.
    final gap = words.isNotEmpty && RegExp(r'\s$').hasMatch(before) ? 1 : 0;
    return joined.runes.length + gap;
  }

  /// The split point for [draft] at [cursor], or null where the web
  /// would not split: at either edge, where one part would be empty.
  static int? splitAt(String draft, int cursor) {
    final at = serverOffset(draft, cursor);
    if (at <= 0 || at >= clean(draft).runes.length) return null;
    return at;
  }
}
