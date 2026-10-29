abstract final class Routes {
  static const String login = '/login';

  /// Pushed above login, so back returns there.
  static const String register = '/login/register';

  /// Above login too; takes the email typed there as an optional `extra`.
  static const String forgotPassword = '/login/forgot';

  // Tabs of the shell: Studio and Files. The «+» between them opens the
  // source sheet, it is not a tab.
  static const String home = '/';
  static const String files = '/files';

  // Settings, full screen above the shell, and its sub-pages.
  static const String settings = '/settings';
  static const String settingsProfile = '/settings/profile';
  static const String plans = '/settings/plans';

  // Full-screen flows above the shell.
  static const String record = '/record';

  /// Takes a `PendingFile` as `extra`.
  static const String send = '/send';

  /// YouTube, Google Drive and Dropbox links.
  static const String link = '/link';
  static const String job = '/job/:id';
  static const String transcript = '/transcript/:id';

  // Capture sources that are placeholders today; each is replaced by its
  // real page in a later phase.
  static const String dictation = '/dictation';
  static const String screenRecord = '/screen-record';
  static const String meeting = '/meeting';
  static const String url = '/url';

  static String jobOf(String id) => '/job/$id';
  static String transcriptOf(String id) => '/transcript/$id';
}
