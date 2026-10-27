/// A shape check only; the server has the final word
/// (`models.NormalizeEmail`). Shared by register and password reset.
abstract final class EmailRules {
  static bool looksLikeEmail(String s) {
    final at = s.indexOf('@');
    return at > 0 && at == s.lastIndexOf('@') && s.indexOf('.', at) > at + 1;
  }
}
