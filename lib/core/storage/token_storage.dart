import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/storage_keys.dart';

/// Where the access and refresh tokens live. Never log what it returns.
abstract interface class TokenStorage {
  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<void> save({
    required String accessToken,
    required String refreshToken,
  });

  Future<void> clear();
}

/// Keychain on iOS, Keystore-backed storage on Android.
@LazySingleton(as: TokenStorage)
class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readAccessToken() =>
      _storage.read(key: StorageKeys.accessToken);

  @override
  Future<String?> readRefreshToken() =>
      _storage.read(key: StorageKeys.refreshToken);

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: StorageKeys.accessToken, value: accessToken);
    await _storage.write(key: StorageKeys.refreshToken, value: refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }
}

/// The account id (`sub`) inside one of our JWTs, or null. Read without
/// checking the signature: it only labels files on this phone and grants
/// nothing.
String? tokenSubject(String? token) {
  final parts = token?.split('.');
  if (parts == null || parts.length != 3) return null;
  try {
    final claims = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
    );
    final sub = claims is Map ? claims['sub'] : null;
    return sub is String && sub.isNotEmpty ? sub : null;
  } on FormatException {
    return null;
  }
}
