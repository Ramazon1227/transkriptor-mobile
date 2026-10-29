import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';
import 'package:transkriptor_uz/features/calendar/domain/i_calendar_facade.dart';

part 'calendar_cubit.freezed.dart';

/// [notConnected]: no Google Calendar on this account (it is connected on
/// the web). [empty]: connected, no upcoming events.
enum CalendarStatus { initial, loading, success, empty, notConnected, failure }

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    @Default(CalendarStatus.initial) CalendarStatus status,
    @Default(<CalendarEvent>[]) List<CalendarEvent> events,
    Failure? failure,
  }) = _CalendarState;
}

/// The home screen's upcoming meetings.
@injectable
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._facade) : super(const CalendarState());

  final ICalendarFacade _facade;

  Future<void> load() async {
    emit(state.copyWith(status: CalendarStatus.loading, failure: null));
    final result = await _facade.upcoming();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: CalendarStatus.failure, failure: failure),
      ),
      (overview) => emit(
        CalendarState(
          status: !overview.connected
              ? CalendarStatus.notConnected
              : overview.events.isEmpty
              ? CalendarStatus.empty
              : CalendarStatus.success,
          events: overview.events,
        ),
      ),
    );
  }
}
