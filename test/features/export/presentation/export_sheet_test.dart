import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';
import 'package:transkriptor_uz/features/export/presentation/widgets/export_sheet.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

class _MockExportFacade extends Mock implements IExportFacade;

const _transcript = Transcript(
  id: 't1',
  title: 'Kengash',
  speakers: [Speaker(id: 'a', label: 'Ali', ordinal: 1)],
  segments: [
    Segment(
      id: 'g1',
      start: Duration.zero,
      end: Duration(seconds: 2),
      text: 'Salom.',
      speakerId: 'a',
    ),
  ],
);

void main() {
  setUp(() => getIt.registerFactory(() => ExportCubit(_MockExportFacade())));
  tearDown(getIt.reset);

  testWidgets('CSV is offered and hides the switches it ignores', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ExportSheet(transcript: _transcript)),
      ),
    );
    expect(find.text('Vaqt belgilari'), findsOneWidget);
    expect(find.text('Maʼruzachi nomlari'), findsOneWidget);

    await tester.tap(find.byKey(const Key('export_csv')));
    await tester.pumpAndSettle();

    expect(find.text('Vaqt belgilari'), findsNothing);
    expect(find.text('Maʼruzachi nomlari'), findsNothing);
    expect(find.text("Oddiy apostrof (o'zbek, ta'lim)"), findsOneWidget);
  });

  testWidgets('layouts are TXT-only; single disables times and names', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ExportSheet(transcript: _transcript)),
      ),
    );
    expect(find.text('Matn tuzilishi'), findsOneWidget);
    expect(find.text('Paragrafda gap'), findsNothing);

    await tester.tap(find.byKey(const Key('export_layout_paragraphs')));
    await tester.pumpAndSettle();
    expect(find.text('Paragrafda gap'), findsOneWidget);
    expect(find.text('2 ta gap'), findsOneWidget);

    await tester.tap(find.byKey(const Key('export_layout_single')));
    await tester.pumpAndSettle();
    expect(find.text('Paragrafda gap'), findsNothing);
    final switches = tester.widgetList<SwitchListTile>(
      find.byType(SwitchListTile),
    );
    expect(switches.where((s) => s.onChanged == null), hasLength(2));

    // DOCX and PDF are prose: the layout and the timecode switch stay.
    for (final key in ['export_docx', 'export_pdf']) {
      await tester.tap(find.byKey(Key(key)));
      await tester.pumpAndSettle();
      expect(find.text('Matn tuzilishi'), findsOneWidget);
      expect(find.text('Vaqt belgilari'), findsOneWidget);
    }

    await tester.tap(find.byKey(const Key('export_srt')));
    await tester.pumpAndSettle();
    expect(find.text('Matn tuzilishi'), findsNothing);
  });
}
