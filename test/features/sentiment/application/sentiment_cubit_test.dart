import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_cubit.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_poll_policy.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';

import '../../../helpers/sentiment_fakes.dart';

Future<void> settle([int ms = 30]) =>
    Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  late FakeSentimentFacade facade;
  final fast = SentimentPollPolicy.custom(
    interval: const Duration(milliseconds: 3),
  );

  setUp(() => facade = FakeSentimentFacade());

  SentimentCubit make() {
    final c = SentimentCubit(facade, fast);
    addTearDown(c.close);
    return c;
  }

  blocTest<SentimentCubit, SentimentState>(
    'never requested: success with no analysis, no polling',
    build: () => SentimentCubit(facade, fast),
    act: (c) => c.load('t1'),
    wait: const Duration(milliseconds: 20),
    expect: () => const [
      SentimentState(status: SentimentViewStatus.loading),
      SentimentState(status: SentimentViewStatus.success),
    ],
    verify: (_) => expect(facade.getCalls, 1),
  );

  test('first load failing is a failure state; reload recovers', () async {
    facade.answer(const Left(Failure.network()));
    final c = make();
    await c.load('t1');
    expect(c.state.status, SentimentViewStatus.failure);
    expect(c.state.failure, const Failure.network());
    await c.reload();
    expect(c.state.status, SentimentViewStatus.success);
  });

  test('analyze → PENDING → polls until DONE, then stops', () async {
    final c = make();
    await c.load('t1');
    facade.analyzes.add(const Right(pendingAnalysis));
    facade
      ..answer(const Right(pendingAnalysis))
      ..answer(const Right(doneAnalysis));
    final accepted = await c.analyze();
    expect(accepted, isTrue);
    expect(c.state.pending, isTrue);
    expect(c.state.labels, isEmpty);
    await settle();
    expect(c.state.analysis?.status, SentimentStatus.done);
    expect(c.state.labels['g2'], SentimentLabel.negative);
    final calls = facade.getCalls;
    await settle();
    expect(facade.getCalls, calls, reason: 'no polling after DONE');
  });

  test('a FAILED run stops the polling and can be retried', () async {
    final c = make();
    await c.load('t1');
    facade.analyzes.add(const Right(pendingAnalysis));
    facade.answer(
      const Right(
        SentimentAnalysis(status: SentimentStatus.failed, error: 'Xato.'),
      ),
    );
    await c.analyze();
    await settle();
    expect(c.state.analysis?.status, SentimentStatus.failed);
    final calls = facade.getCalls;
    await settle();
    expect(facade.getCalls, calls);
    expect(c.state.canStart, isTrue);
  });

  test('403 (VIEWER) is a start failure; the panel is kept', () async {
    final c = make();
    await c.load('t1');
    facade.analyzes.add(const Left(Failure.server(statusCode: 403)));
    expect(await c.analyze(), isFalse);
    expect(c.state.startFailure, const Failure.server(statusCode: 403));
    expect(c.state.starting, isFalse);
    expect(c.state.analysis, isNull);
    c.dismissStartFailure();
    expect(c.state.startFailure, isNull);
  });

  test('409 refetches and shows the run already going', () async {
    final c = make();
    await c.load('t1');
    facade.analyzes.add(
      const Left(Failure.server(statusCode: 409, message: 'band')),
    );
    facade.fallback = const Right(pendingAnalysis);
    await c.analyze();
    await settle(5);
    expect(c.state.startFailure, isA<ServerFailure>());
    expect(c.state.pending, isTrue);
  });

  test(
    'a 503 on a re-run refetches: the server state replaces the old result',
    () async {
      facade.answer(const Right(doneAnalysis));
      final c = make();
      await c.load('t1');
      expect(c.state.labels, isNotEmpty);
      facade.analyzes.add(
        const Left(Failure.server(statusCode: 503, message: 'AI band')),
      );
      facade.fallback = const Right(
        SentimentAnalysis(status: SentimentStatus.failed, error: 'AI band'),
      );
      expect(await c.analyze(), isFalse);
      await settle(5);
      expect(c.state.startFailure, isA<ServerFailure>());
      expect(c.state.analysis?.status, SentimentStatus.failed);
      expect(c.state.labels, isEmpty, reason: 'no markers the server dropped');
    },
  );

  test(
    'a permanent poll failure (404) ends polling in the failure view',
    () async {
      facade.answer(const Right(pendingAnalysis));
      final c = make();
      await c.load('t1');
      facade.answer(const Left(Failure.server(statusCode: 404)));
      await settle();
      expect(c.state.status, SentimentViewStatus.failure);
      expect(c.state.failure, const Failure.server(statusCode: 404));
      final calls = facade.getCalls;
      await settle();
      expect(facade.getCalls, calls, reason: 'no polling after a 404');
    },
  );

  test('a dropped connection or a broken body keeps polling', () async {
    facade.answer(const Right(pendingAnalysis));
    final c = make();
    await c.load('t1');
    facade
      ..answer(const Left(Failure.unknown()))
      ..answer(const Left(Failure.parsing()))
      ..answer(const Right(doneAnalysis));
    // Three polls 3 ms apart; real timers, so leave room.
    await settle(150);
    expect(c.state.status, SentimentViewStatus.success);
    expect(c.state.pollFailure, isNull);
    expect(c.state.analysis?.isDone, isTrue);
  });

  test('no start while one is pending', () async {
    facade.answer(const Right(pendingAnalysis));
    final c = make();
    await c.load('t1');
    expect(c.state.canStart, isFalse);
    expect(await c.analyze(), isFalse);
    expect(facade.analyzeCalls, 0);
  });

  test('inactive tab stops polling; coming back refreshes at once', () async {
    facade.fallback = const Right(pendingAnalysis);
    final c = make();
    await c.load('t1');
    await c.setActive(active: false);
    final calls = facade.getCalls;
    await settle();
    expect(facade.getCalls, calls, reason: 'no polling while hidden');
    facade.fallback = const Right(doneAnalysis);
    await c.setActive(active: true);
    expect(facade.getCalls, calls + 1);
    expect(c.state.analysis?.isDone, isTrue);
  });

  test('a transient poll failure keeps polling', () async {
    facade.answer(const Right(pendingAnalysis));
    final c = make();
    await c.load('t1');
    facade
      ..answer(const Left(Failure.timeout()))
      ..answer(const Right(doneAnalysis));
    await settle();
    expect(c.state.pollFailure, isNull);
    expect(c.state.analysis?.isDone, isTrue);
  });

  test('a late poll answer never overwrites a newer start', () async {
    facade.answer(const Right(doneAnalysis));
    final c = make();
    await c.load('t1');
    // Re-entering the tab starts a refresh that is held…
    await c.setActive(active: false);
    final late = facade.held();
    final refresh = c.setActive(active: true);
    // …and a re-run is accepted meanwhile.
    facade.analyzes.add(const Right(pendingAnalysis));
    facade.fallback = const Right(pendingAnalysis);
    await c.analyze();
    late.complete(const Right(doneAnalysis));
    await refresh;
    expect(c.state.pending, isTrue);
  });

  test('close cancels the timer', () async {
    facade.fallback = const Right(pendingAnalysis);
    final c = SentimentCubit(facade, fast);
    await c.load('t1');
    await c.close();
    final calls = facade.getCalls;
    await settle();
    expect(facade.getCalls, calls);
  });
}
