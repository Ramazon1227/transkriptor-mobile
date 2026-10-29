// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarAccountModel _$CalendarAccountModelFromJson(
  Map<String, dynamic> json,
) => _CalendarAccountModel(
  id: json['id'] as String? ?? '',
  email: json['email'] as String? ?? '',
  needsReconnect: json['needs_reconnect'] as bool? ?? false,
);

Map<String, dynamic> _$CalendarAccountModelToJson(
  _CalendarAccountModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'needs_reconnect': instance.needsReconnect,
};

_CalendarStateModel _$CalendarStateModelFromJson(Map<String, dynamic> json) =>
    _CalendarStateModel(
      available: json['available'] as bool? ?? false,
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.map(
                (e) => CalendarAccountModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <CalendarAccountModel>[],
    );

Map<String, dynamic> _$CalendarStateModelToJson(_CalendarStateModel instance) =>
    <String, dynamic>{
      'available': instance.available,
      'accounts': instance.accounts,
    };

_CalendarEventModel _$CalendarEventModelFromJson(Map<String, dynamic> json) =>
    _CalendarEventModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      startsAt: json['starts_at'] == null
          ? null
          : DateTime.parse(json['starts_at'] as String),
      endsAt: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
      joinUrl: json['join_url'] as String? ?? '',
      platform: json['platform'] as String? ?? '',
    );

Map<String, dynamic> _$CalendarEventModelToJson(_CalendarEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt?.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'join_url': instance.joinUrl,
      'platform': instance.platform,
    };

_CalendarEventListModel _$CalendarEventListModelFromJson(
  Map<String, dynamic> json,
) => _CalendarEventListModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => CalendarEventModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CalendarEventModel>[],
);

Map<String, dynamic> _$CalendarEventListModelToJson(
  _CalendarEventListModel instance,
) => <String, dynamic>{'items': instance.items};
