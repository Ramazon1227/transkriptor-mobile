import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';

part 'billing_models.freezed.dart';
part 'billing_models.g.dart';

/// `models.Plan` in the backend.
@freezed
abstract class PlanModel with _$PlanModel {
  const factory PlanModel({
    @JsonKey(name: 'code') @Default('') String code,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'monthly_seconds') @Default(0) int monthlySeconds,
    @JsonKey(name: 'price_uzs') @Default(0) num priceUzs,
    @JsonKey(name: 'max_members') @Default(0) int maxMembers,
  }) = _PlanModel;

  const PlanModel._();

  factory PlanModel.fromJson(Map<String, dynamic> json) =>
      _$PlanModelFromJson(json);

  Plan toEntity() => Plan(
    code: code,
    name: name,
    monthlySeconds: monthlySeconds,
    priceUzs: priceUzs,
    maxMembers: maxMembers,
  );
}

/// `data` of `GET /api/v1/plans`.
@freezed
abstract class PlanListModel with _$PlanListModel {
  const factory PlanListModel({
    @JsonKey(name: 'items') @Default(<PlanModel>[]) List<PlanModel> items,
  }) = _PlanListModel;

  factory PlanListModel.fromJson(Map<String, dynamic> json) =>
      _$PlanListModelFromJson(json);
}

/// `models.Balance` in the backend. `status` is omitted when there is no
/// subscription, hence the `none` default.
@freezed
abstract class BalanceModel with _$BalanceModel {
  const factory BalanceModel({
    @JsonKey(name: 'balance_seconds') @Default(0) int balanceSeconds,
    @JsonKey(name: 'plan') PlanModel? plan,
    @JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown)
    @Default(SubscriptionStatus.none)
    SubscriptionStatus status,
    @JsonKey(name: 'period_end') DateTime? periodEnd,
    @JsonKey(name: 'cancel_at_period_end')
    @Default(false)
    bool cancelAtPeriodEnd,
  }) = _BalanceModel;

  const BalanceModel._();

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);

  Balance toEntity() => Balance(
    balanceSeconds: balanceSeconds,
    plan: plan?.toEntity(),
    status: status,
    periodEnd: periodEnd?.toLocal(),
    cancelAtPeriodEnd: cancelAtPeriodEnd,
  );
}

/// `data` of `GET /api/v1/workspaces/:id/balance`.
@freezed
abstract class BalanceResponseModel with _$BalanceResponseModel {
  const factory BalanceResponseModel({
    @JsonKey(name: 'balance') @Default(BalanceModel()) BalanceModel balance,
  }) = _BalanceResponseModel;

  factory BalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseModelFromJson(json);
}
