import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

/// An upcoming meeting from the person's connected Google Calendar.
@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String id,
    required String title,
    DateTime? startsAt,
    DateTime? endsAt,

    /// Empty when the event has no video link.
    @Default('') String joinUrl,

    /// MEET, ZOOM, TEAMS or empty.
    @Default('') String platform,
  }) = _CalendarEvent;
}

/// What the home screen needs: whether a calendar is connected at all,
/// and if so the next events.
@freezed
abstract class CalendarOverview with _$CalendarOverview {
  const factory CalendarOverview({
    @Default(false) bool connected,
    @Default(<CalendarEvent>[]) List<CalendarEvent> events,
  }) = _CalendarOverview;
}
