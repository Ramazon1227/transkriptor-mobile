import 'package:dartz/dartz.dart' show Left, Right;
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

const _segment = Segment(
  id: 'g1',
  start: Duration(seconds: 1),
  end: Duration(seconds: 3),
  text: 'birinchi gap',
  speakerId: 's1',
);

const _transcript = Transcript(
  id: 't1',
  title: 'Kengash',
  speakers: [
    Speaker(id: 's1', label: 'Dilnoza', ordinal: 1),
    Speaker(id: 's2', label: 'Sardor', ordinal: 2),
  ],
  segments: [_segment],
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

  Future<void> openMenu(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: TranscriptPage(transcriptId: 't1'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.longPress(find.text('birinchi gap'));
    await tester.pumpAndSettle();
  }

  testWidgets('long press moves the segment to another speaker', (
    tester,
  ) async {
    when(
      () => facade.assignSpeaker(
        transcriptId: 't1',
        segmentId: 'g1',
        speakerId: 's2',
        revision: 2,
      ),
    ).thenAnswer(
      (_) async => Right(
        SegmentEdit(segment: _segment.copyWith(speakerId: 's2'), revision: 3),
      ),
    );
    await openMenu(tester);
    expect(find.text('Yangi maʼruzachi'), findsOneWidget);

    await tester.tap(find.byKey(const Key('assign_s2')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('assign_s2')), findsNothing);
    // The row's chip now names Sardor.
    expect(find.text('Sardor'), findsOneWidget);
    expect(find.text('Dilnoza'), findsNothing);
  });

  testWidgets('a new speaker appears under its server name', (tester) async {
    when(
      () => facade.assignSpeaker(
        transcriptId: 't1',
        segmentId: 'g1',
        speakerId: null,
        revision: 2,
      ),
    ).thenAnswer(
      (_) async => Right(
        SegmentEdit(
          segment: _segment.copyWith(speakerId: 's3'),
          revision: 3,
          newSpeaker: const Speaker(
            id: 's3',
            label: 'Maʼruzachi 3',
            ordinal: 3,
          ),
        ),
      ),
    );
    await openMenu(tester);
    await tester.tap(find.byKey(const Key('assign_new')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('assign_new')), findsNothing);
    expect(find.text('Maʼruzachi 3'), findsOneWidget);
  });

  testWidgets('a 409 keeps the menu open and says so', (tester) async {
    when(
      () => facade.assignSpeaker(
        transcriptId: any(named: 'transcriptId'),
        segmentId: any(named: 'segmentId'),
        speakerId: any(named: 'speakerId'),
        revision: any(named: 'revision'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server(statusCode: 409)));
    await openMenu(tester);
    await tester.tap(find.byKey(const Key('assign_s2')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('assign_s2')), findsOneWidget);
    expect(
      find.textContaining('Transkript boshqa joyda oʻzgartirildi'),
      findsOneWidget,
    );
    verify(() => facade.getTranscript('t1')).called(2);
  });
}
