import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/files_source.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';
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

  LibraryItem row(int i) => LibraryItem(mediaId: 'm$i', name: 'Fayl $i');
  List<LibraryItem> rows(int n) => List.generate(n, row);

  // Lets queued events and answered futures run.
  Future<void> pumpEvents() =>
      Future<void>.delayed(const Duration(milliseconds: 1));

  setUp(() {
    facade = _MockLibraryFacade();
    changes = LibraryChanges();
    when(() => facade.getTags(workspaceId: any(named: 'workspaceId')))
        .thenAnswer((_) async => const Right(<String>[]));
  });

  tearDown(() => changes.dispose());

  // The first page's request: only the filters a test sets differ.
  void stubPage(
    Either<Failure, LibraryPage> answer, {
    String? folderId,
    String? query,
    String? tag,
    int limit = LibraryBloc.pageSize,
    String? cursor,
  }) => when(
    () => facade.getItems(
      workspaceId: 'w1',
      folderId: folderId,
      query: query,
      tag: tag,
      limit: limit,
      cursor: cursor,
    ),
  ).thenAnswer((_) async => answer);

  group('LibraryBloc', () {
    blocTest<LibraryBloc, LibraryState>(
      'loads the first page of the workspace files',
      setUp: () => stubPage(
        const Right(LibraryPage(items: items, nextCursor: 'c2', total: 40)),
      ),
      build: () => LibraryBloc(facade, changes),
      act: (bloc) => bloc.add(const LibraryStarted('w1')),
      expect: () => const [
        LibraryState(status: LibraryStatus.loading, workspaceId: 'w1'),
        LibraryState(
          status: LibraryStatus.success,
          workspaceId: 'w1',
          items: items,
          nextCursor: 'c2',
          total: 40,
        ),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'an empty list is empty, not failure',
      setUp: () => stubPage(const Right(LibraryPage())),
      build: () => LibraryBloc(facade, changes),
      act: (bloc) => bloc.add(const LibraryStarted('w1')),
      expect: () => const [
        LibraryState(status: LibraryStatus.loading, workspaceId: 'w1'),
        LibraryState(status: LibraryStatus.empty, workspaceId: 'w1'),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'a failed refresh keeps the rows on screen',
      setUp: () => stubPage(const Left(Failure.network())),
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
      setUp: () => stubPage(const Right(LibraryPage(items: items))),
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

  group('LibraryBloc load more', () {
    final two = rows(2);
    LibraryState loaded({String? cursor = 'c2'}) => LibraryState(
      status: LibraryStatus.success,
      workspaceId: 'w1',
      items: two,
      nextCursor: cursor,
      total: 4,
    );

    blocTest<LibraryBloc, LibraryState>(
      'appends the next page and removes a row that came twice',
      setUp: () => stubPage(
        Right(LibraryPage(items: [row(1), row(2), row(3)], total: 4)),
        cursor: 'c2',
      ),
      build: () => LibraryBloc(facade, changes),
      seed: loaded,
      act: (bloc) => bloc.add(const LibraryMoreRequested()),
      expect: () => [
        loaded().copyWith(loadingMore: true),
        loaded().copyWith(
          items: [row(0), row(1), row(2), row(3)],
          nextCursor: null,
        ),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'without a cursor nothing is asked',
      build: () => LibraryBloc(facade, changes),
      seed: () => loaded(cursor: null),
      act: (bloc) => bloc.add(const LibraryMoreRequested()),
      expect: () => const <LibraryState>[],
      verify: (_) => verifyNoMoreInteractions(facade),
    );

    blocTest<LibraryBloc, LibraryState>(
      'a failure keeps the rows and the cursor, and the next try works',
      setUp: () {
        final answers = <Either<Failure, LibraryPage>>[
          const Left(Failure.network()),
          Right(LibraryPage(items: [row(2)], total: 3)),
        ];
        when(
          () => facade.getItems(
            workspaceId: 'w1',
            limit: LibraryBloc.pageSize,
            cursor: 'c2',
          ),
        ).thenAnswer((_) async => answers.removeAt(0));
      },
      build: () => LibraryBloc(facade, changes),
      seed: loaded,
      act: (bloc) async {
        bloc.add(const LibraryMoreRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const LibraryMoreRequested());
      },
      expect: () => [
        loaded().copyWith(loadingMore: true),
        loaded().copyWith(failure: const Failure.network()),
        loaded().copyWith(loadingMore: true),
        loaded().copyWith(
          items: [row(0), row(1), row(2)],
          nextCursor: null,
          total: 3,
        ),
      ],
    );

    test(
      'asked while a refresh runs, it does not cancel the refresh',
      () async {
        final answer = Completer<Either<Failure, LibraryPage>>();
        when(
          () => facade.getItems(workspaceId: 'w1', limit: LibraryBloc.pageSize),
        ).thenAnswer((_) => answer.future);
        final bloc = LibraryBloc(facade, changes)
          ..emit(loaded())
          ..add(const LibraryRefreshed());
        await pumpEvents();
        expect(bloc.state.refreshing, isTrue);

        bloc.add(const LibraryMoreRequested());
        await pumpEvents();
        answer.complete(Right(LibraryPage(items: rows(3), nextCursor: 'c9')));
        await pumpEvents();

        expect(bloc.state.refreshing, isFalse);
        expect(bloc.state.items, rows(3));
        expect(bloc.state.nextCursor, 'c9');
        verifyNever(
          () => facade.getItems(
            workspaceId: 'w1',
            limit: LibraryBloc.pageSize,
            cursor: 'c2',
          ),
        );
        await bloc.close();
      },
    );

    test('a second request while one runs is ignored', () async {
      final answer = Completer<Either<Failure, LibraryPage>>();
      when(
        () => facade.getItems(
          workspaceId: 'w1',
          limit: LibraryBloc.pageSize,
          cursor: 'c2',
        ),
      ).thenAnswer((_) => answer.future);
      final bloc = LibraryBloc(facade, changes)
        ..emit(loaded())
        ..add(const LibraryMoreRequested());
      await pumpEvents();
      bloc.add(const LibraryMoreRequested());
      await pumpEvents();
      answer.complete(const Right(LibraryPage()));
      await pumpEvents();
      verify(
        () => facade.getItems(
          workspaceId: 'w1',
          limit: LibraryBloc.pageSize,
          cursor: 'c2',
        ),
      ).called(1);
      expect(bloc.state.loadingMore, isFalse);
      await bloc.close();
    });

    test('a refresh during «more» wins, and clears its spinner', () async {
      final more = Completer<Either<Failure, LibraryPage>>();
      when(
        () => facade.getItems(
          workspaceId: 'w1',
          limit: LibraryBloc.pageSize,
          cursor: 'c2',
        ),
      ).thenAnswer((_) => more.future);
      stubPage(Right(LibraryPage(items: two, nextCursor: 'c2', total: 4)));
      final bloc = LibraryBloc(facade, changes)
        ..emit(loaded())
        ..add(const LibraryMoreRequested());
      await pumpEvents();
      expect(bloc.state.loadingMore, isTrue);
      bloc.add(const LibraryRefreshed());
      await pumpEvents();
      expect(bloc.state.loadingMore, isFalse);

      // The cancelled page arrives late and changes nothing.
      more.complete(Right(LibraryPage(items: [row(50)])));
      await pumpEvents();
      expect(bloc.state.items, two);
      expect(bloc.state.nextCursor, 'c2');
      await bloc.close();
    });
  });

  group('LibraryBloc refresh after scrolling', () {
    blocTest<LibraryBloc, LibraryState>(
      'asks for as many rows as are loaded',
      setUp: () => stubPage(
        Right(LibraryPage(items: rows(70), nextCursor: 'fresh', total: 90)),
        limit: 70,
      ),
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(70),
        nextCursor: 'old',
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      verify: (bloc) {
        expect(bloc.state.items, hasLength(70));
        expect(bloc.state.nextCursor, 'fresh');
        expect(bloc.state.total, 90);
      },
    );

    blocTest<LibraryBloc, LibraryState>(
      'a short list still asks for a whole page',
      setUp: () => stubPage(Right(LibraryPage(items: rows(2)))),
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(2),
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      verify: (_) => verify(
        () => facade.getItems(workspaceId: 'w1', limit: LibraryBloc.pageSize),
      ).called(1),
    );

    blocTest<LibraryBloc, LibraryState>(
      'past 100 rows it asks again page by page, so a deleted row goes',
      setUp: () {
        stubPage(
          Right(LibraryPage(items: rows(100), nextCursor: 'p2', total: 199)),
          limit: LibraryBloc.maxPageSize,
        );
        stubPage(
          Right(
            LibraryPage(
              items: [for (var i = 101; i < 131; i++) row(i)],
              nextCursor: 'after',
              total: 199,
            ),
          ),
          cursor: 'p2',
        );
      },
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(130),
        nextCursor: 'old',
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      verify: (bloc) {
        expect(bloc.state.items, hasLength(130));
        expect(bloc.state.items, isNot(contains(row(100))));
        expect(bloc.state.items.last, row(130));
        expect(bloc.state.nextCursor, 'after');
        expect(bloc.state.total, 199);
        expect(bloc.state.refreshing, isFalse);
      },
    );

    blocTest<LibraryBloc, LibraryState>(
      'past 100 rows, a shorter list ends the walk',
      setUp: () => stubPage(
        Right(LibraryPage(items: rows(60), total: 60)),
        limit: LibraryBloc.maxPageSize,
      ),
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(130),
        nextCursor: 'old',
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      verify: (bloc) {
        expect(bloc.state.items, rows(60));
        expect(bloc.state.nextCursor, isNull);
      },
    );

    blocTest<LibraryBloc, LibraryState>(
      'past 100 rows, a failed second request keeps every row and the cursor',
      setUp: () {
        stubPage(
          Right(LibraryPage(items: rows(100), nextCursor: 'p2')),
          limit: LibraryBloc.maxPageSize,
        );
        stubPage(const Left(Failure.network()), cursor: 'p2');
      },
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(130),
        nextCursor: 'old',
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      verify: (bloc) {
        expect(bloc.state.items, rows(130));
        expect(bloc.state.nextCursor, 'old');
        expect(bloc.state.failure, const Failure.network());
        expect(bloc.state.refreshing, isFalse);
      },
    );
  });

  // testWidgets for its fake clock: the refresh waits 15 seconds.
  group('LibraryBloc auto refresh', () {
    void autoRefreshTest(
      String name, {
      required LibraryPage page,
      required bool polls,
    }) => testWidgets(name, (tester) async {
      stubPage(Right(page));
      final bloc = LibraryBloc(facade, changes)
        ..add(const LibraryStarted('w1'));
      await tester.pump();
      await tester.pump(ApiConfig.jobPollMaxInterval);
      await tester.pump();
      verify(
        () => facade.getItems(workspaceId: 'w1', limit: LibraryBloc.pageSize),
      ).called(polls ? 2 : 1);
      unawaited(bloc.close());
      await tester.pump();
    });

    autoRefreshTest(
      'a job on an unloaded page keeps it polling',
      page: LibraryPage(items: rows(2), inFlight: 1),
      polls: true,
    );

    autoRefreshTest(
      'a stale running row does not, once the counts say none',
      page: const LibraryPage(
        items: [
          LibraryItem(mediaId: 'm', name: 'A', jobStatus: JobStatus.running),
        ],
        inFlight: 0,
      ),
      polls: false,
    );

    autoRefreshTest(
      'without counts the rows decide: running',
      page: const LibraryPage(
        items: [
          LibraryItem(mediaId: 'm', name: 'A', jobStatus: JobStatus.queued),
        ],
      ),
      polls: true,
    );

    autoRefreshTest(
      'without counts the rows decide: finished',
      page: const LibraryPage(items: items),
      polls: false,
    );
  });

  group('LibraryBloc folders', () {
    blocTest<LibraryBloc, LibraryState>(
      'a folder is a new list: rows blanked, tag dropped, folder_id sent',
      setUp: () => stubPage(const Right(LibraryPage()), folderId: 'f1'),
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(3),
        nextCursor: 'c2',
        tag: 'sud',
      ),
      act: (bloc) => bloc.add(const LibraryFolderSelected('f1')),
      expect: () => const [
        LibraryState(
          status: LibraryStatus.loading,
          workspaceId: 'w1',
          folderId: 'f1',
        ),
        LibraryState(
          status: LibraryStatus.empty,
          workspaceId: 'w1',
          folderId: 'f1',
        ),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'a refresh stays in the open folder',
      setUp: () => stubPage(Right(LibraryPage(items: rows(3))), folderId: 'f1'),
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        folderId: 'f1',
        items: rows(3),
      ),
      act: (bloc) => bloc.add(const LibraryRefreshed()),
      verify: (_) => verify(
        () => facade.getItems(
          workspaceId: 'w1',
          folderId: 'f1',
          limit: LibraryBloc.pageSize,
        ),
      ).called(1),
    );
  });

  group('LibraryBloc tag on the server', () {
    final shown = LibraryState(
      status: LibraryStatus.success,
      workspaceId: 'w1',
      items: rows(3),
      nextCursor: 'old',
      tags: const ['sud', 'majlis'],
    );

    setUp(
      () =>
          when(() => facade.getTags(workspaceId: 'w1'))
              .thenAnswer((_) async => const Right(['sud', 'majlis'])),
    );

    blocTest<LibraryBloc, LibraryState>(
      'reloads with the tag; the rows stay until the answer',
      setUp: () =>
          stubPage(Right(LibraryPage(items: [row(0)], total: 1)), tag: 'sud'),
      build: () => LibraryBloc(facade, changes),
      seed: () => shown,
      act: (bloc) => bloc.add(const LibraryTagSelected('sud')),
      expect: () => [
        shown.copyWith(tag: 'sud', refreshing: true, nextCursor: null),
        shown.copyWith(tag: 'sud', items: [row(0)], nextCursor: null, total: 1),
      ],
    );

    blocTest<LibraryBloc, LibraryState>(
      'the same tag again asks nothing',
      build: () => LibraryBloc(facade, changes),
      seed: () => shown.copyWith(tag: 'sud'),
      act: (bloc) => bloc.add(const LibraryTagSelected('sud')),
      expect: () => const <LibraryState>[],
      verify: (_) => verifyNoMoreInteractions(facade),
    );

    blocTest<LibraryBloc, LibraryState>(
      'no rows with a tag is no match, not an empty library',
      setUp: () => stubPage(const Right(LibraryPage()), tag: 'sud'),
      build: () => LibraryBloc(facade, changes),
      seed: () => shown,
      act: (bloc) => bloc.add(const LibraryTagSelected('sud')),
      verify: (bloc) {
        expect(bloc.state.status, LibraryStatus.success);
        expect(bloc.state.items, isEmpty);
      },
    );

    blocTest<LibraryBloc, LibraryState>(
      'a failed tag load keeps the rows but cannot continue them',
      setUp: () => stubPage(const Left(Failure.network()), tag: 'sud'),
      build: () => LibraryBloc(facade, changes),
      seed: () => shown,
      act: (bloc) => bloc.add(const LibraryTagSelected('sud')),
      verify: (bloc) {
        expect(bloc.state.items, rows(3));
        expect(bloc.state.nextCursor, isNull);
        expect(bloc.state.failure, const Failure.network());
      },
    );

    blocTest<LibraryBloc, LibraryState>(
      'past 100 rows, a retry after a failed filter asks from the top',
      setUp: () => stubPage(const Left(Failure.network()), tag: 'sud'),
      build: () => LibraryBloc(facade, changes),
      seed: () => shown.copyWith(items: rows(130)),
      act: (bloc) async {
        bloc.add(const LibraryTagSelected('sud'));
        await Future<void>.delayed(Duration.zero);
        stubPage(
          Right(LibraryPage(items: [row(0)], nextCursor: 'tagged')),
          tag: 'sud',
        );
        bloc.add(const LibraryRefreshed());
      },
      verify: (bloc) {
        expect(bloc.state.items, [row(0)]);
        expect(bloc.state.nextCursor, 'tagged');
      },
    );
  });

  // testWidgets for its fake clock: the debounce is a real wait otherwise.
  group('LibraryBloc search on the server', () {
    testWidgets('waits for the pause and asks once, for the last text', (
      tester,
    ) async {
      stubPage(Right(LibraryPage(items: [row(1)])), query: 'sud');
      final bloc = LibraryBloc(facade, changes)
        ..emit(
          LibraryState(
            status: LibraryStatus.success,
            workspaceId: 'w1',
            items: rows(3),
            nextCursor: 'old',
          ),
        )
        ..add(const LibraryQueryChanged('s'));
      await tester.pump(const Duration(milliseconds: 100));
      bloc.add(const LibraryQueryChanged('su'));
      await tester.pump(const Duration(milliseconds: 100));
      // After a restart restartable() holds the next event until its cancel
      // is done, which takes a real event-loop turn: the fake clock alone
      // never lets this one through. In real time it is a few milliseconds.
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      bloc.add(const LibraryQueryChanged(' sud '));
      await tester.pump();

      // The rows stay on screen and cannot be continued meanwhile.
      expect(bloc.state.items, rows(3));
      expect(bloc.state.refreshing, isTrue);
      expect(bloc.state.nextCursor, isNull);
      expect(bloc.state.query, 'sud');
      verifyNever(
        () => facade.getItems(
          workspaceId: any(named: 'workspaceId'),
          query: any(named: 'query'),
          limit: any(named: 'limit'),
        ),
      );

      await tester.pump(LibraryBloc.searchDebounce);
      await tester.pump();
      expect(bloc.state.items, [row(1)]);
      expect(bloc.state.refreshing, isFalse);
      verify(
        () => facade.getItems(
          workspaceId: 'w1',
          query: 'sud',
          limit: LibraryBloc.pageSize,
        ),
      ).called(1);
      verifyNoMoreInteractions(facade);
      unawaited(bloc.close());
      await tester.pump();
    });

    testWidgets('a late answer never overwrites the newer search', (
      tester,
    ) async {
      final slow = Completer<Either<Failure, LibraryPage>>();
      when(
        () => facade.getItems(
          workspaceId: 'w1',
          query: 'a',
          limit: LibraryBloc.pageSize,
        ),
      ).thenAnswer((_) => slow.future);
      stubPage(Right(LibraryPage(items: [row(2)])), query: 'ab');
      final bloc = LibraryBloc(facade, changes)
        ..emit(
          LibraryState(
            status: LibraryStatus.success,
            workspaceId: 'w1',
            items: rows(1),
          ),
        )
        ..add(const LibraryQueryChanged('a'));
      await tester.pump();
      await tester.pump(LibraryBloc.searchDebounce);
      await tester.pump();
      bloc.add(const LibraryQueryChanged('ab'));
      await tester.pump();
      await tester.pump(LibraryBloc.searchDebounce);
      await tester.pump();
      slow.complete(Right(LibraryPage(items: [row(9)])));
      await tester.pump();
      expect(bloc.state.items, [row(2)]);
      unawaited(bloc.close());
      await tester.pump();
    });

    blocTest<LibraryBloc, LibraryState>(
      'the same text again, as a tab switch sends it, does nothing',
      build: () => LibraryBloc(facade, changes),
      seed: () => LibraryState(
        status: LibraryStatus.success,
        workspaceId: 'w1',
        items: rows(1),
        query: 'sud',
      ),
      act: (bloc) => bloc
        ..add(const LibraryQueryChanged('sud'))
        ..add(const LibraryQueryChanged('  sud ')),
      expect: () => const <LibraryState>[],
      verify: (_) => verifyNoMoreInteractions(facade),
    );

    test(
      "a tab switch with the same text does not cancel the tab's load",
      () async {
        final answer = Completer<Either<Failure, LibraryPage>>();
        when(
          () => facade.getItems(
            workspaceId: 'w1',
            source: MediaSource.url,
            query: 'sud',
            limit: LibraryBloc.pageSize,
          ),
        ).thenAnswer((_) => answer.future);
        final bloc = LibraryBloc(facade, changes)
          ..emit(
            LibraryState(
              status: LibraryStatus.success,
              workspaceId: 'w1',
              items: rows(1),
              query: 'sud',
            ),
          )
          ..add(const LibrarySourceSelected(FilesSource.links))
          ..add(const LibraryQueryChanged('sud'));
        await pumpEvents();
        answer.complete(Right(LibraryPage(items: [row(5)])));
        await pumpEvents();
        expect(bloc.state.items, [row(5)]);
        await bloc.close();
      },
    );

    testWidgets('a text longer than the server allows is cut, not sent whole', (
      tester,
    ) async {
      final allowed = 'a' * FileRules.maxName;
      stubPage(const Right(LibraryPage()), query: allowed);
      final bloc = LibraryBloc(facade, changes)
        ..emit(const LibraryState(workspaceId: 'w1'))
        ..add(LibraryQueryChanged('${allowed}bbb'));
      await tester.pump();
      await tester.pump(LibraryBloc.searchDebounce);
      await tester.pump();
      expect(bloc.state.query, allowed);
      verify(
        () => facade.getItems(
          workspaceId: 'w1',
          query: allowed,
          limit: LibraryBloc.pageSize,
        ),
      ).called(1);
      unawaited(bloc.close());
      await tester.pump();
    });
  });

  group('LibraryBloc tag list', () {
    test('comes with the first load and with a refresh', () async {
      stubPage(const Right(LibraryPage()));
      when(() => facade.getTags(workspaceId: 'w1'))
          .thenAnswer((_) async => const Right(['sud', 'majlis']));
      final bloc = LibraryBloc(facade, changes)
        ..add(const LibraryStarted('w1'));
      await pumpEvents();
      expect(bloc.state.tags, ['sud', 'majlis']);

      when(() => facade.getTags(workspaceId: 'w1'))
          .thenAnswer((_) async => const Right(['yangi']));
      bloc.add(const LibraryRefreshed());
      await pumpEvents();
      expect(bloc.state.tags, ['yangi']);
      await bloc.close();
    });

    test('a failure keeps the old list and does not touch the page', () async {
      when(() => facade.getTags(workspaceId: 'w1'))
          .thenAnswer((_) async => const Left(Failure.network()));
      final bloc = LibraryBloc(facade, changes)
        ..emit(
          const LibraryState(
            status: LibraryStatus.success,
            workspaceId: 'w1',
            tags: ['sud'],
            tag: 'sud',
          ),
        );
      stubPage(Right(LibraryPage(items: rows(2))), tag: 'sud');
      bloc.add(const LibraryRefreshed());
      await pumpEvents();
      expect(bloc.state.tags, ['sud']);
      expect(bloc.state.tag, 'sud');
      expect(bloc.state.failure, isNull);
      expect(bloc.state.status, LibraryStatus.success);
      await bloc.close();
    });

    test('a selected tag gone from the list is cleared and reloaded', () async {
      stubPage(Right(LibraryPage(items: rows(1))), tag: 'sud');
      stubPage(Right(LibraryPage(items: rows(5))));
      when(() => facade.getTags(workspaceId: 'w1'))
          .thenAnswer((_) async => const Right(['majlis']));
      final bloc = LibraryBloc(facade, changes)
        ..emit(
          LibraryState(
            status: LibraryStatus.success,
            workspaceId: 'w1',
            items: rows(1),
            tags: const ['sud', 'majlis'],
            tag: 'sud',
          ),
        )
        ..add(const LibraryRefreshed());
      await pumpEvents();
      expect(bloc.state.tag, isNull);
      expect(bloc.state.tags, ['majlis']);
      expect(bloc.state.items, rows(5));
      await bloc.close();
    });
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
      expect(item.folderId, isNull);
    });

    test('reads folder_id', () {
      final item = LibraryItemModel.fromJson(const {
        'media_id': 'm1',
        'folder_id': 'f1',
      }).toEntity();
      expect(item.folderId, 'f1');
    });
  });
}
