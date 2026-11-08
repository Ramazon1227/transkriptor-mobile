import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';

/// How much of the plan's minutes is used (B-18). [low]: 80 % or more,
/// [critical]: 95 % or more.
enum QuotaLevel {
  none(0),
  low(80),
  critical(95);

  QuotaLevel(this.percent);

  final int percent;
}

/// The same rule as the web's `lib/quota.ts`; both run
/// `test/fixtures/quota_cases.json` (a copy of the web's
/// `quota.fixtures.json` — copy it again, do not edit it by hand).
abstract final class Quota {
  /// The share comes from the plan's minutes (`plan.monthly_seconds`; on
  /// the free plan the one-off 30 minutes). Minutes bought above the plan
  /// give no share, and a plan without minutes never warns. Integer
  /// arithmetic, so rounding cannot move a threshold.
  /// The plan's minutes, the share's denominator. The server answers the
  /// free plan for every workspace without a subscription, but the free
  /// minutes go only to a personal one (migration 010): an unsubscribed
  /// team workspace has no denominator.
  static int allowance(
    int monthly, {
    required bool subscribed,
    required bool personal,
  }) => subscribed || personal ? monthly : 0;

  static QuotaLevel level(int left, int allowance) {
    if (allowance <= 0) return QuotaLevel.none;
    if (left * 20 <= allowance) return QuotaLevel.critical;
    if (left * 5 <= allowance) return QuotaLevel.low;
    return QuotaLevel.none;
  }

  /// A dismissed warning stays closed for this period. The free minutes
  /// have no period: one key, «once».
  static String period(Balance b) =>
      b.periodEnd?.toUtc().toIso8601String() ?? 'once';
}
