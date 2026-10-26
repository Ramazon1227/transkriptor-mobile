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
