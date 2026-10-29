import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/calendar/application/calendar_cubit.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';
import 'package:transkriptor_uz/features/calendar/domain/i_calendar_facade.dart';
import 'package:transkriptor_uz/features/calendar/infrastructure/facades/calendar_facade.dart';
import 'package:transkriptor_uz/features/calendar/infrastructure/repositories/calendar_repository.dart';

import '../../helpers/fake_http_adapter.dart';

class _MockFacade extends Mock implements ICalendarFacade;

void main() {
  group('CalendarFacade', () {
    test('nothing connected: no events request', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/calendar': (
          200,
          ok({'available': true, 'accounts': <Object>[]}),
        ),
      });
      final result = await CalendarFacade(CalendarRepository(fakeDio(http)))
          .upcoming();

      expect(
        result,
        const Right<Failure, CalendarOverview>(CalendarOverview()),
      );
      expect(http.sent, hasLength(1));
    });

    test('connected: reads the events', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/calendar': (
          200,
          ok({
            'available': true,
            'accounts': [
              {'id': 'a', 'provider': 'GOOGLE', 'email': 'e@misol.uz'},
            ],
          }),
        ),
        'GET /api/v1/calendar/events': (
          200,
          ok({
            'items': [
              {
                'id': 'e1',
                'title': 'Haftalik yigʻilish',
                'starts_at': '2026-10-30T09:00:00Z',
                'ends_at': '2026-10-30T10:00:00Z',
                'join_url': 'https://meet.google.com/abc-defg-hij',
                'platform': 'MEET',
                'attendees': <Object>[],
              },
            ],
          }),
        ),
      });
      final overview = (await CalendarFacade(
        CalendarRepository(fakeDio(http)),
      ).upcoming()).getOrElse(() => throw StateError('left'));

      expect(overview.connected, isTrue);
      expect(overview.events.single.title, 'Haftalik yigʻilish');
      expect(overview.events.single.platform, 'MEET');
      expect(overview.events.single.startsAt, isNotNull);
    });
  });

  group('CalendarCubit', () {
    late _MockFacade facade;
    final event = CalendarEvent(
      id: 'e1',
      title: 'T',
      startsAt: DateTime(2026, 10, 30, 9),
    );

    setUp(() => facade = _MockFacade());

    blocTest<CalendarCubit, CalendarState>(
      'no calendar connected',
      setUp: () =>
          when(() => facade.upcoming())
              .thenAnswer((_) async => const Right(CalendarOverview())),
      build: () => CalendarCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => const [CalendarState(status: CalendarStatus.notConnected)],
    );

    blocTest<CalendarCubit, CalendarState>(
      'connected without events is empty',
      setUp: () => when(
        () => facade.upcoming(),
      ).thenAnswer((_) async => const Right(CalendarOverview(connected: true))),
      build: () => CalendarCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => const [CalendarState(status: CalendarStatus.empty)],
    );

    blocTest<CalendarCubit, CalendarState>(
      'events are listed',
      setUp: () => when(() => facade.upcoming()).thenAnswer(
        (_) async => Right(CalendarOverview(connected: true, events: [event])),
      ),
      build: () => CalendarCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => [
        CalendarState(status: CalendarStatus.success, events: [event]),
      ],
    );

    blocTest<CalendarCubit, CalendarState>(
      'a failure is reported',
      setUp: () =>
          when(() => facade.upcoming())
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => CalendarCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => const [
        CalendarState(
          status: CalendarStatus.failure,
          failure: Failure.network(),
        ),
      ],
    );
  });
}
