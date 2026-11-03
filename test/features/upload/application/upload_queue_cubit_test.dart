import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/application/upload_queue_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/upload_cancel.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

class _MockFacade extends Mock implements IUploadFacade;

class _FakePendingFile extends Fake implements PendingFile;

PendingFile _file(String name) => PendingFile(
  path: '/tmp/$name',
  fileName: name,
  sizeBytes: 10,
  source: UploadSource.upload,
);

const _job = Job(id: 'j1', mediaId: 'm1', status: JobStatus.queued);

void main() {
  late _MockFacade facade;
  late List<String> sent;

  setUpAll(() => registerFallbackValue(_FakePendingFile()));

  setUp(() {
    facade = _MockFacade();
    sent = [];
    when(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((call) async {
      final file = call.namedArguments[#file] as PendingFile;
      sent.add(file.fileName);
      return Right(UploadResult(mediaId: 'm-${file.fileName}', job: _job));
    });
  });

  QueueItemStatus statusOf(UploadQueueCubit c, String name) =>
      c.state.items.firstWhere((i) => i.file.fileName == name).status;

  test('open drops a file picked twice; the same goes for addMore', () async {
    when(() => facade.pickFiles())
        .thenAnswer((_) async => Right([_file('b.wav'), _file('c.mov')]));
    final cubit = UploadQueueCubit(facade)
      ..open([_file('a.mp3'), _file('b.wav'), _file('a.mp3')]);
    expect(cubit.state.items.map((i) => i.file.fileName), ['a.mp3', 'b.wav']);

    await cubit.addMore();
    expect(cubit.state.items.map((i) => i.file.fileName), [
      'a.mp3',
      'b.wav',
      'c.mov',
    ]);
    await cubit.close();
  });

  test('a closed picker changes nothing; a failed one says so', () async {
    final cubit = UploadQueueCubit(facade)..open([_file('a.mp3')]);
    when(() => facade.pickFiles()).thenAnswer((_) async => const Right([]));
    await cubit.addMore();
    expect(cubit.state.items, hasLength(1));

    when(() => facade.pickFiles())
        .thenAnswer((_) async => const Left(Failure.storage()));
    await cubit.addMore();
    expect(cubit.state.pickFailure, const Failure.storage());
    expect(cubit.state.items, hasLength(1));
    await cubit.close();
  });

  test('each file gets its own upload and job, in turn', () async {
    final cubit = UploadQueueCubit(facade)
      ..open([_file('a.mp3'), _file('b.wav')]);
    await cubit.start(
      workspaceId: 'w1',
      numSpeakers: 3,
      service: JobService.subtitle,
    );

    expect(sent, ['a.mp3', 'b.wav']);
    verify(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: 'w1',
        title: 'a',
        startTranscription: true,
        jobKey: any(named: 'jobKey'),
        numSpeakers: 3,
        service: JobService.subtitle,
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).called(1);
    expect(cubit.state.allStarted, isTrue);
    expect(cubit.state.running, isFalse);
    await cubit.close();
  });

  test(
    'a failed file does not stop the next, and only it is retried',
    () async {
      when(
        () => facade.upload(
          file: any(
            named: 'file',
            that: predicate<PendingFile>((f) => f.fileName == 'a.mp3'),
          ),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((_) async => const Left(Failure.network()));

      final cubit = UploadQueueCubit(facade)
        ..open([_file('a.mp3'), _file('b.wav')]);
      await cubit.start(workspaceId: 'w1');

      expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.failed);
      expect(statusOf(cubit, 'b.wav'), QueueItemStatus.started);
      expect(cubit.state.items.first.failure, const Failure.network());
      expect(sent, ['b.wav']);
      await cubit.close();
    },
  );

  test('a stored file retries the job only, not the upload', () async {
    when(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer(
      (_) async => const Right(
        UploadResult(
          mediaId: 'm1',
          startFailure: Failure.server(statusCode: 402),
        ),
      ),
    );
    when(
      () => facade.startTranscription(
        mediaId: 'm1',
        idempotencyKey: any(named: 'idempotencyKey'),
        numSpeakers: 2,
      ),
    ).thenAnswer((_) async => const Right(_job));

    final file = _file('a.mp3');
    final cubit = UploadQueueCubit(facade)..open([file]);
    await cubit.start(workspaceId: 'w1');
    expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.stored);
    expect(cubit.state.items.single.failure, isNotNull);

    await cubit.retry(file.path, workspaceId: 'w1', numSpeakers: 2);
    expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.started);
    expect(cubit.state.items.single.failure, isNull);
    verifyNever(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: 'w2',
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
      ),
    );
    verify(
      () => facade.startTranscription(
        mediaId: 'm1',
        idempotencyKey: any(named: 'idempotencyKey'),
        numSpeakers: 2,
      ),
    ).called(1);
    await cubit.close();
  });

  test('a stored file whose start answer was lost retries with the '
      'upload’s key; JOB_ACTIVE stays on the row', () async {
    String? uploadKey;
    when(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((inv) async {
      uploadKey = inv.namedArguments[#jobKey] as String;
      return const Right(
        UploadResult(mediaId: 'm1', startFailure: Failure.network()),
      );
    });
    final keys = <String>[];
    when(
      () => facade.startTranscription(
        mediaId: 'm1',
        idempotencyKey: any(named: 'idempotencyKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
      ),
    ).thenAnswer((inv) async {
      keys.add(inv.namedArguments[#idempotencyKey] as String);
      return const Left(Failure.jobActive());
    });

    final file = _file('a.mp3');
    final cubit = UploadQueueCubit(facade)..open([file]);
    await cubit.start(workspaceId: 'w1');
    await cubit.retry(file.path, workspaceId: 'w1');

    expect(keys.single, uploadKey);
    expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.stored);
    expect(cubit.state.items.single.failure, const Failure.jobActive());
    await cubit.close();
  });

  test('a file removed while it waited is skipped; the uploading one is '
      'cancelled and its late answer ignored', () async {
    final a = _file('a.mp3');
    final b = _file('b.wav');
    final cubit = UploadQueueCubit(facade)..open([a, b]);
    when(
      () => facade.upload(
        file: any(
          named: 'file',
          that: predicate<PendingFile>((f) => f.fileName == 'a.mp3'),
        ),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((_) async {
      sent.add('a.mp3');
      cubit
        ..remove(a.path)
        ..remove(b.path);
      return const Right(UploadResult(mediaId: 'm1', job: _job));
    });

    await cubit.start(workspaceId: 'w1');

    expect(sent, ['a.mp3']);
    expect(cubit.state.items, isEmpty);
    expect(cubit.state.running, isFalse);
    await cubit.close();
  });

  test('a second tap while the list runs starts nothing more', () async {
    final cubit = UploadQueueCubit(facade)..open([_file('a.mp3')]);
    final first = cubit.start(workspaceId: 'w1');
    await cubit.start(workspaceId: 'w1');
    await first;
    expect(sent, ['a.mp3']);
    await cubit.close();
  });

  blocTest<UploadQueueCubit, UploadQueueState>(
    'reports progress once per percent',
    build: () {
      when(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((call) async {
        (call.namedArguments[#onProgress] as void Function(double))
          ..call(.5)
          ..call(.501);
        return const Right(UploadResult(mediaId: 'm1', job: _job));
      });
      return UploadQueueCubit(facade)..open([_file('a.mp3')]);
    },
    act: (c) => c.start(workspaceId: 'w1'),
    verify: (c) => expect(c.state.items.single.progress, 1.0),
    expect: () => [
      predicate<UploadQueueState>((s) => s.running),
      predicate<UploadQueueState>(
        (s) => s.items.single.status == QueueItemStatus.uploading,
      ),
      predicate<UploadQueueState>((s) => s.items.single.progress == .5),
      predicate<UploadQueueState>(
        (s) => s.items.single.status == QueueItemStatus.started,
      ),
      predicate<UploadQueueState>((s) => !s.running),
    ],
  );

  /// Holds every upload until it is cancelled; [held] lists what started.
  List<String> holdUploads() {
    final held = <String>[];
    when(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((call) {
      final file = call.namedArguments[#file] as PendingFile;
      final cancel = call.namedArguments[#cancel] as UploadCancel?;
      held.add(file.fileName);
      final done = Completer<Either<Failure, UploadResult>>();
      cancel!.onCancel(() => done.complete(const Left(Failure.cancelled())));
      return done.future;
    });
    return held;
  }

  test('× on an uploading file cancels it; the next one goes on', () async {
    final held = holdUploads();
    final cubit = UploadQueueCubit(facade)
      ..open([_file('a.mp3'), _file('b.wav')]);
    unawaited(cubit.start(workspaceId: 'w1'));
    await pumpEventQueue();
    expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.uploading);
    expect(cubit.state.uploading, isTrue);

    cubit.remove('/tmp/a.mp3');
    await pumpEventQueue();
    expect(cubit.state.items.map((i) => i.file.fileName), ['b.wav']);
    expect(held, ['a.mp3', 'b.wav']);
    expect(statusOf(cubit, 'b.wav'), QueueItemStatus.uploading);

    cubit.remove('/tmp/b.wav');
    await pumpEventQueue();
    expect(cubit.state.items, isEmpty);
    expect(cubit.state.running, isFalse);
    await cubit.close();
  });

  test(
    'leaving cancels the upload and drops the files waiting their turn',
    () async {
      final held = holdUploads();
      final cubit = UploadQueueCubit(facade)
        ..open([_file('a.mp3'), _file('b.wav')]);
      unawaited(cubit.start(workspaceId: 'w1'));
      await pumpEventQueue();

      cubit.cancelAll();
      await pumpEventQueue();
      expect(cubit.state.items, isEmpty);
      expect(held, ['a.mp3']);
      expect(cubit.state.running, isFalse);
      await cubit.close();
    },
  );

  test(
    'closing the page cancels the upload: no job starts unwatched',
    () async {
      final held = holdUploads();
      final cubit = UploadQueueCubit(facade)..open([_file('a.mp3')]);
      unawaited(cubit.start(workspaceId: 'w1'));
      await pumpEventQueue();
      expect(held, ['a.mp3']);
      await cubit.close();
      await pumpEventQueue();
      verifyNever(
        () => facade.startTranscription(
          mediaId: any(named: 'mediaId'),
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
        ),
      );
    },
  );

  test('once the job request is on its way the file shows as starting and '
      '× no longer takes it off', () async {
    final answer = Completer<Either<Failure, UploadResult>>();
    when(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((call) {
      (call.namedArguments[#cancel] as UploadCancel?)!.seal();
      return answer.future;
    });
    final cubit = UploadQueueCubit(facade)..open([_file('a.mp3')]);
    final run = cubit.start(workspaceId: 'w1');
    await pumpEventQueue();
    expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.starting);
    expect(cubit.state.uploading, isFalse);

    cubit
      ..remove('/tmp/a.mp3')
      ..cancelAll();
    answer.complete(const Right(UploadResult(mediaId: 'm1', job: _job)));
    await run;
    expect(statusOf(cubit, 'a.mp3'), QueueItemStatus.started);
    await cubit.close();
  });
}
