import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/meeting_bot/application/meeting_bot_cubit.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/i_meeting_bot_facade.dart';

class _MockFacade extends Mock implements IMeetingBotFacade;

MeetingBot _bot(MeetingBotStatus status, {String id = 'b1'}) => MeetingBot(
  id: id,
  status: status,
  meetUrl: 'https://meet.google.com/abc-defg-hij',
  jobId: status == MeetingBotStatus.done ? 'j1' : null,
);

void main() {
  late _MockFacade facade;
  late LibraryChanges changes;
  final fast = JobPollPolicy.custom(
    first: const Duration(milliseconds: 1),
    max: const Duration(milliseconds: 4),
  );

  void answer(List<Either<Failure, MeetingBot>> answers) {
    var i = 0;
    when(() => facade.get(any())).thenAnswer((_) async {
      final a = answers[i < answers.length ? i : answers.length - 1];
      i++;
      return a;
    });
  }

  setUp(() {
    facade = _MockFacade();
    changes = LibraryChanges();
    when(() => facade.list(workspaceId: any(named: 'workspaceId')))
        .thenAnswer((_) async => const Right(MeetingBotList()));
  });

  tearDown(() => changes.dispose());

  MeetingBotCubit build() => MeetingBotCubit(facade, fast, changes);

  blocTest<MeetingBotCubit, MeetingBotState>(
    'a 404 for the list route says the server has no bot yet',
    setUp: () => when(() => facade.list(workspaceId: any(named: 'workspaceId')))
        .thenAnswer((_) async => const Left(Failure.server(statusCode: 404))),
    build: build,
    act: (c) => c.load('w1'),
    verify: (c) {
      expect(c.state.routeMissing, isTrue);
      expect(c.state.listFailure, isNull);
    },
  );

  blocTest<MeetingBotCubit, MeetingBotState>(
    'a 404 on send says the same, not a generic error',
    setUp: () => when(
      () => facade.create(
        workspaceId: any(named: 'workspaceId'),
        meetUrl: any(named: 'meetUrl'),
        keepVideo: any(named: 'keepVideo'),
        numSpeakers: any(named: 'numSpeakers'),
        summarize: any(named: 'summarize'),
        summaryTemplateId: any(named: 'summaryTemplateId'),
        shareInternal: any(named: 'shareInternal'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server(statusCode: 404))),
    build: build,
    seed: () => const MeetingBotState(workspaceId: 'w1'),
    act: (c) =>
        c.submit(url: 'https://meet.google.com/abc-defg-hij', keepVideo: false),
    verify: (c) {
      expect(c.state.routeMissing, isTrue);
      expect(c.state.actionFailure, isNull);
    },
  );

  blocTest<MeetingBotCubit, MeetingBotState>(
    'not a Meet link: nothing is sent',
    build: build,
    seed: () => const MeetingBotState(workspaceId: 'w1'),
    act: (c) => c.submit(url: 'https://zoom.us/j/123456789', keepVideo: false),
    expect: () => const [MeetingBotState(workspaceId: 'w1', urlInvalid: true)],
    verify: (_) => verifyNever(
      () => facade.create(
        workspaceId: any(named: 'workspaceId'),
        meetUrl: any(named: 'meetUrl'),
        keepVideo: any(named: 'keepVideo'),
        numSpeakers: any(named: 'numSpeakers'),
        summarize: any(named: 'summarize'),
        summaryTemplateId: any(named: 'summaryTemplateId'),
        shareInternal: any(named: 'shareInternal'),
      ),
    ),
  );

  blocTest<MeetingBotCubit, MeetingBotState>(
    'send → polls through the steps and stops on done',
    setUp: () {
      when(
        () => facade.create(
          workspaceId: any(named: 'workspaceId'),
          meetUrl: any(named: 'meetUrl'),
          keepVideo: any(named: 'keepVideo'),
          numSpeakers: any(named: 'numSpeakers'),
          summarize: any(named: 'summarize'),
          summaryTemplateId: any(named: 'summaryTemplateId'),
          shareInternal: any(named: 'shareInternal'),
        ),
      ).thenAnswer((_) async => Right(_bot(MeetingBotStatus.joining)));
      answer([
        Right(_bot(MeetingBotStatus.waiting)),
        Right(_bot(MeetingBotStatus.recording)),
        Right(_bot(MeetingBotStatus.uploading)),
        Right(_bot(MeetingBotStatus.done)),
      ]);
    },
    build: build,
    seed: () => const MeetingBotState(workspaceId: 'w1'),
    act: (c) => c.submit(
      url: 'https://meet.google.com/abc-defg-hij?authuser=0',
      keepVideo: true,
      numSpeakers: 2,
    ),
    wait: const Duration(milliseconds: 80),
    verify: (c) {
      expect(c.state.active?.status, MeetingBotStatus.done);
      expect(c.state.items.single.status, MeetingBotStatus.done);
      // Four polls, then none: done is terminal.
      verify(() => facade.get('b1')).called(4);
      verify(
        () => facade.create(
          workspaceId: 'w1',
          meetUrl: 'https://meet.google.com/abc-defg-hij',
          keepVideo: true,
          numSpeakers: 2,
        ),
      ).called(1);
    },
  );

  blocTest<MeetingBotCubit, MeetingBotState>(
    'summary options go only with summarize',
    setUp: () {
      when(
        () => facade.create(
          workspaceId: any(named: 'workspaceId'),
          meetUrl: any(named: 'meetUrl'),
          keepVideo: any(named: 'keepVideo'),
          numSpeakers: any(named: 'numSpeakers'),
          summarize: any(named: 'summarize'),
          summaryTemplateId: any(named: 'summaryTemplateId'),
          shareInternal: any(named: 'shareInternal'),
        ),
      ).thenAnswer((_) async => Right(_bot(MeetingBotStatus.done)));
    },
    build: build,
    seed: () => const MeetingBotState(workspaceId: 'w1'),
    act: (c) async {
      await c.submit(
        url: 'https://meet.google.com/abc-defg-hij',
        keepVideo: false,
        summaryTemplateId: 'tp',
        shareInternal: true,
      );
      await c.submit(
        url: 'https://meet.google.com/abc-defg-hij',
        keepVideo: false,
        summarize: true,
        summaryTemplateId: 'tp',
        shareInternal: true,
      );
    },
    verify: (_) {
      verify(
        () => facade.create(
          workspaceId: 'w1',
          meetUrl: 'https://meet.google.com/abc-defg-hij',
          keepVideo: false,
        ),
      ).called(1);
      verify(
        () => facade.create(
          workspaceId: 'w1',
          meetUrl: 'https://meet.google.com/abc-defg-hij',
          keepVideo: false,
          summarize: true,
          summaryTemplateId: 'tp',
          shareInternal: true,
        ),
      ).called(1);
    },
  );

  test('done announces a library change once', () async {
    answer([Right(_bot(MeetingBotStatus.done))]);
    var notified = 0;
    final sub = changes.stream.listen((_) => notified++);
    final cubit = build()..watch(_bot(MeetingBotStatus.uploading));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(notified, 1);
    await sub.cancel();
    await cubit.close();
  });

  test('a terminal bot from the list is not polled', () async {
    final cubit = build()..watch(_bot(MeetingBotStatus.denied));
    await Future<void>.delayed(const Duration(milliseconds: 20));
    verifyNever(() => facade.get(any()));
    await cubit.close();
  });

  test('a late poll for an older bot is ignored', () async {
    final slow = Completer<Either<Failure, MeetingBot>>();
    when(() => facade.get('old')).thenAnswer((_) => slow.future);
    when(
      () => facade.get('new'),
    ).thenAnswer((_) async => Right(_bot(MeetingBotStatus.waiting, id: 'new')));
    final cubit = build()..watch(_bot(MeetingBotStatus.joining, id: 'old'));
    await Future<void>.delayed(const Duration(milliseconds: 10));
    cubit.watch(_bot(MeetingBotStatus.joining, id: 'new'));
    slow.complete(Right(_bot(MeetingBotStatus.done, id: 'old')));
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(cubit.state.active?.id, 'new');
    expect(cubit.state.active?.status, MeetingBotStatus.waiting);
    await cubit.close();
  });

  test('dismiss stops polling', () async {
    answer([Right(_bot(MeetingBotStatus.waiting))]);
    final cubit = build()..watch(_bot(MeetingBotStatus.joining));
    await Future<void>.delayed(const Duration(milliseconds: 15));
    cubit.dismiss();
    clearInteractions(facade);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    verifyNever(() => facade.get(any()));
    expect(cubit.state.active, isNull);
    await cubit.close();
  });

  test('a transient poll failure keeps polling; a 404 stops', () async {
    answer([
      const Left(Failure.network()),
      Right(_bot(MeetingBotStatus.recording)),
      const Left(Failure.server(statusCode: 404)),
    ]);
    final cubit = build()..watch(_bot(MeetingBotStatus.waiting));
    await Future<void>.delayed(const Duration(milliseconds: 60));
    expect(cubit.state.active?.status, MeetingBotStatus.recording);
    expect(cubit.state.pollFailure, const Failure.server(statusCode: 404));
    clearInteractions(facade);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    verifyNever(() => facade.get(any()));
    await cubit.close();
  });

  test('cancel while recording keeps following until it ends', () async {
    when(() => facade.cancel('b1')).thenAnswer(
      (_) async => Right(
        _bot(MeetingBotStatus.recording).copyWith(cancelRequested: true),
      ),
    );
    answer([Right(_bot(MeetingBotStatus.uploading))]);
    final cubit = build()..watch(_bot(MeetingBotStatus.recording));
    // No poll answer is due yet at 1 ms: cancel first.
    await cubit.cancel();
    expect(cubit.state.active?.cancelRequested, isTrue);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(cubit.state.active?.status, MeetingBotStatus.uploading);
    await cubit.close();
  });
}
