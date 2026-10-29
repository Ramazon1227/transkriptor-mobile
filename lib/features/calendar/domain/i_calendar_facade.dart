import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';

abstract interface class ICalendarFacade {
  /// `GET /calendar`, then — only when an account is connected —
  /// `GET /calendar/events` (the server's window, 14 days by default).
  Future<Either<Failure, CalendarOverview>> upcoming();
}
