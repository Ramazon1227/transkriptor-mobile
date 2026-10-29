import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/presentation/pages/transcript_page.dart';

import '../../../helpers/editor_fakes.dart';

class _MockTranscriptFacade extends Mock implements ITranscriptFacade;

const _a = Segment(
  id: 'g1',
  start: Duration.zero,
  end: Duration(seconds: 4),
  text: 'Salom dunyo',
  speakerId: 's1',
);
const _b = Segment(
  id: 'g2',
  start: Duration(seconds: 4),
  end: Duration(seconds: 6),
  text: 'Xayr',
  speakerId: 's1',
);

const _transcript = Transcript(
  id: 't1',
  title: 'Kengash',
  speakers: [Speaker(id: 's1', label: 'Maʼruzachi 1', ordinal: 1)],
  segments: [_a, _b],
  revision: 2,
);

void main() {
  late _MockTranscriptFacade facade;

  setUp(() {
    facade = _MockTranscriptFacade();
    when(() => facade.getTranscript('t1'))
        .thenAnswer((_) async => const Right(_transcript));
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

  ButtonStyleButton button(WidgetTester tester, String key) =>
      tester.widget<ButtonStyleButton>(find.byKey(Key(key)));

  testWidgets('split at the cursor in the editor shows both parts', (
    tester,
  ) async {
    when(
      () => facade.splitSegment(
        transcriptId: 't1',
        segmentId: 'g1',
        at: 6,
        revision: 2,
      ),
    ).thenAnswer(
      (_) async => Right(
        SegmentSplit(
          first: _a.copyWith(text: 'Salom', edited: true),
          second: _a.copyWith(id: 'g3', text: 'dunyo', edited: true),
          revision: 3,
        ),
      ),
    );
    await pumpPage(tester);
    await doubleTap(tester, find.text('Salom dunyo'));

    final field = tester.widget<TextField>(find.byType(TextField));
    // At the end there is nothing to split off.
    field.controller!.selection = const TextSelection.collapsed(offset: 11);
    await tester.pump();
    expect(button(tester, 'segment_split').onPressed, isNull);

    field.controller!.selection = const TextSelection.collapsed(offset: 6);
    await tester.pump();
    await tester.tap(find.byKey(const Key('segment_split')));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing);
    expect(find.text('Salom'), findsOneWidget);
    expect(find.text('dunyo'), findsOneWidget);
    expect(find.text('Xayr'), findsOneWidget);
  });

  testWidgets('the last segment offers no merge, in the editor or menu', (
    tester,
  ) async {
    await pumpPage(tester);
    await doubleTap(tester, find.text('Xayr'));
    expect(find.byKey(const Key('segment_split')), findsOneWidget);
    expect(find.byKey(const Key('segment_merge_next')), findsNothing);
    await tester.tap(find.text('Bekor qilish'));
    await tester.pumpAndSettle();

    await tester.longPress(find.text('Xayr'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('merge_next')), findsNothing);
  });

  testWidgets('merge with the next from the long-press menu', (tester) async {
    when(
      () => facade.mergeNext(transcriptId: 't1', segmentId: 'g1', revision: 2),
    ).thenAnswer(
      (_) async => Right(
        SegmentMerge(
          segment: _a.copyWith(
            text: 'Salom dunyo Xayr',
            end: const Duration(seconds: 6),
            edited: true,
          ),
          removedId: 'g2',
          revision: 3,
        ),
      ),
    );
    await pumpPage(tester);
    await tester.longPress(find.text('Salom dunyo'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('merge_next')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('merge_next')), findsNothing);
    expect(find.text('Salom dunyo Xayr'), findsOneWidget);
    expect(find.text('Xayr'), findsNothing);
  });

  testWidgets('merge from the editor saves the changed draft first', (
    tester,
  ) async {
    when(
      () => facade.updateSegmentText(
        transcriptId: 't1',
        segmentId: 'g1',
        text: 'Salom olam',
        revision: 2,
      ),
    ).thenAnswer(
      (_) async => Right(
        SegmentEdit(segment: _a.copyWith(text: 'Salom olam'), revision: 3),
      ),
    );
    when(
      () => facade.mergeNext(transcriptId: 't1', segmentId: 'g1', revision: 3),
    ).thenAnswer(
      (_) async => Right(
        SegmentMerge(
          segment: _a.copyWith(text: 'Salom olam Xayr', edited: true),
          removedId: 'g2',
          revision: 4,
        ),
      ),
    );
    await pumpPage(tester);
    await doubleTap(tester, find.text('Salom dunyo'));
    await tester.enterText(find.byType(TextField), 'Salom olam');
    await tester.tap(find.byKey(const Key('segment_merge_next')));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing);
    expect(find.text('Salom olam Xayr'), findsOneWidget);
    verifyInOrder([
      () => facade.updateSegmentText(
        transcriptId: 't1',
        segmentId: 'g1',
        text: 'Salom olam',
        revision: 2,
      ),
      () => facade.mergeNext(transcriptId: 't1', segmentId: 'g1', revision: 3),
    ]);
  });
}
