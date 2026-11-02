import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/storage_keys.dart';

/// Where the first-open speaker sheet's answers live. Secure storage, not
/// because they are secrets: it is the only persistent store the app has.
@lazySingleton
class SpeakerIntroStorage {
  SpeakerIntroStorage(this._storage);

  final FlutterSecureStorage _storage;

  String _seen(String transcriptId) =>
      '${StorageKeys.speakerIntroSeen}$transcriptId';

  Future<bool> isSeen(String transcriptId) async =>
      await _storage.read(key: _seen(transcriptId)) != null;

  Future<void> markSeen(String transcriptId) =>
      _storage.write(key: _seen(transcriptId), value: '1');

  Future<bool> isOff() async =>
      await _storage.read(key: StorageKeys.speakerIntroOff) != null;

  Future<void> setOff({required bool off}) => off
      ? _storage.write(key: StorageKeys.speakerIntroOff, value: '1')
      : _storage.delete(key: StorageKeys.speakerIntroOff);
}
