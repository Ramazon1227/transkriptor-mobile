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
const _voice = LibraryItem(
  mediaId: 'm3',
  name: 'Ovozli eslatma',
  source: MediaSource.recording,
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
        when(() => jobs.createJob(mediaId: 'm1', numSpeakers: 2)).thenAnswer(
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
        when(() => jobs.createJob(mediaId: 'm1')).thenAnswer(
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
          () => jobs.createJob(mediaId: 'm1'),
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

  group('LibraryBloc source tabs and search', () {
    blocTest<LibraryBloc, LibraryState>(
      'Uchrashuvlar asks for RECORDING and keeps only meetings',
      setUp: () {
        when(() => library.getItems(workspaceId: 'w1'))
            .thenAnswer((_) async => const Right([_failed, _meeting, _voice]));
        when(
          () => library.getItems(
            workspaceId: 'w1',
            source: MediaSource.recording,
          ),
        ).thenAnswer((_) async => const Right([_meeting, _voice]));
      },
      build: () => LibraryBloc(library, changes),
      act: (b) async {
        b.add(const LibraryStarted('w1'));
        await Future<void>.delayed(Duration.zero);
        b
          ..add(const LibraryTagSelected('x'))
          ..add(const LibrarySourceSelected(FilesSource.meetings));
      },
      skip: 3,
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
      'Yozuvlar without recordings is empty, even if meetings came back',
      setUp: () => when(
        () =>
            library.getItems(workspaceId: 'w1', source: MediaSource.recording),
      ).thenAnswer((_) async => const Right([_meeting])),
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

    test('the search narrows by name, any case, with the tag', () {
      const state = LibraryState(items: [_failed, _meeting, _voice]);
      expect(state.copyWith(query: 'YIGʻ').visibleItems.map((i) => i.mediaId), [
        'm2',
      ]);
      expect(state.copyWith(query: '  ').visibleItems, hasLength(3));
    });

    test('the tab mapping', () {
      expect(FilesSource.links.serverSource, MediaSource.url);
      expect(FilesSource.all.serverSource, isNull);
      expect(FilesSource.uploads.matches(_meeting), isTrue);
    });
  });
}
