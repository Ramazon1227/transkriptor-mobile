import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/storage_keys.dart';

/// Where the chosen playback speed and volume live between starts. Secure
/// storage, not because they are secrets: it is the only persistent store
/// the app has.
@lazySingleton
class PlayerSpeedStorage {
  PlayerSpeedStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: StorageKeys.playbackSpeed);

  Future<void> write(String speed) =>
      _storage.write(key: StorageKeys.playbackSpeed, value: speed);

  Future<String?> readVolume() =>
      _storage.read(key: StorageKeys.playbackVolume);

  Future<String?> readMuted() => _storage.read(key: StorageKeys.playbackMuted);

  Future<void> writeVolume(String volume, {required bool muted}) async {
    await _storage.write(key: StorageKeys.playbackVolume, value: volume);
    await _storage.write(
      key: StorageKeys.playbackMuted,
      value: muted ? '1' : '0',
    );
  }
}
