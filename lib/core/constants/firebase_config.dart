import 'package:firebase_core/firebase_core.dart';

/// Firebase settings, given at build time like API_BASE_URL:
///
///   --dart-define=FIREBASE_API_KEY=... --dart-define=FIREBASE_APP_ID=...
///   --dart-define=FIREBASE_SENDER_ID=... --dart-define=FIREBASE_PROJECT_ID=...
///
/// They come from the Firebase console (Android app settings). Without all
/// four, push is off and Firebase is never touched — no
/// google-services.json, no Gradle plugin.
abstract final class FirebaseConfig {
  static const String _apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String _appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const String _senderId = String.fromEnvironment('FIREBASE_SENDER_ID');
  static const String _projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
  );

  /// Null while any of the four is missing.
  static FirebaseOptions? get options {
    if ([_apiKey, _appId, _senderId, _projectId].any((v) => v.isEmpty)) {
      return null;
    }
    return const FirebaseOptions(
      apiKey: _apiKey,
      appId: _appId,
      messagingSenderId: _senderId,
      projectId: _projectId,
    );
  }
}
