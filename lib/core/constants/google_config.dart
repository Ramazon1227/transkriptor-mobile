/// Google sign-in settings that live in the app.
///
/// Android needs nothing here: its OAuth client (package + SHA-1) is
/// matched by Google, and the backend's web client id comes from
/// `GET /auth/oauth/providers`.
///
/// iOS needs its own OAuth client (type iOS, bundle id) given at build
/// time —
/// `--dart-define=GOOGLE_IOS_CLIENT_ID=<n>-<x>.apps.googleusercontent.com`
/// — **and** its reversed id as a URL scheme in `ios/Runner/Info.plist`
/// (README, "iPhone'da sinash"). Without the define the Google button is
/// hidden on iOS: the Google SDK raises an uncaught exception (a crash)
/// when the URL scheme is missing.
abstract final class GoogleConfig {
  static const String iosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
  );
}
