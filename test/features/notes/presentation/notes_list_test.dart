import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/notes/application/notes_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/notes_list.dart';

class _MockNotesFacade extends Mock implements INotesFacade;

void main() {
  // MB-8: with no network the last row's rebuild must not ask again and
  // again; only a new scroll does.
  testWidgets('a failed next page is asked once, then on the next scroll', (
    tester,
  ) async {
    final facade = _MockNotesFacade();
    var asked = 0;
    when(() => facade.list(workspaceId: 'w1')).thenAnswer(
      (_) async => const Right(
        NotesPage(
          items: [
            NoteSummary(id: 'n1', title: 'Majlis'),
            NoteSummary(id: 'n2', title: 'Kengash'),
          ],
          nextCursor: 'c',
        ),
      ),
    );
    when(() => facade.list(workspaceId: 'w1', cursor: 'c'))
        .thenAnswer((_) async {
          asked++;
          return const Left(Failure.network());
        });
    final cubit = NotesCubit(facade);
    await cubit.load('w1');

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider.value(value: cubit, child: const NotesList()),
        ),
      ),
    );
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
    expect(asked, 1);
    expect(find.text('Majlis'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -50));
    await tester.pump();
    await tester.pump();
    expect(asked, 2);

    await tester.pumpWidget(const SizedBox.shrink());
    await cubit.close();
  });
}
