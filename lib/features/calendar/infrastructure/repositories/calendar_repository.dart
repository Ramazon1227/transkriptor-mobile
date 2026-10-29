import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/calendar/infrastructure/models/calendar_models.dart';

@lazySingleton
class CalendarRepository {
  CalendarRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, CalendarStateModel>> state() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(Endpoints.calendar);
      return CalendarStateModel.fromJson(envelopeData(response.data));
    });
  }

  Future<Either<Failure, CalendarEventListModel>> events() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.calendarEvents,
      );
      return CalendarEventListModel.fromJson(envelopeData(response.data));
    });
  }
}
