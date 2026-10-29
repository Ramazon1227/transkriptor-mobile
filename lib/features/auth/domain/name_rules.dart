import 'dart:convert';

enum NameError { empty, tooLong }

/// `models.CleanName` in the backend: runs of whitespace become one
/// space, and at most [maxBytes] bytes of UTF-8 are kept. The server cuts
/// a longer name (mid-character, even); the app refuses it instead, so
/// what is saved is what was typed. An empty name is ignored by
/// `PATCH /me`, so it is refused here too.
abstract final class NameRules {
  static const int maxBytes = 120;

  static String clean(String raw) =>
      raw.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).join(' ');

  /// Null when [cleaned] (already [clean]ed) can be sent.
  static NameError? validate(String cleaned) {
    if (cleaned.isEmpty) return NameError.empty;
    if (utf8.encode(cleaned).length > maxBytes) return NameError.tooLong;
    return null;
  }
}
