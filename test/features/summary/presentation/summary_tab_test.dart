import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/domain/i_summary_facade.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/demo/demo_summary_repository.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/summary_tab.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

import '../../../helpers/transcripts.dart';

class _MockFacade extends Mock implements ISummaryFacade;

Widget _host(Widget child) => MaterialApp(
  theme: AppTheme.dark(),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Column(
      children: [
        const SizedBox(height: 150),
        SizedBox(height: 420, child: child),
      ],
    ),
  ),
);

void main() {
  late _MockFacade facade;
  final demo = DemoSummaryRepository.custom(delay: Duration.zero);

  setUpAll(() => registerFallbackValue(meetingTranscript()));

  setUp(() {
    facade = _MockFacade();
    when(facade.templates).thenAnswer(
      (_) async => const Right(
        SummaryTemplateLibrary(
          categories: [SummaryTemplateCategory(id: 'c1', name: 'Umumiy')],
          templates: [
            SummaryTemplate(
              id: 't1',
              name: 'Yigʻilish bayonnomasi',
              owner: SummaryTemplateOwner.system,
              categoryId: 'c1',
            ),
            SummaryTemplate(
              id: 't2',
              name: 'Maʼruza',
              owner: SummaryTemplateOwner.system,
              categoryId: 'c1',
            ),
          ],
        ),
      ),
    );
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer(
          (inv) async => Right(
            demo.build(
              inv.positionalArguments.first as Transcript,
              template: inv.namedArguments[#template] as SummaryTemplate?,
            ),
          ),
        );
    getIt.registerFactory(() => SummaryCubit(facade));
  });
  tearDown(getIt.reset);

  testWidgets('short transcript: explains instead of offering', (tester) async {
    await tester.pumpWidget(_host(SummaryTab(transcript: shortTranscript())));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('summary_too_short')), findsOneWidget);
    expect(find.byKey(const Key('summary_create')), findsNothing);
  });

  testWidgets('pick a template, create, see sections, delete in-sheet', (
    tester,
  ) async {
    await tester.pumpWidget(_host(SummaryTab(transcript: meetingTranscript())));
    await tester.pumpAndSettle();
    expect(find.textContaining('Namuna'), findsOneWidget);
    expect(find.text('Yigʻilish bayonnomasi'), findsOneWidget);

    await tester.tap(find.byKey(const Key('summary_template_chip')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('summary_template_t2')));
    await tester.pumpAndSettle();
    expect(find.text('Maʼruza'), findsOneWidget);

    await tester.tap(find.byKey(const Key('summary_create')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('summary_result')), findsOneWidget);
    expect(find.text('Asosiy fikrlar'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('summary_delete')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('summary_delete')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm_sheet_confirm')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('summary_empty')), findsOneWidget);
  });
}
