import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/billing/domain/i_quota_warning_facade.dart';
import 'package:transkriptor_uz/features/billing/infrastructure/storage/quota_warning_storage.dart';

@LazySingleton(as: IQuotaWarningFacade)
class QuotaWarningFacade implements IQuotaWarningFacade {
  QuotaWarningFacade(this._storage);

  final QuotaWarningStorage _storage;

  @override
  Future<String?> closedPeriod(String workspaceId) async {
    try {
      return await _storage.read(workspaceId);
    } on Object {
      // An unreadable keychain only means the warning shows once more.
      return null;
    }
  }

  @override
  Future<void> close(String workspaceId, String period) async {
    try {
      await _storage.write(workspaceId, period);
    } on Object {
      // Closed for this visit all the same.
    }
  }

  @override
  Future<void> forget(String workspaceId) async {
    try {
      await _storage.delete(workspaceId);
    } on Object {
      // The worst case is one warning fewer after a top-up.
    }
  }
}
