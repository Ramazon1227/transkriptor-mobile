abstract final class Routes {
  static const String login = '/login';

  /// Pushed above login, so back returns there.
  static const String register = '/login/register';

  /// Above login too; takes the email typed there as an optional `extra`.
  static const String forgotPassword = '/login/forgot';

  // Tabs of the shell.
  static const String home = '/';
  static const String files = '/files';
  static const String profile = '/profile';

  // Full-screen flows above the shell.
  static const String record = '/record';

  /// Takes a `PendingFile` as `extra`.
  static const String send = '/send';
  static const String link = '/link';
  static const String job = '/job/:id';
  static const String transcript = '/transcript/:id';

  static String jobOf(String id) => '/job/$id';
  static String transcriptOf(String id) => '/transcript/$id';
}
