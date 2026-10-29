import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';
import 'package:transkriptor_uz/features/calendar/domain/i_calendar_facade.dart';
import 'package:transkriptor_uz/features/calendar/infrastructure/repositories/calendar_repository.dart';

@LazySingleton(as: ICalendarFacade)
class CalendarFacade implements ICalendarFacade {
  CalendarFacade(this._repository);

  final CalendarRepository _repository;

  @override
  Future<Either<Failure, CalendarOverview>> upcoming() async {
    final state = await _repository.state();
    return await state.fold((failure) async => Left(failure), (s) async {
      // Calendar off on the server, or nothing connected: no second call.
      if (!s.available || s.accounts.isEmpty) {
        return const Right(CalendarOverview());
      }
      final events = await _repository.events();
      return events.map(
        (list) => CalendarOverview(
          connected: true,
          events: list.items.map((e) => e.toEntity()).toList(),
        ),
      );
    });
  }
}
