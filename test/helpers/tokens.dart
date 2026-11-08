import 'dart:convert';

import 'package:transkriptor_uz/core/storage/token_storage.dart';

/// An access token whose payload names [userId], as the backend's does.
String tokenFor(String userId) {
  String part(Map<String, Object> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'HS256'})}.${part({'sub': userId})}.sig';
}

/// Token storage holding the tokens of whoever [signIn] names.
class FakeTokenStorage implements TokenStorage {
  FakeTokenStorage([String? userId]) {
    signIn(userId);
  }

  String? _access;
  String? _refresh;

  /// Reads throw, as the Android Keystore can after a backup restore or
  /// the iOS keychain while the phone is locked.
  bool broken = false;

  void signIn(String? userId) {
    _access = userId == null ? null : tokenFor(userId);
    _refresh = userId == null ? null : 'refresh-$userId';
  }

  @override
  Future<String?> readAccessToken() async {
    if (broken) throw Exception('keystore');
    return _access;
  }

  @override
  Future<String?> readRefreshToken() async {
    if (broken) throw Exception('keystore');
    return _refresh;
  }

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    _access = accessToken;
    _refresh = refreshToken;
  }

  @override
  Future<void> clear() async {
    _access = null;
    _refresh = null;
  }
}
