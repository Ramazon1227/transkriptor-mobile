/// Pages of the public web app that the mobile app points people to.
///
/// The host is given at build time like `API_BASE_URL`:
/// `--dart-define=PUBLIC_APP_URL=https://app.example.uz`. Without it the
/// links are not offered (the rows say «Tez orada»), so a build never
/// sends people to a guessed host.
abstract final class PublicLinks {
  static const String baseUrl = String.fromEnvironment('PUBLIC_APP_URL');

  /// `tr-frontend/src/app/(site)/xavfsizlik` — where files are kept, how
  /// long, deletion, sign-in. The closest thing to a privacy policy that
  /// exists today.
  static const String _privacyPath = '/xavfsizlik';

  /// Null while [baseUrl] is not set.
  static String? get privacy => _join(_privacyPath);

  // No help centre, terms of service or bug-report page exists on the web
  // yet (checked 2026-10-29). Add the path here when one does.
  static String? get help => null;
  static String? get terms => null;
  static String? get bugReport => null;

  static String? _join(String path) {
    if (baseUrl.isEmpty) return null;
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return '$base$path';
  }
}
