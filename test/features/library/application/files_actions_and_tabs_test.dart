import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/files_source.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';

class _MockLibraryFacade extends Mock implements ILibraryFacade;

class _MockJobFacade extends Mock implements IJobFacade;

const _failed = LibraryItem(
  mediaId: 'm1',
  name: 'Majlis',
  jobId: 'j1',
  jobStatus: JobStatus.failed,
);
const _meeting = LibraryItem(
  mediaId: 'm2',
  name: 'Haftalik yigʻilish',
  source: MediaSource.recording,
  meetingTitle: 'Haftalik yigʻilish',
);

void main() {
  late _MockLibraryFacade library;
  late _MockJobFacade jobs;
  late LibraryChanges changes;

  setUp(() {
    library = _MockLibraryFacade();
    jobs = _MockJobFacade();
    changes = LibraryChanges();
  });

  tearDown(() => changes.dispose());

  group('FileActionsCubit retranscribe', () {
    blocTest<FileActionsCubit, FileActionsState>(
      'reuses the previous speaker count and answers the new job',
      setUp: () {
        when(() => jobs.getJob('j1')).thenAnswer(
          (_) async => const Right(
            Job(id: 'j1', status: JobStatus.failed, numSpeakers: 2),
          ),
        );
        when(
          () => jobs.createJob(
            mediaId: 'm1',
            idempotencyKey: any(named: 'idempotencyKey'),
            numSpeakers: 2,
          ),
        ).thenAnswer(
          (_) async => const Right(Job(id: 'j2', status: JobStatus.queued)),
        );
      },
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) async {
        final notified = changes.stream.first;
        await c.retranscribe(_failed);
        await notified;
      },
      expect: () => const [
        FileActionsState(status: FileActionStatus.busy),
        FileActionsState(status: FileActionStatus.done, jobId: 'j2'),
      ],
    );

    blocTest<FileActionsCubit, FileActionsState>(
      'an unreadable previous job leaves the count to the server',
      setUp: () {
        when(
          () => jobs.getJob('j1'),
        ).thenAnswer((_) async => const Left(Failure.server(statusCode: 404)));
        when(
          () => jobs.createJob(
            mediaId: 'm1',
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenAnswer(
          (_) async => const Right(Job(id: 'j2', status: JobStatus.queued)),
        );
      },
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) => c.retranscribe(_failed),
      expect: () => const [
        FileActionsState(status: FileActionStatus.busy),
        FileActionsState(status: FileActionStatus.done, jobId: 'j2'),
      ],
    );

    blocTest<FileActionsCubit, FileActionsState>(
      'no balance (402) stays on the sheet',
      setUp: () {
        when(() => jobs.getJob('j1')).thenAnswer(
          (_) async => const Right(Job(id: 'j1', status: JobStatus.failed)),
        );
        when(
          () => jobs.createJob(
            mediaId: 'm1',
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenAnswer((_) async => const Left(Failure.server(statusCode: 402)));
      },
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) => c.retranscribe(_failed),
      expect: () => const [
        FileActionsState(status: FileActionStatus.busy),
        FileActionsState(
          status: FileActionStatus.failure,
          failure: Failure.server(statusCode: 402),
        ),
      ],
    );

    blocTest<FileActionsCubit, FileActionsState>(
      'a file with a running job (409 JOB_ACTIVE) stays on the sheet',
      setUp: () {
        when(() => jobs.getJob('j1')).thenAnswer(
          (_) async => const Right(Job(id: 'j1', status: JobStatus.failed)),
        );
        when(
          () => jobs.createJob(
            mediaId: 'm1',
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenAnswer((_) async => const Left(Failure.jobActive()));
      },
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) => c.retranscribe(_failed),
      expect: () => const [
        FileActionsState(status: FileActionStatus.busy),
        FileActionsState(
          status: FileActionStatus.failure,
          failure: Failure.jobActive(),
        ),
      ],
    );

    test('a retry after a lost answer repeats the key and the speaker '
        'count; a refusal ends the action', () async {
      final sent = <(String, int?)>[];
      final answers = [
        const Left<Failure, Job>(Failure.timeout()),
        const Left<Failure, Job>(Failure.server(statusCode: 402)),
        const Right<Failure, Job>(Job(id: 'j2', status: JobStatus.queued)),
      ];
      // The previous job is read once; a retry must not ask again, and an
      // answer that changed in between must not change the request.
      var reads = 0;
      when(() => jobs.getJob('j1')).thenAnswer((_) async {
        reads++;
        return Right(
          Job(id: 'j1', status: JobStatus.failed, numSpeakers: reads + 1),
        );
      });
      when(
        () => jobs.createJob(
          mediaId: 'm1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: any(named: 'numSpeakers'),
        ),
      ).thenAnswer((inv) async {
        sent.add((
          inv.namedArguments[#idempotencyKey] as String,
          inv.namedArguments[#numSpeakers] as int?,
        ));
        return answers.removeAt(0);
      });
      final cubit = FileActionsCubit(library, jobs, changes);

      await cubit.retranscribe(_failed);
      await cubit.retranscribe(_failed);
      await cubit.retranscribe(_failed);

      expect(sent[1], sent[0]);
      expect(sent[0].$2, 2);
      expect(sent[2].$1, isNot(sent[1].$1));
      expect(reads, 2);
      expect(cubit.state.jobId, 'j2');
      await cubit.close();
    });
  });

  group('FileActionsCubit rename and delete', () {
    blocTest<FileActionsCubit, FileActionsState>(
      'rename returns the row the server sent',
      setUp: () => when(() => library.rename(mediaId: 'm1', name: 'Yangi'))
          .thenAnswer(
            (_) async => const Right(LibraryItem(mediaId: 'm1', name: 'Yangi')),
          ),
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) => c.rename(_failed, 'Yangi'),
      expect: () => const [
        FileActionsState(status: FileActionStatus.busy),
        FileActionsState(
          status: FileActionStatus.done,
          item: LibraryItem(mediaId: 'm1', name: 'Yangi'),
        ),
      ],
    );

    blocTest<FileActionsCubit, FileActionsState>(
      'the same name sends nothing',
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) => c.rename(_failed, 'Majlis'),
      expect: () => const [
        FileActionsState(status: FileActionStatus.done, item: _failed),
      ],
      verify: (_) => verifyNever(
        () => library.rename(
          mediaId: any(named: 'mediaId'),
          name: any(named: 'name'),
        ),
      ),
    );

    blocTest<FileActionsCubit, FileActionsState>(
      'delete tells the library',
      setUp: () =>
          when(() => library.deleteMedia('m1'))
              .thenAnswer((_) async => const Right(unit)),
      build: () => FileActionsCubit(library, jobs, changes),
      act: (c) async {
        final notified = changes.stream.first;
        await c.delete(_failed);
        await notified;
      },
      expect: () => const [
        FileActionsState(status: FileActionStatus.busy),
        FileActionsState(status: FileActionStatus.done),
      ],
    );
  });

  group('LibraryBloc source tabs', () {
    setUp(
      () =>
          when(() => library.getTags(workspaceId: 'w1'))
              .thenAnswer((_) async => const Right(<String>[])),
    );

    blocTest<LibraryBloc, LibraryState>(
      'Uchrashuvlar asks for RECORDING with meeting=true',
      setUp: () {
        when(
          () =>
              library.getItems(workspaceId: 'w1', limit: LibraryBloc.pageSize),
        ).thenAnswer(
          (_) async => const Right(LibraryPage(items: [_failed, _meeting])),
        );
        when(
          () => library.getItems(
            workspaceId: 'w1',
            source: MediaSource.recording,
            meeting: true,
            limit: LibraryBloc.pageSize,
          ),
        ).thenAnswer((_) async => const Right(LibraryPage(items: [_meeting])));
      },
      build: () => LibraryBloc(library, changes),
      act: (b) async {
        b.add(const LibraryStarted('w1'));
        await Future<void>.delayed(Duration.zero);
        b.add(const LibrarySourceSelected(FilesSource.meetings));
      },
      skip: 2,
      expect: () => const [
        LibraryState(
          status: LibraryStatus.loading,
          workspaceId: 'w1',
          source: FilesSource.meetings,
        ),
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          source: FilesSource.meetings,
          items: [_meeting],
        ),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'Yozuvlar asks for meeting=false; no rows is empty',
      setUp: () => when(
        () => library.getItems(
          workspaceId: 'w1',
          source: MediaSource.recording,
          meeting: false,
          limit: LibraryBloc.pageSize,
        ),
      ).thenAnswer((_) async => const Right(LibraryPage())),
      build: () => LibraryBloc(library, changes),
      seed: () => const LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: [_failed],
      ),
      act: (b) => b.add(const LibrarySourceSelected(FilesSource.recordings)),
      skip: 1,
      expect: () => const [
        LibraryState(
          status: LibraryStatus.empty,
          workspaceId: 'w1',
          source: FilesSource.recordings,
        ),
      ],
    );

    test('the tab mapping', () {
      expect(FilesSource.links.serverSource, MediaSource.url);
      expect(FilesSource.all.serverSource, isNull);
      expect(FilesSource.meetings.serverSource, MediaSource.recording);
      expect(FilesSource.recordings.serverSource, MediaSource.recording);
      expect(FilesSource.meetings.meeting, isTrue);
      expect(FilesSource.recordings.meeting, isFalse);
      expect(FilesSource.all.meeting, isNull);
      expect(FilesSource.uploads.meeting, isNull);
    });
  });
}
