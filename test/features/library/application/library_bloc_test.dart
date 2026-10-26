import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/infrastructure/models/library_item_model.dart';

class _MockLibraryFacade extends Mock implements ILibraryFacade;

void main() {
  late _MockLibraryFacade facade;
  late LibraryChanges changes;

  const items = [
    LibraryItem(
      mediaId: 'm1',
      name: 'Kengash yigʻilishi',
      jobStatus: JobStatus.succeeded,
      transcriptId: 't1',
    ),
  ];

  setUp(() {
    facade = _MockLibraryFacade();
    changes = LibraryChanges();
  });

  tearDown(() => changes.dispose());

  group('LibraryBloc', () {
    blocTest<LibraryBloc, LibraryState>(
      'loads the workspace files',
      setUp: () =>
          when(() => facade.getItems(workspaceId: 'w1'))
              .thenAnswer((_) async => const Right(items)),
      build: () => LibraryBloc(facade, changes),
      act: (bloc) => bloc.add(const LibraryStarted('w1')),
      expect: () => const [
        LibraryState(status: LibraryStatus.loading, workspaceId: 'w1'),
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          items: items,
        ),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'an empty list is empty, not failure',
      setUp: () =>
          when(() => facade.getItems(workspaceId: any(named: 'workspaceId')))
              .thenAnswer((_) async => const Right(<LibraryItem>[])),
      build: () => LibraryBloc(facade, changes),
      act: (bloc) => bloc.add(const LibraryStarted('w1')),
      expect: () => const [
        LibraryState(status: LibraryStatus.loading, workspaceId: 'w1'),
        LibraryState(status: LibraryStatus.empty, workspaceId: 'w1'),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'a failed refresh keeps the rows on screen',
      setUp: () =>
          when(() => facade.getItems(workspaceId: any(named: 'workspaceId')))
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => LibraryBloc(facade, changes),
      seed: () => const LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: items,
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      expect: () => const [
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          items: items,
          refreshing: true,
        ),
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          items: items,
          failure: Failure.network(),
        ),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'reloads when the library changes elsewhere',
      setUp: () =>
          when(() => facade.getItems(workspaceId: 'w1'))
              .thenAnswer((_) async => const Right(items)),
      build: () => LibraryBloc(facade, changes),
      seed: () => const LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: items,
      ),
      act: (_) => changes.notify(),
      expect: () => const [
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          items: items,
          refreshing: true,
        ),
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          items: items,
        ),
      ],
    );
  });

  group('LibraryItemModel', () {
    test('reads blanks as null and an unknown status as unknown', () {
      final item = LibraryItemModel.fromJson(const {
        'media_id': 'm1',
        'name': 'Fayl',
        'created_at': '2026-10-12T14:32:00Z',
        'duration_ms': 278000,
        'kind': 'VIDEO',
        'source': 'URL',
        'link_provider': 'YOUTUBE',
        'job_id': '',
        'job_status': 'PAUSED',
        'transcript_id': '',
        'tags': ['majlis'],
      }).toEntity();

      expect(item.kind, MediaKind.video);
      expect(item.source, MediaSource.url);
      expect(item.duration, const Duration(minutes: 4, seconds: 38));
      expect(item.jobId, isNull);
      expect(item.transcriptId, isNull);
      expect(item.jobStatus, JobStatus.unknown);
    });

    test('a file with no job has no status', () {
      final item = LibraryItemModel.fromJson(const {
        'media_id': 'm1',
        'job_status': '',
        'kind': 'SOMETHING',
      }).toEntity();
      expect(item.jobStatus, isNull);
      expect(item.kind, MediaKind.unknown);
    });
  });
}
