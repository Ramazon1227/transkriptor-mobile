import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/storage_keys.dart';

/// Where the closed minute warnings live, one key per workspace. Secure
/// storage, not because they are secrets: it is the only persistent store
/// the app has.
@lazySingleton
class QuotaWarningStorage {
  QuotaWarningStorage(this._storage);

  final FlutterSecureStorage _storage;

  String _key(String workspaceId) =>
      '${StorageKeys.quotaWarningClosed}$workspaceId';

  Future<String?> read(String workspaceId) =>
      _storage.read(key: _key(workspaceId));

  Future<void> write(String workspaceId, String period) =>
      _storage.write(key: _key(workspaceId), value: period);

  Future<void> delete(String workspaceId) =>
      _storage.delete(key: _key(workspaceId));
}
