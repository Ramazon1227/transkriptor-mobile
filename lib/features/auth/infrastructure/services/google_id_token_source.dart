import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/google_config.dart';
import 'package:transkriptor_uz/core/utils/device_platform.dart';

/// The Google Sign-In SDK behind one call: the account picker, then the
/// ID token the backend verifies. `serverClientId` is the backend's web
/// client id (from `GET /auth/oauth/providers`), which makes it the
/// token's `aud`. The Android OAuth client (package + SHA-1) lives in the
/// same Google Cloud project; nothing about it is in the app. iOS also
/// needs the app's own iOS client id ([GoogleConfig.iosClientId]).
@lazySingleton
class GoogleIdTokenSource {
  GoogleIdTokenSource(this._google, this._platform)
    : _iosClientId = GoogleConfig.iosClientId;

  @visibleForTesting
  GoogleIdTokenSource.withIosClientId(
    this._google,
    this._platform,
    this._iosClientId,
  );

  final GoogleSignIn _google;
  final DevicePlatform _platform;
  final String _iosClientId;

  /// False on iOS without an iOS client id: the SDK would crash on the
  /// missing URL scheme, so the button is not offered at all.
  bool get isAvailable => !_platform.isIOS || _iosClientId.isNotEmpty;

  /// The SDK may be initialised once per process.
  String? _initialisedFor;

  /// The ID token, or null when the person closed the picker. Any other
  /// SDK error is thrown.
  Future<String?> idToken(String serverClientId) async {
    if (_initialisedFor == null) {
      await _google.initialize(
        clientId: _platform.isIOS ? _iosClientId : null,
        serverClientId: serverClientId,
      );
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
