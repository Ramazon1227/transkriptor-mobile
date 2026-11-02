import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/upload/application/upload_queue_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
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
        numSpeakers: any(named: 'numSpeakers'),
        onProgress: any(named: 'onProgress'),
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
    await cubit.start(workspaceId: 'w1', numSpeakers: 3);

    expect(sent, ['a.mp3', 'b.wav']);
    verify(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: 'w1',
        title: 'a',
        startTranscription: true,
        numSpeakers: 3,
        onProgress: any(named: 'onProgress'),
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
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
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
        numSpeakers: any(named: 'numSpeakers'),
        onProgress: any(named: 'onProgress'),
      ),
    ).thenAnswer(
      (_) async => const Right(
        UploadResult(
          mediaId: 'm1',
          startFailure: Failure.server(statusCode: 402),
        ),
      ),
    );
    when(() => facade.startTranscription(mediaId: 'm1', numSpeakers: 2))
        .thenAnswer((_) async => const Right(_job));

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
      ),
    );
    verify(() => facade.startTranscription(mediaId: 'm1', numSpeakers: 2))
        .called(1);
    await cubit.close();
  });

  test(
    'a file removed while it waited is skipped; the running one stays',
    () async {
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
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
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
      expect(cubit.state.items.map((i) => i.file.fileName), ['a.mp3']);
      await cubit.close();
    },
  );

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
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
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
}
