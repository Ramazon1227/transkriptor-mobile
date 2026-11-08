import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
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

  group('a VIEWER (E-11)', () {
    final viewer = meetingTranscript(role: WorkspaceRole.viewer);

    testWidgets('no summary yet: no template chip, no create button', (
      tester,
    ) async {
      await tester.pumpWidget(_host(SummaryTab(transcript: viewer)));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('summary_empty')), findsOneWidget);
      expect(find.byKey(const Key('summary_create')), findsNothing);
      expect(find.byKey(const Key('summary_template_chip')), findsNothing);
    });

    testWidgets('a summary: copy and Notes, no rewrite or delete', (
      tester,
    ) async {
      when(() => facade.load(any())).thenAnswer(
        (_) async => const Right((
          summary: Summary(
            id: 's1',
            templateName: 'Asosiy xulosa',
            body: {'type': 'doc'},
            blocks: [
              NoteBlock(kind: NoteBlockKind.heading, text: 'Mazmuni', level: 2),
            ],
          ),
          sample: false,
        )),
      );
      await tester.pumpWidget(_host(SummaryTab(transcript: viewer)));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('summary_copy')), findsOneWidget);
      expect(find.byKey(const Key('summary_save_note')), findsOneWidget);
      expect(find.byKey(const Key('summary_regenerate')), findsNothing);
      expect(find.byKey(const Key('summary_delete')), findsNothing);
    });

    testWidgets('a failed poll re-reads on retry, never writes', (
      tester,
    ) async {
      // A MEMBER's summary is still being written; the viewer's poll gets
      // a 403 (not transient). «Qayta urinish» must read, not POST.
      when(() => facade.load(any())).thenAnswer(
        (_) async => const Right((
          summary: Summary(id: 's1', progress: SummaryProgress.pending),
          sample: false,
        )),
      );
      when(() => facade.refresh(any()))
          .thenAnswer((_) async => const Left(Failure.server(statusCode: 403)));
      await tester.pumpWidget(_host(SummaryTab(transcript: viewer)));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(minutes: 5));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('summary_failure')), findsOneWidget);
      await tester.tap(find.byKey(const Key('summary_retry')));
      await tester.pumpAndSettle();
      verify(() => facade.load(any())).called(2);
      verifyNever(
        () => facade.generate(any(), template: any(named: 'template')),
      );
      // Unmount: the reloaded PENDING summary schedules another poll.
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('a FAILED server summary: the sentence, no retry', (
      tester,
    ) async {
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
      await tester.pumpWidget(_host(SummaryTab(transcript: viewer)));
      await tester.pumpAndSettle();
      expect(find.text('Model hozir javob bermadi.'), findsOneWidget);
      expect(find.byKey(const Key('summary_retry')), findsNothing);
    });
  });
}
