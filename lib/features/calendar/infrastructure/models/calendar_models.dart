import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';

part 'calendar_models.freezed.dart';
part 'calendar_models.g.dart';

/// `models.CalendarAccount`; only its presence matters here.
@freezed
abstract class CalendarAccountModel with _$CalendarAccountModel {
  const factory CalendarAccountModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'email') @Default('') String email,
    @JsonKey(name: 'needs_reconnect') @Default(false) bool needsReconnect,
  }) = _CalendarAccountModel;

  factory CalendarAccountModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarAccountModelFromJson(json);
}

/// `data` of `GET /api/v1/calendar`.
@freezed
abstract class CalendarStateModel with _$CalendarStateModel {
  const factory CalendarStateModel({
    @JsonKey(name: 'available') @Default(false) bool available,
    @JsonKey(name: 'accounts')
    @Default(<CalendarAccountModel>[])
    List<CalendarAccountModel> accounts,
  }) = _CalendarStateModel;

  factory CalendarStateModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarStateModelFromJson(json);
}

/// `models.CalendarEvent` in the backend.
@freezed
abstract class CalendarEventModel with _$CalendarEventModel {
  const factory CalendarEventModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'starts_at') DateTime? startsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @JsonKey(name: 'join_url') @Default('') String joinUrl,
    @JsonKey(name: 'platform') @Default('') String platform,
  }) = _CalendarEventModel;

  const CalendarEventModel._();

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);

  CalendarEvent toEntity() => CalendarEvent(
    id: id,
    title: title,
    startsAt: startsAt?.toLocal(),
    endsAt: endsAt?.toLocal(),
    joinUrl: joinUrl,
    platform: platform,
  );
}

/// `data` of `GET /api/v1/calendar/events`.
@freezed
abstract class CalendarEventListModel with _$CalendarEventListModel {
  const factory CalendarEventListModel({
    @JsonKey(name: 'items')
    @Default(<CalendarEventModel>[])
    List<CalendarEventModel> items,
  }) = _CalendarEventListModel;

  factory CalendarEventListModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventListModelFromJson(json);
}
