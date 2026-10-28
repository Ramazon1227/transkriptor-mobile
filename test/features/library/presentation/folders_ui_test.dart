import 'dart:async';

import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/file_actions_sheet.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/folder_bar.dart';

class _MockLibraryFacade extends Mock implements ILibraryFacade;

const _sud = Folder(id: 'f1', name: 'Sud', fileCount: 2);
const _item = LibraryItem(mediaId: 'm1', name: 'Majlis', tags: ['eski']);

void main() {
  late _MockLibraryFacade facade;
  late LibraryChanges changes;

  setUp(() {
    facade = _MockLibraryFacade();
    changes = LibraryChanges();
    when(() => facade.getFolders(workspaceId: 'w1'))
        .thenAnswer((_) async => const Right([_sud]));
    when(
      () => facade.getItems(
        workspaceId: 'w1',
        folderId: any(named: 'folderId'),
      ),
    ).thenAnswer((_) async => const Right([_item]));
    getIt.registerFactory(() => FileActionsCubit(facade, changes));
  });

  tearDown(() async {
    await getIt.reset();
    await changes.dispose();
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  LibraryBloc(facade, changes)..add(const LibraryStarted('w1')),
            ),
            BlocProvider(
              create: (_) {
                final folders = FoldersCubit(facade, changes);
                unawaited(folders.load('w1'));
                return folders;
              },
            ),
          ],
          child: Scaffold(body: child),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a folder tab opens that folder; «+ Papka» asks for a name', (
    tester,
  ) async {
    await pump(tester, const FolderBar());
    expect(find.text('Hammasi'), findsOneWidget);
    expect(find.text('Sud'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byKey(const Key('folder_f1')));
    await tester.pumpAndSettle();
    verify(() => facade.getItems(workspaceId: 'w1', folderId: 'f1')).called(1);

    await tester.tap(find.byKey(const Key('folder_new')));
    await tester.pumpAndSettle();
    expect(find.text('Yangi papka'), findsOneWidget);
    // An empty name is refused here, before any request.
    await tester.tap(find.byKey(const Key('folder_save')));
    await tester.pump();
    expect(find.textContaining('80 belgidan'), findsOneWidget);
    verifyNever(
      () => facade.createFolder(
        workspaceId: any(named: 'workspaceId'),
        name: any(named: 'name'),
      ),
    );
  });

  testWidgets('the tags sheet normalises, refuses a comma and saves the list', (
    tester,
  ) async {
    when(() => facade.setTags(mediaId: 'm1', tags: ['eski', 'sud ishlari']))
        .thenAnswer(
          (_) async => const Right(
            LibraryItem(
              mediaId: 'm1',
              name: 'Majlis',
              tags: ['eski', 'sud ishlari'],
            ),
          ),
        );
    await pump(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => FileActionsSheet.show(context, _item),
          child: const Text('open'),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('file_tags')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('tag_input')), 'a,b');
    await tester.tap(find.byKey(const Key('tag_add')));
    await tester.pump();
    expect(find.textContaining('vergul'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('tag_input')),
      '  Sud   Ishlari ',
    );
    await tester.tap(find.byKey(const Key('tag_add')));
    await tester.pump();
    expect(find.byKey(const Key('tag_chip_sud ishlari')), findsOneWidget);

    await tester.tap(find.byKey(const Key('tags_save')));
    await tester.pumpAndSettle();
    verify(() => facade.setTags(mediaId: 'm1', tags: ['eski', 'sud ishlari']))
        .called(1);
    // Saved: the sheet closed.
    expect(find.byKey(const Key('tags_save')), findsNothing);
  });

  testWidgets('the move sheet sends the chosen folder', (tester) async {
    when(() => facade.moveToFolder(mediaId: 'm1', folderId: 'f1')).thenAnswer(
      (_) async => const Right(
        LibraryItem(mediaId: 'm1', name: 'Majlis', folderId: 'f1'),
      ),
    );
    await pump(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => FileActionsSheet.show(context, _item),
          child: const Text('open'),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('file_move')));
    await tester.pumpAndSettle();
    expect(find.text('Papkasiz'), findsOneWidget);
    await tester.tap(find.byKey(const Key('move_f1')));
    await tester.pumpAndSettle();
    verify(() => facade.moveToFolder(mediaId: 'm1', folderId: 'f1')).called(1);
    expect(find.byKey(const Key('move_f1')), findsNothing);
  });
}
