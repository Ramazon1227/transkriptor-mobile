import 'dart:convert';

enum PasswordProblem { tooShort, tooLong, needsLetterAndOther }

/// The backend's `models.ValidatePassword`, mirrored so the form can say
/// what is wrong before a request: at least 10 characters, at most 72
/// bytes (bcrypt ignores the rest, so longer is refused, not truncated),
/// a letter and at least one non-letter.
abstract final class PasswordRules {
  static const int minLength = 10;
  static const int maxBytes = 72;

  /// Null when the password is acceptable.
  static PasswordProblem? check(String password) {
    // Go's len() counts bytes; the minimum is in bytes there too.
    final bytes = utf8.encode(password).length;
    if (bytes < minLength) return PasswordProblem.tooShort;
    if (bytes > maxBytes) return PasswordProblem.tooLong;
    var hasLetter = false;
    var hasOther = false;
    for (final rune in password.runes) {
      if (_isLetter(rune)) {
        hasLetter = true;
      } else {
        hasOther = true;
      }
    }
    return hasLetter && hasOther ? null : PasswordProblem.needsLetterAndOther;
  }

  /// Letters in any script: a code point that has distinct upper and
  /// lower case is one. Uzbek Latin and Cyrillic are covered; caseless
  /// scripts count as non-letters, which only makes the rule stricter.
  static bool _isLetter(int rune) {
    final s = String.fromCharCode(rune);
    return s.toUpperCase() != s.toLowerCase();
  }
}
