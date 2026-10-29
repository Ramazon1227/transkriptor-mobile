import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing.freezed.dart';

/// A plan from `GET /plans`. Prices are in so'm.
@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    required String code,
    required String name,

    /// Minutes granted per month, in seconds.
    @Default(0) int monthlySeconds,

    /// `num`: a so'm price can outgrow an int on no platform today, but
    /// money stays out of int by rule.
    @Default(0) num priceUzs,
    @Default(0) int maxMembers,
  }) = _Plan;

  const Plan._();

  bool get isFree => priceUzs <= 0;
}

/// Where a paid subscription stands. [none]: no subscription, the
/// workspace is on the free plan.
enum SubscriptionStatus {
  none,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('PAST_DUE')
  pastDue,
  @JsonValue('CANCELLED')
  cancelled,
  @JsonValue('EXPIRED')
  expired,
  unknown,
}

/// `GET /workspaces/:id/balance`.
@freezed
abstract class Balance with _$Balance {
  const factory Balance({
    @Default(0) int balanceSeconds,
    Plan? plan,
    @Default(SubscriptionStatus.none) SubscriptionStatus status,
    DateTime? periodEnd,

    /// The subscription ends at [periodEnd] instead of renewing.
    @Default(false) bool cancelAtPeriodEnd,
  }) = _Balance;
}
