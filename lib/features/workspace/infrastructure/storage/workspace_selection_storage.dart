import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/storage_keys.dart';

/// Where the chosen workspace id lives between starts. Secure storage,
/// like the tokens: it is the only persistent store the app has.
@lazySingleton
class WorkspaceSelectionStorage {
  WorkspaceSelectionStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: StorageKeys.selectedWorkspace);

  Future<void> write(String id) =>
      _storage.write(key: StorageKeys.selectedWorkspace, value: id);

  Future<void> clear() => _storage.delete(key: StorageKeys.selectedWorkspace);
}
