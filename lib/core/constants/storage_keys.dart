/// Keys for persisted values. Mock-only keys start with `mock_`.
abstract final class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  /// The workspace the person last switched to. Falls back to the
  /// personal one when the id is no longer theirs.
  static const String selectedWorkspace = 'selected_workspace';
}
