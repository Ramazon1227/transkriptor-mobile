import 'package:dartz/dartz.dart' show Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
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
            demo
                .build(
                  inv.positionalArguments.first as Transcript,
                  template: inv.namedArguments[#template] as SummaryTemplate?,
                )
                .copyWith(sample: true),
          ),
        );
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: null, sample: true)));
    when(() => facade.delete(any())).thenAnswer((_) async => const Right(unit));
    getIt.registerFactory(() => SummaryCubit(facade, JobPollPolicy()));
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

  testWidgets('a server summary: no banner, Tiptap body shown', (tester) async {
    when(() => facade.load(any())).thenAnswer(
      (_) async => const Right((
        summary: Summary(
          id: 's1',
          templateName: 'Asosiy xulosa',
          body: {'type': 'doc'},
          blocks: [
            NoteBlock(kind: NoteBlockKind.heading, text: 'Mazmuni', level: 2),
            NoteBlock(kind: NoteBlockKind.listItem, text: 'Smeta', marker: '•'),
          ],
        ),
        sample: false,
      )),
    );
    await tester.pumpWidget(_host(SummaryTab(transcript: meetingTranscript())));
    await tester.pumpAndSettle();
    expect(find.textContaining('Namuna'), findsNothing);
    expect(find.byKey(const Key('summary_result')), findsOneWidget);
    expect(find.text('Mazmuni'), findsOneWidget);
    expect(find.text('Smeta'), findsOneWidget);
    expect(find.byKey(const Key('summary_speakers_outdated')), findsNothing);
  });

  // XU-15: xulosadan keyin ma'ruzachi nomlari o'zgargan.
  testWidgets('renamed speakers: the summary says its names may be old', (
    tester,
  ) async {
    when(() => facade.load(any())).thenAnswer(
      (_) async => const Right((
        summary: Summary(
          id: 's1',
          templateName: 'Asosiy xulosa',
          body: {'type': 'doc'},
          speakersOutdated: true,
          blocks: [
            NoteBlock(kind: NoteBlockKind.paragraph, text: 'Ali gapirdi'),
          ],
        ),
        sample: false,
      )),
    );
    await tester.pumpWidget(_host(SummaryTab(transcript: meetingTranscript())));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('summary_speakers_outdated')), findsOneWidget);
    expect(find.textContaining('Maʼruzachi nomlari oʻzgargan'), findsOneWidget);
  });

  // XU-15 review: tab qayta ochilganda (visits) belgi yangilanadi.
  testWidgets('a revisit refreshes the names mark', (tester) async {
    const ready = Summary(
      id: 's1',
      templateName: 'Asosiy xulosa',
      body: {'type': 'doc'},
      blocks: [NoteBlock(kind: NoteBlockKind.paragraph, text: 'Ali gapirdi')],
    );
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: ready, sample: false)));
    when(() => facade.refresh(any()))
        .thenAnswer((_) async => Right(ready.copyWith(speakersOutdated: true)));
    final t = meetingTranscript();
    await tester.pumpWidget(_host(SummaryTab(transcript: t)));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('summary_speakers_outdated')), findsNothing);
    await tester.pumpWidget(_host(SummaryTab(transcript: t, visits: 1)));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('summary_speakers_outdated')), findsOneWidget);
  });

  testWidgets('a FAILED server summary shows its own sentence', (tester) async {
    when(() => facade.load(any())).thenAnswer(
      (_) async => const Right((
        summary: Summary(
          id: 's1',
          progress: SummaryProgress.failed,
          error: 'Model hozir javob bermadi.',
        ),
        sample: false,
      )),
    );
    await tester.pumpWidget(_host(SummaryTab(transcript: meetingTranscript())));
    await tester.pumpAndSettle();
    expect(find.text('Model hozir javob bermadi.'), findsOneWidget);
    expect(find.byKey(const Key('summary_retry')), findsOneWidget);
  });
}
