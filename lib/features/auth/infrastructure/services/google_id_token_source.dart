import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

/// The Google Sign-In SDK behind one call: the account picker, then the
/// ID token the backend verifies. `serverClientId` is the backend's web
/// client id (from `GET /auth/oauth/providers`), which makes it the
/// token's `aud`. The Android OAuth client (package + SHA-1) lives in the
/// same Google Cloud project; nothing about it is in the app.
@lazySingleton
class GoogleIdTokenSource {
  GoogleIdTokenSource(this._google);

  final GoogleSignIn _google;

  /// The SDK may be initialised once per process.
  String? _initialisedFor;

  /// The ID token, or null when the person closed the picker. Any other
  /// SDK error is thrown.
  Future<String?> idToken(String serverClientId) async {
    if (_initialisedFor == null) {
      await _google.initialize(serverClientId: serverClientId);
      _initialisedFor = serverClientId;
    }
    try {
      final account = await _google.authenticate();
      return account.authentication.idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  /// So the next sign-in shows the account picker again. Best effort.
  Future<void> signOut() async {
    if (_initialisedFor == null) return;
    try {
      await _google.signOut();
    } on Object {
      // Our own session is already gone; this only affects the picker.
    }
  }
}
