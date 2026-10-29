import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
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

  Future<void> pumpSheet(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ExportSheet(transcript: _transcript)),
      ),
    );
  }

  Future<void> next(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key('export_next')));
    await tester.pumpAndSettle();
  }

  testWidgets('style comes first, then the format, then the share', (
    tester,
  ) async {
    await pumpSheet(tester);
    expect(find.text('Matn tuzilishi'.toUpperCase()), findsOneWidget);
    expect(find.text('Vaqt belgilari'), findsOneWidget);
    expect(find.text('Maʼruzachi nomlari'), findsOneWidget);
    expect(find.text("Oddiy apostrof (o'zbek, ta'lim)"), findsOneWidget);
    expect(find.byKey(const Key('export_share')), findsNothing);

    await next(tester);
    for (final ext in ['docx', 'pdf', 'txt', 'srt', 'vtt', 'csv']) {
      expect(find.byKey(Key('export_$ext')), findsOneWidget);
    }
    // Subtitles and CSV say the style does not shape them.
    expect(
      find.text('Vaqt boʻyicha boʻlinadi — uslub qoʻllanmaydi.'),
      findsNWidgets(2),
    );
    expect(find.byKey(const Key('export_share')), findsOneWidget);

    await tester.tap(find.byKey(const Key('export_csv')));
    await tester.pumpAndSettle();
    final cubit = BlocProvider.of<ExportCubit>(
      tester.element(find.byKey(const Key('export_csv'))),
    );
    expect(cubit.state.format, ExportFormat.csv);

    await tester.tap(find.byKey(const Key('export_back')));
    await tester.pumpAndSettle();
    expect(find.text('Vaqt belgilari'), findsOneWidget);
  });

  testWidgets('paragraphs ask for sentences; single disables times and names', (
    tester,
  ) async {
    await pumpSheet(tester);
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
  });
}
