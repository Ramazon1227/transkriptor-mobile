// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanModel _$PlanModelFromJson(Map<String, dynamic> json) => _PlanModel(
  code: json['code'] as String? ?? '',
  name: json['name'] as String? ?? '',
  monthlySeconds: (json['monthly_seconds'] as num?)?.toInt() ?? 0,
  priceUzs: json['price_uzs'] as num? ?? 0,
  maxMembers: (json['max_members'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PlanModelToJson(_PlanModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'monthly_seconds': instance.monthlySeconds,
      'price_uzs': instance.priceUzs,
      'max_members': instance.maxMembers,
    };

_PlanListModel _$PlanListModelFromJson(Map<String, dynamic> json) =>
    _PlanListModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => PlanModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlanModel>[],
    );

Map<String, dynamic> _$PlanListModelToJson(_PlanListModel instance) =>
    <String, dynamic>{'items': instance.items};

_BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) =>
    _BalanceModel(
      balanceSeconds: (json['balance_seconds'] as num?)?.toInt() ?? 0,
      plan: json['plan'] == null
          ? null
          : PlanModel.fromJson(json['plan'] as Map<String, dynamic>),
      status:
          $enumDecodeNullable(
            _$SubscriptionStatusEnumMap,
            json['status'],
            unknownValue: SubscriptionStatus.unknown,
          ) ??
          SubscriptionStatus.none,
      periodEnd: json['period_end'] == null
          ? null
          : DateTime.parse(json['period_end'] as String),
      cancelAtPeriodEnd: json['cancel_at_period_end'] as bool? ?? false,
    );

Map<String, dynamic> _$BalanceModelToJson(_BalanceModel instance) =>
    <String, dynamic>{
      'balance_seconds': instance.balanceSeconds,
      'plan': instance.plan,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'period_end': instance.periodEnd?.toIso8601String(),
      'cancel_at_period_end': instance.cancelAtPeriodEnd,
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.none: 'none',
  SubscriptionStatus.active: 'ACTIVE',
  SubscriptionStatus.pastDue: 'PAST_DUE',
  SubscriptionStatus.cancelled: 'CANCELLED',
  SubscriptionStatus.expired: 'EXPIRED',
  SubscriptionStatus.unknown: 'unknown',
};

_BalanceResponseModel _$BalanceResponseModelFromJson(
  Map<String, dynamic> json,
) => _BalanceResponseModel(
  balance: json['balance'] == null
      ? const BalanceModel()
      : BalanceModel.fromJson(json['balance'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BalanceResponseModelToJson(
  _BalanceResponseModel instance,
) => <String, dynamic>{'balance': instance.balance};
