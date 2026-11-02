import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/storage_keys.dart';

/// Where the chosen playback speed lives between starts. Secure storage, not
/// because it is a secret: it is the only persistent store the app has.
@lazySingleton
class PlayerSpeedStorage {
  PlayerSpeedStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: StorageKeys.playbackSpeed);

  Future<void> write(String speed) =>
      _storage.write(key: StorageKeys.playbackSpeed, value: speed);
}
