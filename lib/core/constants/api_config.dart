/// Network settings. The base URL is chosen at build time:
/// `flutter run --dart-define=API_BASE_URL=https://api.example.uz`.
abstract final class ApiConfig {
  /// Host only, without a path. Endpoint paths in `Endpoints` carry their
  /// own prefix (`/api/v1/...`), so one Dio serves every route.
  ///
  /// No default on purpose: a build that forgot the define must not send
  /// passwords to some other host. `main` refuses to start without it.
  /// Local Docker API from the Android emulator: `http://10.0.2.2:8080`.
  static const String baseUrl = String.fromEnvironment('API_BASE_URL');

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// One upload PUT carries a whole recording.
  static const Duration uploadSendTimeout = Duration(minutes: 30);

  /// Job polling: first interval, then doubled up to the max.
  static const Duration jobPollInterval = Duration(seconds: 3);
  static const Duration jobPollMaxInterval = Duration(seconds: 15);

  /// Upper bound for one token refresh, so requests waiting on it never
  /// hang.
  static const Duration refreshTimeout = Duration(seconds: 15);
}
