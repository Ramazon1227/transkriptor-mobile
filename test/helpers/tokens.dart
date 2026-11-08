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

  void signIn(String? userId) =>
      _access = userId == null ? null : tokenFor(userId);

  @override
  Future<String?> readAccessToken() async => _access;

  @override
  Future<String?> readRefreshToken() async => _access;

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async => _access = accessToken;

  @override
  Future<void> clear() async => _access = null;
}
