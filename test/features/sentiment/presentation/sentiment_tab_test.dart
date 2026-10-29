import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_cubit.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_poll_policy.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/presentation/widgets/sentiment_tab.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

import '../../../helpers/sentiment_fakes.dart';

void main() {
  late FakeSentimentFacade facade;

  setUp(() => facade = FakeSentimentFacade());

  // The cubit is closed inside the test body, never in addTearDown: a
  // tear-down runs outside the widget test's fake-async zone, and closing
  // a cubit whose stream still has the BlocBuilder listening waits on a
  // microtask that zone no longer runs — the whole file hung on it.
  Future<SentimentCubit> pump(WidgetTester tester) async {
    final cubit = SentimentCubit(
      facade,
      SentimentPollPolicy.custom(interval: const Duration(seconds: 3)),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: const SentimentTab(
              speakers: [Speaker(id: 's1', label: 'Dilnoza', ordinal: 1)],
            ),
          ),
        ),
      ),
    );
    await cubit.load('t1');
    await tester.pump();
    return cubit;
  }

  /// Unmounts the tab, then closes the cubit (cancelling a poll timer).
  Future<void> dispose(WidgetTester tester, SentimentCubit cubit) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await cubit.close();
  }

  testWidgets('not requested: explanation and the start button', (
    tester,
  ) async {
    final cubit = await pump(tester);
    expect(find.byKey(const Key('sentiment_intro')), findsOneWidget);
    facade.analyzes.add(const Right(pendingAnalysis));
    facade.fallback = const Right(pendingAnalysis);
    await tester.tap(find.text('Kayfiyatni tahlil qilish'));
    await tester.pump();
    expect(facade.analyzeCalls, 1);
    expect(find.byKey(const Key('sentiment_pending')), findsOneWidget);
    expect(find.text('Tahlil ketmoqda…'), findsOneWidget);
    await dispose(tester, cubit);
  });

  testWidgets('403 says who may start it', (tester) async {
    final cubit = await pump(tester);
    facade.analyzes.add(const Left(Failure.server(statusCode: 403)));
    await tester.tap(find.byKey(const Key('sentiment_start')));
    await tester.pump();
    expect(
      find.text('Tahlilni faqat tahrirlash huquqi bor aʼzolar boshlay oladi.'),
      findsOneWidget,
    );
    await dispose(tester, cubit);
  });

  testWidgets('503 shows the server sentence', (tester) async {
    final cubit = await pump(tester);
    facade.analyzes.add(
      const Left(
        Failure.server(statusCode: 503, message: 'kayfiyat tahlili yoqilmagan'),
      ),
    );
    await tester.tap(find.byKey(const Key('sentiment_start')));
    await tester.pump();
    expect(find.text('Kayfiyat tahlili yoqilmagan'), findsOneWidget);
    await dispose(tester, cubit);
  });

  testWidgets('DONE: note, overall, speakers, outdated, unlabeled, re-run', (
    tester,
  ) async {
    facade.answer(Right(doneAnalysis.copyWith(outdated: true, unlabeled: 2)));
    final cubit = await pump(tester);
    expect(find.byKey(const Key('sentiment_outdated')), findsOneWidget);
    expect(find.byKey(const Key('sentiment_note')), findsOneWidget);
    expect(find.text('Ball: −0.13'), findsOneWidget);
    expect(find.text('Ijobiy 25%'), findsOneWidget);
    expect(find.text('Salbiy 38%'), findsOneWidget);
    expect(find.byKey(const Key('sentiment_speaker_s1')), findsOneWidget);
    expect(find.text('Dilnoza'), findsOneWidget);
    expect(find.text('Maʼruzachisiz qismlar'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('sentiment_rerun')),
      100,
    );
    expect(find.byKey(const Key('sentiment_unlabeled')), findsOneWidget);
    expect(find.text('Qayta tahlil qilish'), findsOneWidget);
    await dispose(tester, cubit);
  });

  testWidgets('FAILED: the server sentence and a retry', (tester) async {
    facade.answer(
      const Right(
        SentimentAnalysis(
          status: SentimentStatus.failed,
          error: 'Tahlil tugamadi — qayta urinib koʻring.',
        ),
      ),
    );
    final cubit = await pump(tester);
    expect(find.byKey(const Key('sentiment_failed')), findsOneWidget);
    expect(
      find.text('Tahlil tugamadi — qayta urinib koʻring.'),
      findsOneWidget,
    );
    facade.analyzes.add(const Right(pendingAnalysis));
    facade.fallback = const Right(pendingAnalysis);
    await tester.tap(find.byKey(const Key('sentiment_retry')));
    await tester.pump();
    expect(facade.analyzeCalls, 1);
    await dispose(tester, cubit);
  });

  test('score format', () {
    expect(formatSentimentScore(.5), '+0.50');
    expect(formatSentimentScore(-.125), '−0.13');
    expect(formatSentimentScore(0), '0.00');
    expect(formatSentimentScore(-0.001), '0.00');
  });
}
