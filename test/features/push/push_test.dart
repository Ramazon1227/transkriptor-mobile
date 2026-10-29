import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/push/application/push_cubit.dart';
import 'package:transkriptor_uz/features/push/domain/i_push_facade.dart';
import 'package:transkriptor_uz/features/push/domain/push_message.dart';
import 'package:transkriptor_uz/features/push/infrastructure/facades/push_facade.dart';
import 'package:transkriptor_uz/features/push/infrastructure/messaging/messaging_source.dart';
import 'package:transkriptor_uz/features/push/infrastructure/repositories/push_repository.dart';

class _MockSource extends Mock implements MessagingSource;

class _MockRepository extends Mock implements PushRepository;

class _MockPushFacade extends Mock implements IPushFacade;

void main() {
  group('PushMessage.fromData', () {
    test('reads a job message', () {
      expect(
        PushMessage.fromData(const {
          'type': 'job',
          'job_id': 'j1',
          'status': 'SUCCEEDED',
          'transcript_id': 't1',
        }),
        const PushMessage(jobId: 'j1', transcriptId: 't1'),
      );
      expect(
        PushMessage.fromData(const {'type': 'job', 'job_id': 'j1'}),
        const PushMessage(jobId: 'j1'),
      );
    });

    test('anything else is ignored', () {
      expect(PushMessage.fromData(const {}), isNull);
      expect(PushMessage.fromData(const {'type': 'promo'}), isNull);
      expect(PushMessage.fromData(const {'type': 'job'}), isNull);
    });
  });

  group('PushFacade', () {
    late _MockSource source;
    late _MockRepository repository;
    late StreamController<String> refresh;
    late PushFacade facade;

    setUp(() {
      source = _MockSource();
      repository = _MockRepository();
      refresh = StreamController<String>.broadcast();
      when(() => source.enabled).thenReturn(true);
      when(() => source.tokenRefresh).thenAnswer((_) => refresh.stream);
      when(() => source.deleteToken()).thenAnswer((_) async {});
      when(
        () => repository.register(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer((_) async => const Right(unit));
      when(() => repository.unregister(token: any(named: 'token')))
          .thenAnswer((_) async => const Right(unit));
      facade = PushFacade(source, repository);
    });

    tearDown(() => refresh.close());

    test('without Firebase settings nothing is touched', () async {
      when(() => source.enabled).thenReturn(false);
      expect(await facade.register(), const Right<Failure, Object>(unit));
      await facade.unregister();
      verifyNever(() => source.requestPermission());
      verifyNever(() => source.deleteToken());
    });

    test('registers the token, and a rotated one too', () async {
      when(() => source.requestPermission()).thenAnswer((_) async => true);
      when(() => source.token()).thenAnswer((_) async => 'tok-1');

      expect((await facade.register()).isRight(), isTrue);
      verify(() => repository.register(token: 'tok-1', platform: 'ANDROID'))
          .called(1);

      refresh.add('tok-2');
      await Future<void>.delayed(Duration.zero);
      verify(() => repository.register(token: 'tok-2', platform: 'ANDROID'))
          .called(1);

      await facade.unregister();
      verify(() => repository.unregister(token: 'tok-2')).called(1);
      verify(() => source.deleteToken()).called(1);
    });

    test('a refused permission sends nothing', () async {
      when(() => source.requestPermission()).thenAnswer((_) async => false);
      expect(
        await facade.register(),
        const Left<Failure, Object>(Failure.permissionDenied()),
      );
      verifyNever(
        () => repository.register(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      );
    });

    test('an FCM error is a failure, not a crash', () async {
      when(() => source.requestPermission()).thenThrow(Exception('no gms'));
      expect(
        await facade.register(),
        const Left<Failure, Object>(Failure.unknown()),
      );
    });

    test('only job messages come through', () async {
      when(() => source.opened).thenAnswer(
        (_) => Stream.fromIterable(const [
          {'type': 'promo'},
          {'type': 'job', 'job_id': 'j1'},
        ]),
      );
      expect(await facade.opened.toList(), const [PushMessage(jobId: 'j1')]);
    });
  });

  group('PushCubit', () {
    late _MockPushFacade facade;
    late LibraryChanges changes;
    late StreamController<PushMessage> opened;
    late StreamController<PushMessage> received;

    setUp(() {
      facade = _MockPushFacade();
      changes = LibraryChanges();
      // Broadcast: closing an unlistened single-subscription controller
      // never completes.
      opened = StreamController<PushMessage>.broadcast();
      received = StreamController<PushMessage>.broadcast();
      when(() => facade.isAvailable).thenReturn(true);
      when(() => facade.opened).thenAnswer((_) => opened.stream);
      when(() => facade.received).thenAnswer((_) => received.stream);
      when(() => facade.register()).thenAnswer((_) async => const Right(unit));
    });

    tearDown(() async {
      await opened.close();
      await received.close();
      await changes.dispose();
    });

    blocTest<PushCubit, PushState>(
      'a tap is emitted, each one counted',
      build: () => PushCubit(facade, changes),
      act: (cubit) async {
        await cubit.start();
        opened
          ..add(const PushMessage(jobId: 'j1', transcriptId: 't1'))
          ..add(const PushMessage(jobId: 'j1', transcriptId: 't1'));
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => const [
        PushState(
          opened: PushMessage(jobId: 'j1', transcriptId: 't1'),
          tapCount: 1,
          available: true,
        ),
        PushState(
          opened: PushMessage(jobId: 'j1', transcriptId: 't1'),
          tapCount: 2,
          available: true,
        ),
      ],
      verify: (_) => verify(() => facade.register()).called(1),
    );

    test('a foreground message refreshes the lists', () async {
      final cubit = PushCubit(facade, changes);
      final notified = changes.stream.first;
      await cubit.start();
      received.add(const PushMessage(jobId: 'j1'));
      await notified;
      await cubit.close();
    });

    blocTest<PushCubit, PushState>(
      'unavailable push does nothing',
      setUp: () => when(() => facade.isAvailable).thenReturn(false),
      build: () => PushCubit(facade, changes),
      act: (cubit) => cubit.start(),
      expect: () => const <PushState>[],
      verify: (cubit) {
        verifyNever(() => facade.register());
        // Settings says notifications are not set up.
        expect(cubit.state.available, isFalse);
      },
    );
  });
}
