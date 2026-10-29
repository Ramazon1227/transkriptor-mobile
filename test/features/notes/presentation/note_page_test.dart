import 'package:dartz/dartz.dart' show Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/notes/application/note_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/notes/presentation/pages/note_page.dart';

class _MockNotesFacade extends Mock implements INotesFacade;

const _note = Note(
  id: 'n1',
  title: 'Qarorlar',
  revision: 1,
  origin: NoteOrigin(transcriptId: 't1', title: 'Majlis', available: true),
  blocks: [
    NoteBlock(kind: NoteBlockKind.heading, text: 'Kun tartibi', level: 2),
    NoteBlock(kind: NoteBlockKind.listItem, text: 'Byudjet', marker: '1.'),
  ],
);

void main() {
  late _MockNotesFacade facade;
  bool? popped;

  setUp(() {
    facade = _MockNotesFacade();
    popped = null;
    when(() => facade.get('n1')).thenAnswer((_) async => const Right(_note));
    getIt.registerFactory(() => NoteCubit(facade));
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, _) => TextButton(
            onPressed: () async =>
                popped = await context.push<bool>('/notes/n1'),
            child: const Text('open'),
          ),
        ),
        GoRoute(
          path: '/notes/:id',
          builder: (_, s) => NotePage(noteId: s.pathParameters['id']!),
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows the structure and where it came from', (tester) async {
    await pump(tester);
    expect(find.text('Qarorlar'), findsWidgets);
    expect(find.text('Kun tartibi'), findsOneWidget);
    expect(find.text('1.'), findsOneWidget);
    expect(find.text('Transkriptdan: Majlis'), findsOneWidget);
  });

  testWidgets('delete confirms in a sheet and returns true to the list', (
    tester,
  ) async {
    when(() => facade.delete('n1')).thenAnswer((_) async => const Right(unit));
    await pump(tester);
    await tester.tap(find.byKey(const Key('note_more')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('note_delete')));
    await tester.pumpAndSettle();
    expect(find.textContaining('«Qarorlar»'), findsOneWidget);
    await tester.tap(find.byKey(const Key('note_delete_confirm')));
    await tester.pumpAndSettle();
    verify(() => facade.delete('n1')).called(1);
    expect(find.text('open'), findsOneWidget);
    expect(popped, isTrue);
  });

  testWidgets('after a rename, back still tells the list', (tester) async {
    when(() => facade.rename(id: 'n1', title: 'Yangi', revision: 1)).thenAnswer(
      (_) async => const Right(Note(id: 'n1', title: 'Yangi', revision: 2)),
    );
    await pump(tester);
    await tester.tap(find.byKey(const Key('note_more')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('note_rename')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('note_title')), 'Yangi');
    await tester.tap(find.byKey(const Key('note_rename_save')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('note_title')), findsNothing);
    expect(find.text('Yangi'), findsOneWidget);
    // System back: the page's PopScope answers it with `true`.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(popped, isTrue);
  });
}
