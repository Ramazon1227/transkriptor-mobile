import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/presentation/pages/transcript_page.dart';

import '../../../helpers/editor_fakes.dart';

class _MockTranscriptFacade extends Mock implements ITranscriptFacade;

const _transcript = Transcript(
  id: 't1',
  title: 'Kengash',
  speakers: [Speaker(id: 's1', label: 'Maʼruzachi 1', ordinal: 1)],
  segments: [
    Segment(
      id: 'g1',
      start: Duration(seconds: 1),
      end: Duration(seconds: 3),
      text: 'eski matn',
      speakerId: 's1',
    ),
  ],
  revision: 2,
);

void main() {
  late _MockTranscriptFacade facade;

  setUp(() {
    facade = _MockTranscriptFacade();
    when(() => facade.getTranscript('t1'))
        .thenAnswer((_) async => const Right(_transcript));
  });

  // The page takes its cubit from DI, as in the app.
  setUp(() {
    getIt.registerFactory(() => TranscriptCubit(facade));
    registerEditorFakes();
  });
  tearDown(getIt.reset);

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: TranscriptPage(transcriptId: 't1'),
      ),
    );
    await tester.pumpAndSettle();
    await enterEditMode(tester);
  }

  testWidgets('a saved text closes the sheet and shows the stored text', (
    tester,
  ) async {
    when(
      () => facade.updateSegmentText(
        transcriptId: 't1',
        segmentId: 'g1',
        text: 'yangi matn',
        revision: 2,
      ),
    ).thenAnswer(
      (_) async => const Right(
        SegmentEdit(
          segment: Segment(
            id: 'g1',
            start: Duration(seconds: 1),
            end: Duration(seconds: 3),
            text: 'yangi matn',
            speakerId: 's1',
            edited: true,
          ),
          revision: 3,
        ),
      ),
    );
    await pumpPage(tester);

    await doubleTap(tester, find.text('eski matn'));
    await tester.enterText(find.byType(TextField), 'yangi matn');
    await tester.tap(find.text('Saqlash'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing);
    expect(find.text('yangi matn'), findsOneWidget);
    expect(find.text('tahrirlangan'), findsOneWidget);
  });

  testWidgets('a failed save keeps the sheet and the draft open', (
    tester,
  ) async {
    when(
      () => facade.updateSegmentText(
        transcriptId: any(named: 'transcriptId'),
        segmentId: any(named: 'segmentId'),
        text: any(named: 'text'),
        revision: any(named: 'revision'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server(statusCode: 403)));
    await pumpPage(tester);

    await doubleTap(tester, find.text('eski matn'));
    await tester.enterText(find.byType(TextField), 'mening tahririm');
    await tester.tap(find.text('Saqlash'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('mening tahririm'), findsOneWidget);
    expect(
      find.text('Bu ish maydonida faqat oʻqish huquqingiz bor.'),
      findsOneWidget,
    );
  });

  testWidgets('the sheet cannot be dismissed while a save runs', (
    tester,
  ) async {
    final answer = Completer<Either<Failure, SegmentEdit>>();
    when(
      () => facade.updateSegmentText(
        transcriptId: any(named: 'transcriptId'),
        segmentId: any(named: 'segmentId'),
        text: any(named: 'text'),
        revision: any(named: 'revision'),
      ),
    ).thenAnswer((_) => answer.future);
    await pumpPage(tester);

    await doubleTap(tester, find.text('eski matn'));
    await tester.enterText(find.byType(TextField), 'yangi matn');
    await tester.tap(find.text('Saqlash'));
    await tester.pump();
    // The modal barrier, above the sheet.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);

    answer.complete(const Left(Failure.network()));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('an unchanged text closes the sheet, twice in a row', (
    tester,
  ) async {
    await pumpPage(tester);
    for (var i = 0; i < 2; i++) {
      await doubleTap(tester, find.text('eski matn'));
      await tester.tap(find.text('Saqlash'));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsNothing);
    }
  });

  testWidgets('the speaker menu opens the rename sheet', (tester) async {
    when(
      () => facade.renameSpeaker(
        transcriptId: 't1',
        speakerId: 's1',
        label: 'Dilnoza',
      ),
    ).thenAnswer(
      (_) async => const Right(Speaker(id: 's1', label: 'Dilnoza', ordinal: 1)),
    );
    await pumpPage(tester);

    await tester.tap(find.byKey(const Key('speaker_chip_s1')));
    // Edit mode: the row also waits for a second tap.
    await tester.pump(kDoubleTapTimeout);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('rename_s1')));
    await tester.pumpAndSettle();
    expect(find.text('Maʼruzachi nomi'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Dilnoza');
    await tester.tap(find.text('Saqlash'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing);
    expect(find.text('Dilnoza'), findsOneWidget);
  });
}
