/// Pages of the public web app that the mobile app points people to.
///
/// The host can be given at build time like `API_BASE_URL`:
/// `--dart-define=PUBLIC_APP_URL=https://app.example.uz`. An empty value
/// (`--dart-define=PUBLIC_APP_URL=`) turns the links off — the rows then
/// say «Tez orada».
abstract final class PublicLinks {
  /// Default: the production web app on the **temporary** server (no real
  /// domain yet, an sslip.io name for its IP). It moves with the domain —
  /// root `KOCHISH.md` is the move plan; change it here then, or pass the
  /// new host with the dart-define.
  static const String baseUrl = String.fromEnvironment(
    'PUBLIC_APP_URL',
    defaultValue: 'https://app.108-181-196-187.sslip.io',
  );

  /// `tr-frontend/src/app/(site)/xavfsizlik` — where files are kept, how
  /// long, deletion, sign-in. The closest thing to a privacy policy that
  /// exists today.
  static const String _privacyPath = '/xavfsizlik';

  /// Null while [baseUrl] is not set.
  static String? get privacy => _join(_privacyPath);

  // No help centre, terms of service or bug-report page exists on the web
  // yet (checked 2026-10-29: `(site)` has the landing, `narxlar`,
  // `xavfsizlik`, `audio-matnga`, `youtube-matnga`, `subtitr`). Add the
  // path here when one does. `narxlar` is not linked: the app's own plans
  // screen shows the same list from `GET /plans`, and buying is not
  // possible on the web either.
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
