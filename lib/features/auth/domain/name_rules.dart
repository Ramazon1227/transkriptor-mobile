enum NameError { empty, tooLong }

/// `models.CleanName` in the backend: runs of whitespace become one
/// space, and at most [maxChars] characters are kept. The server cuts a
/// longer name; the app refuses it instead, so what is saved is what was
/// typed. An empty name is ignored by
/// `PATCH /me`, so it is refused here too.
abstract final class NameRules {
  static const int maxChars = 120;

  static String clean(String raw) =>
      raw.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).join(' ');

  /// Null when [cleaned] (already [clean]ed) can be sent.
  static NameError? validate(String cleaned) {
    if (cleaned.isEmpty) return NameError.empty;
    if (cleaned.runes.length > maxChars) return NameError.tooLong;
    return null;
  }
}
