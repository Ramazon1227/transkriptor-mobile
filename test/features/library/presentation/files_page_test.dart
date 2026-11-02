import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/presentation/pages/files_page.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/files_empty_view.dart';
import 'package:transkriptor_uz/features/notes/application/notes_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';

class _MockLibraryFacade extends Mock implements ILibraryFacade;

class _MockJobFacade extends Mock implements IJobFacade;

class _MockNotesFacade extends Mock implements INotesFacade;

class _Account extends MockCubit<AccountState> implements AccountCubit;

const _failed = LibraryItem(
  mediaId: 'm1',
  name: 'Sud majlisi',
  jobId: 'j1',
  jobStatus: JobStatus.failed,
);
const _running = LibraryItem(
  mediaId: 'm2',
  name: 'Kengash',
  jobId: 'j2',
  jobStatus: JobStatus.running,
);
const _done = LibraryItem(
  mediaId: 'm3',
  name: 'Matbuot anjumani',
  jobId: 'j3',
  jobStatus: JobStatus.succeeded,
  transcriptId: 't3',
);

List<LibraryItem> _rows(int count, {int from = 0}) => [
  for (var i = from; i < from + count; i++)
    LibraryItem(mediaId: 'r$i', name: 'Fayl $i'),
];

AccountState _account(WorkspaceRole role) => AccountState(
  status: AccountStatus.success,
  account: Account(
    user: const AppUser(id: 'u', email: 'e@misol.uz'),
    workspaces: [Workspace(id: 'w1', name: 'Shaxsiy', role: role)],
  ),
);

void main() {
  late _MockLibraryFacade library;
  late _MockJobFacade jobs;
  late _MockNotesFacade notes;
  late LibraryChanges changes;
  late _Account account;

  setUpAll(() => registerFallbackValue(MediaSource.unknown));

  setUp(() {
    library = _MockLibraryFacade();
    jobs = _MockJobFacade();
    notes = _MockNotesFacade();
    changes = LibraryChanges();
    account = _Account();
    when(() => account.state).thenReturn(_account(WorkspaceRole.owner));
    when(() => library.getFolders(workspaceId: 'w1'))
        .thenAnswer((_) async => const Right([]));
    when(
      () => library.getItems(
        workspaceId: 'w1',
        folderId: any(named: 'folderId'),
        source: any(named: 'source'),
        meeting: any(named: 'meeting'),
        query: any(named: 'query'),
        tag: any(named: 'tag'),
        limit: any(named: 'limit'),
        cursor: any(named: 'cursor'),
      ),
    ).thenAnswer(
      (_) async => const Right(LibraryPage(items: [_failed, _running, _done])),
    );
    when(() => library.getTags(workspaceId: 'w1'))
        .thenAnswer((_) async => const Right(<String>[]));
    when(() => notes.list(workspaceId: 'w1')).thenAnswer(
      (_) async => const Right(
        NotesPage(
          items: [NoteSummary(id: 'n1', title: 'Qaror', excerpt: 'matn')],
        ),
      ),
    );
    getIt
      ..registerFactory(() => LibraryBloc(library, changes))
      ..registerFactory(() => FoldersCubit(library, changes))
      ..registerFactory(() => NotesCubit(notes))
      ..registerFactory(() => FileActionsCubit(library, jobs, changes));
  });

  tearDown(() async {
    await getIt.reset();
    await changes.dispose();
  });

  // The running row's spinner never settles; a few frames are enough for
  // sheets to open and close.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
  }

  Future<void> pump(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/files',
      routes: [
        GoRoute(path: '/files', builder: (_, _) => const FilesPage()),
        GoRoute(
          path: '/job/:id',
          builder: (_, s) => Text('job ${s.pathParameters['id']}'),
        ),
      ],
    );
    await tester.pumpWidget(
      BlocProvider<AccountCubit>.value(
        value: account,
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets('rows carry the failed and running markers', (tester) async {
    await pump(tester);
    expect(find.text('Sud majlisi'), findsOneWidget);
    expect(find.text('Bajarilmadi'), findsOneWidget);
    expect(find.text('Ishlanmoqda'), findsOneWidget);
  });

  testWidgets('tabs: a source asks the server; notes show the notes', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.byKey(const Key('files_tab_links')));
    await tester.pump();
    verify(
      () => library.getItems(
        workspaceId: 'w1',
        source: MediaSource.url,
        limit: LibraryBloc.pageSize,
      ),
    ).called(1);

    await tester.dragUntilVisible(
      find.byKey(const Key('files_tab_notes')),
      find.byKey(const Key('files_tab_all')),
      const Offset(-200, 0),
    );
    await tester.tap(find.byKey(const Key('files_tab_notes')));
    await tester.pump();
    await tester.pump();
    expect(find.text('Qaror'), findsOneWidget);
    expect(find.text('Sud majlisi'), findsNothing);
  });

  // A page of [count] plain rows; [cursor] says more follow.
  void stubFirstPage(int count, {String? cursor, int from = 0}) =>
      when(
        () => library.getItems(
          workspaceId: 'w1',
          folderId: any(named: 'folderId'),
          source: any(named: 'source'),
          meeting: any(named: 'meeting'),
          query: any(named: 'query'),
          tag: any(named: 'tag'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer(
        (_) async => Right(
          LibraryPage(
            items: _rows(count, from: from),
            nextCursor: cursor,
          ),
        ),
      );

  void stubNextPage(
    String cursor,
    Future<Either<Failure, LibraryPage>> Function() answer,
  ) => when(
    () => library.getItems(
      workspaceId: 'w1',
      limit: LibraryBloc.pageSize,
      cursor: cursor,
    ),
  ).thenAnswer((_) => answer());

  testWidgets('search asks the server after a pause', (tester) async {
    await pump(tester);
    await tester.tap(find.byKey(const Key('files_search')));
    await tester.pump();
    when(
      () => library.getItems(
        workspaceId: 'w1',
        query: 'sud',
        limit: LibraryBloc.pageSize,
      ),
    ).thenAnswer((_) async => const Right(LibraryPage(items: [_failed])));
    await tester.enterText(find.byKey(const Key('files_search_field')), 'sud');
    await tester.pump();
    // The old rows stay until the answer.
    expect(find.text('Kengash'), findsOneWidget);

    await tester.pump(LibraryBloc.searchDebounce);
    await tester.pump();
    expect(find.text('Sud majlisi'), findsOneWidget);
    expect(find.text('Kengash'), findsNothing);
  });

  testWidgets('a search without a match is «no match», not an empty library', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.byKey(const Key('files_search')));
    await tester.pump();
    when(
      () => library.getItems(
        workspaceId: 'w1',
        query: 'yoq',
        limit: LibraryBloc.pageSize,
      ),
    ).thenAnswer((_) async => const Right(LibraryPage()));
    await tester.enterText(find.byKey(const Key('files_search_field')), 'yoq');
    await tester.pump(LibraryBloc.searchDebounce);
    await tester.pump();
    expect(find.byType(FilesNoMatchView), findsOneWidget);
    expect(find.byType(FilesEmptyView), findsNothing);
  });

  testWidgets('the tag bar lists the workspace tags and asks the server', (
    tester,
  ) async {
    when(() => library.getTags(workspaceId: 'w1'))
        .thenAnswer((_) async => const Right(['sud', 'majlis']));
    await pump(tester);
    expect(find.byKey(const Key('tag_all')), findsOneWidget);
    expect(find.byKey(const Key('tag_majlis')), findsOneWidget);

    when(
      () => library.getItems(
        workspaceId: 'w1',
        tag: 'sud',
        limit: LibraryBloc.pageSize,
      ),
    ).thenAnswer((_) async => const Right(LibraryPage(items: [_done])));
    await tester.tap(find.byKey(const Key('tag_sud')));
    await tester.pump();
    await tester.pump();
    expect(find.text('Matbuot anjumani'), findsOneWidget);
    expect(find.text('Kengash'), findsNothing);
    // A tag with few rows does not shrink the bar to itself.
    expect(find.byKey(const Key('tag_majlis')), findsOneWidget);
  });

  testWidgets('scrolling near the end loads the next page, once', (
    tester,
  ) async {
    final next = Completer<Either<Failure, LibraryPage>>();
    var asked = 0;
    stubFirstPage(LibraryBloc.pageSize, cursor: 'c2');
    stubNextPage('c2', () {
      asked++;
      return next.future;
    });
    await pump(tester);
    // A full page fills the screen: nothing is asked before a scroll.
    expect(asked, 0);

    await tester.drag(
      find.byKey(const Key('files_list')),
      const Offset(0, -6000),
    );
    await tester.pump();
    await tester.pump();
    expect(asked, 1);
    await tester.pump();
    expect(find.byKey(const Key('files_more_spinner')), findsOneWidget);

    await tester.drag(
      find.byKey(const Key('files_list')),
      const Offset(0, -500),
    );
    await tester.pump();
    await tester.pump();
    expect(asked, 1);

    next.complete(
      Right(LibraryPage(items: _rows(1, from: LibraryBloc.pageSize))),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byKey(const Key('files_more_spinner')), findsNothing);
    await tester.drag(
      find.byKey(const Key('files_list')),
      const Offset(0, -500),
    );
    await tester.pump();
    expect(find.text('Fayl ${LibraryBloc.pageSize}'), findsOneWidget);
  });

  testWidgets('a page too short for the screen still asks for the next', (
    tester,
  ) async {
    stubFirstPage(2, cursor: 'c2');
    stubNextPage(
      'c2',
      () async => Right(LibraryPage(items: _rows(2, from: 2))),
    );
    await pump(tester);
    await tester.pump();
    await tester.pump();
    expect(find.text('Fayl 3'), findsOneWidget);
    verify(
      () => library.getItems(
        workspaceId: 'w1',
        limit: LibraryBloc.pageSize,
        cursor: 'c2',
      ),
    ).called(1);
  });

  testWidgets(
    'a failed next page keeps the rows and does not retry by itself',
    (tester) async {
      var asked = 0;
      stubFirstPage(2, cursor: 'c2');
      stubNextPage('c2', () async {
        asked++;
        return const Left(Failure.network());
      });
      await pump(tester);
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
      expect(asked, 1);
      expect(find.text('Fayl 1'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);

      // The next scroll tries again.
      await tester.drag(
        find.byKey(const Key('files_list')),
        const Offset(0, -50),
      );
      await tester.pump();
      await tester.pump();
      expect(asked, 2);
    },
  );

  testWidgets('a VIEWER gets no «…»', (tester) async {
    when(() => account.state).thenReturn(_account(WorkspaceRole.viewer));
    await pump(tester);
    expect(find.byKey(const Key('file_more_m1')), findsNothing);
  });

  testWidgets('the sheet offers retranscribe only once the job is over', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.byKey(const Key('file_more_m2')));
    await settle(tester);
    expect(find.byKey(const Key('file_rename')), findsOneWidget);
    expect(find.byKey(const Key('file_retranscribe')), findsNothing);
    expect(find.byKey(const Key('file_share')), findsNothing);
    await tester.tapAt(const Offset(10, 10));
    await settle(tester);

    await tester.tap(find.byKey(const Key('file_more_m3')));
    await settle(tester);
    expect(find.byKey(const Key('file_retranscribe')), findsOneWidget);
    expect(find.byKey(const Key('file_share')), findsOneWidget);
  });

  testWidgets('retranscribe confirms in the sheet, then opens the job', (
    tester,
  ) async {
    when(() => jobs.getJob('j1')).thenAnswer(
      (_) async =>
          const Right(Job(id: 'j1', status: JobStatus.failed, numSpeakers: 4)),
    );
    when(() => jobs.createJob(mediaId: 'm1', numSpeakers: 4)).thenAnswer(
      (_) async => const Right(Job(id: 'j9', status: JobStatus.queued)),
    );
    await pump(tester);
    await tester.tap(find.byKey(const Key('file_more_m1')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('file_retranscribe')));
    await settle(tester);
    // Nothing is spent before the confirmation.
    verifyNever(
      () => jobs.createJob(
        mediaId: any(named: 'mediaId'),
        numSpeakers: any(named: 'numSpeakers'),
      ),
    );
    await tester.tap(find.byKey(const Key('file_retranscribe_confirm')));
    await settle(tester);
    expect(find.text('job j9'), findsOneWidget);
  });

  testWidgets('delete confirms in the sheet and deletes', (tester) async {
    when(() => library.deleteMedia('m1'))
        .thenAnswer((_) async => const Right(unit));
    await pump(tester);
    await tester.tap(find.byKey(const Key('file_more_m1')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('file_delete')));
    await settle(tester);
    expect(find.textContaining('«Sud majlisi»'), findsOneWidget);
    await tester.tap(find.byKey(const Key('file_delete_confirm')));
    await settle(tester);
    verify(() => library.deleteMedia('m1')).called(1);
    expect(find.byKey(const Key('file_delete_confirm')), findsNothing);
  });
}
