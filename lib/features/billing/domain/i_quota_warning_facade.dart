/// What this phone remembers about the minute warning (B-18). Nothing here
/// fails: an unreadable store only means the warning shows once more.
abstract interface class IQuotaWarningFacade {
  /// The period whose warning was closed in [workspaceId], if any.
  Future<String?> closedPeriod(String workspaceId);

  Future<void> close(String workspaceId, String period);

  /// The balance went back above the warning (a top-up): the next drop
  /// warns again.
  Future<void> forget(String workspaceId);
}
