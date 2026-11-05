import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/application/job_cubit.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/application/upload_queue_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

class _MockUploadFacade extends Mock implements IUploadFacade;

class _MockJobFacade extends Mock implements IJobFacade;

class _MockLibraryFacade extends Mock implements ILibraryFacade;

class _FakePendingFile extends Fake implements PendingFile;

PendingFile _file(String name) => PendingFile(
  path: '/tmp/$name',
  fileName: name,
  sizeBytes: 10,
  source: UploadSource.upload,
);

const _job = Job(id: 'j1', mediaId: 'm1', status: JobStatus.queued);
const _shared = JobOptions(glossaryId: 'g1', terms: ['IT Park']);
const _hint = SpeakerHint(label: 'Sarvar', startMs: 0, endMs: 5000);

void main() {
  late _MockUploadFacade facade;

  setUpAll(() {
    registerFallbackValue(_FakePendingFile());
    registerFallbackValue(const JobOptions());
  });
  setUp(() => facade = _MockUploadFacade());

  void stubUpload() =>
      when(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          folderId: any(named: 'folderId'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
          options: any(named: 'options'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((call) async {
        final file = call.namedArguments[#file] as PendingFile;
        return Right(UploadResult(mediaId: 'm-${file.fileName}', job: _job));
      });

  group('UploadBloc', () {
    test(
      'a file goes to the chosen workspace and folder with its options',
      () async {
        stubUpload();
        final bloc = UploadBloc(facade)
          ..add(
            UploadFileSubmitted(
              file: _file('a.mp3'),
              workspaceId: 'w2',
              folderId: 'f1',
              title: 'a',
              startTranscription: true,
              numSpeakers: 2,
              options: _shared.copyWith(speakerHints: [_hint]),
            ),
          );
        await pumpEventQueue();
        verify(
          () => facade.upload(
            file: any(named: 'file'),
            workspaceId: 'w2',
            title: 'a',
            startTranscription: true,
            jobKey: any(named: 'jobKey'),
            folderId: 'f1',
            numSpeakers: 2,
            service: any(named: 'service'),
            options: _shared.copyWith(speakerHints: [_hint]),
            onProgress: any(named: 'onProgress'),
            cancel: any(named: 'cancel'),
          ),
        ).called(1);
        await bloc.close();
      },
    );

    test('a link resent after a lost answer keeps its key; other options '
        'are a new action with a new key', () async {
      final keys = <String>[];
      final answers = <Either<Failure, Job>>[
        const Left(Failure.timeout()),
        const Left(Failure.timeout()),
        const Right(_job),
      ];
      when(
        () => facade.startLink(
          url: any(named: 'url'),
          workspaceId: any(named: 'workspaceId'),
          idempotencyKey: any(named: 'idempotencyKey'),
          folderId: any(named: 'folderId'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((inv) async {
        keys.add(inv.namedArguments[#idempotencyKey] as String);
        return answers.removeAt(0);
      });
      final bloc = UploadBloc(facade);
      const url = 'https://youtu.be/x';
      bloc.add(
        const UploadLinkSubmitted(
          url: url,
          workspaceId: 'w1',
          options: _shared,
        ),
      );
      await pumpEventQueue();
      bloc.add(
        const UploadLinkSubmitted(
          url: url,
          workspaceId: 'w1',
          options: _shared,
        ),
      );
      await pumpEventQueue();
      bloc.add(
        const UploadLinkSubmitted(
          url: url,
          workspaceId: 'w1',
          options: JobOptions(terms: ['Boshqa']),
        ),
      );
      await pumpEventQueue();
      expect(keys, hasLength(3));
      expect(keys[1], keys[0]);
      expect(keys[2], isNot(keys[1]));
      verify(
        () => facade.startLink(
          url: url,
          workspaceId: 'w1',
          idempotencyKey: any(named: 'idempotencyKey'),
          folderId: any(named: 'folderId'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
          options: _shared,
        ),
      ).called(2);
      await bloc.close();
    });

    test('a start retried with other options gets a new key', () async {
      final keys = <String>[];
      when(
        () => facade.startTranscription(
          mediaId: 'm1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: any(named: 'numSpeakers'),
          service: any(named: 'service'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((inv) async {
        keys.add(inv.namedArguments[#idempotencyKey] as String);
        return const Left(Failure.network());
      });
      final bloc = UploadBloc(facade)
        ..add(const UploadStartRetried(mediaId: 'm1', options: _shared));
      await pumpEventQueue();
      bloc.add(const UploadStartRetried(mediaId: 'm1', options: _shared));
      await pumpEventQueue();
      bloc.add(const UploadStartRetried(mediaId: 'm1', numSpeakers: 3));
      await pumpEventQueue();
      expect(keys[1], keys[0]);
      expect(keys[2], isNot(keys[0]));
      await bloc.close();
    });
  });

  group('UploadQueueCubit', () {
    test('every file gets the shared options and only its own hints', () async {
      stubUpload();
      final cubit = UploadQueueCubit(facade)
        ..open([_file('a.mp3'), _file('b.wav')]);
      expect(cubit.state.destinationLocked, isFalse);
      await cubit.start(
        workspaceId: 'w2',
        folderId: 'f1',
        numSpeakers: 2,
        options: _shared,
        hints: const {
          '/tmp/a.mp3': [_hint],
        },
      );
      final calls = verify(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: 'w2',
          title: any(named: 'title'),
          startTranscription: true,
          jobKey: any(named: 'jobKey'),
          folderId: 'f1',
          numSpeakers: 2,
          service: any(named: 'service'),
          options: captureAny(named: 'options'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).captured;
      expect(calls, [
        _shared.copyWith(speakerHints: const [_hint]),
        _shared,
      ]);
      // The files are on the server: their destination stays.
      expect(cubit.state.destinationLocked, isTrue);
      await cubit.close();
    });
  });

  group('retries resend the previous job’s options', () {
    const previous = Job(
      id: 'j1',
      mediaId: 'm1',
      status: JobStatus.failed,
      numSpeakers: 2,
      glossaryId: 'g1',
      terms: ['IT Park'],
      speakerHints: [_hint],
    );
    final expected = previous.options;

    test('JobCubit.retry', () async {
      final jobs = _MockJobFacade();
      final changes = LibraryChanges();
      addTearDown(changes.dispose);
      when(
        () => jobs.createJob(
          mediaId: 'm1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: 2,
          options: expected,
        ),
      ).thenAnswer((_) async => const Left(Failure.jobActive()));
      final cubit =
          JobCubit(
            jobs,
            JobPollPolicy.custom(
              first: const Duration(milliseconds: 1),
              max: const Duration(milliseconds: 4),
            ),
            changes,
          )..emit(
            const JobState(
              status: JobViewStatus.success,
              jobId: 'j1',
              job: previous,
            ),
          );
      await cubit.retry();
      expect(cubit.state.failure, const Failure.jobActive());
      verify(
        () => jobs.createJob(
          mediaId: 'm1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: 2,
          options: expected,
        ),
      ).called(1);
      await cubit.close();
    });

    test('FileActionsCubit.retranscribe', () async {
      final jobs = _MockJobFacade();
      final changes = LibraryChanges();
      addTearDown(changes.dispose);
      when(() => jobs.getJob('j1'))
          .thenAnswer((_) async => const Right(previous));
      when(
        () => jobs.createJob(
          mediaId: 'm1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: 2,
          options: expected,
        ),
      ).thenAnswer(
        (_) async => const Right(Job(id: 'j2', status: JobStatus.queued)),
      );
      final cubit = FileActionsCubit(_MockLibraryFacade(), jobs, changes);
      await cubit.retranscribe(
        const LibraryItem(mediaId: 'm1', name: 'Majlis', jobId: 'j1'),
      );
      expect(cubit.state.jobId, 'j2');
      await cubit.close();
    });
  });
}
