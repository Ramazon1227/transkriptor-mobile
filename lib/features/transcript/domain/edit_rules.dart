import 'dart:convert';

/// The backend's `models.CleanSegmentText` / `CleanSpeakerLabel` limits,
/// mirrored so the form can refuse before a request. Go's len() counts
/// bytes, so these are bytes, not characters: an Uzbek ʻ is two.
abstract final class EditRules {
  static const int maxSegmentTextBytes = 5000;
  static const int maxSpeakerLabelBytes = 80;

  /// Whitespace collapsed the way the server does it, so "unchanged" and
  /// "too long" are judged on what would actually be stored.
  static String clean(String text) =>
      text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).join(' ');

  static bool segmentTextTooLong(String text) =>
      utf8.encode(clean(text)).length > maxSegmentTextBytes;

  static bool speakerLabelTooLong(String label) =>
      utf8.encode(clean(label)).length > maxSpeakerLabelBytes;
}
