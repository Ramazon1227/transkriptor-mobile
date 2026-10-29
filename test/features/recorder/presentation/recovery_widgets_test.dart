import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/recorder/application/recovery_cubit.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/presentation/widgets/recovery_widgets.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

class _Recovery extends MockCubit<RecoveryState> implements RecoveryCubit;

class _FakeItem extends Fake implements RecoverableRecording;

final _interrupted = RecoverableRecording(
  path: '/a.aac',
  kind: RecordingKind.microphone,
  state: RecordingCompletion.interrupted,
  createdAt: DateTime(2026, 10, 28, 18, 40),
  sizeBytes: 2 * 1024 * 1024,
  duration: const Duration(minutes: 3, seconds: 12),
);

final _finished = RecoverableRecording(
  path: '/b.m4a',
  kind: RecordingKind.screen,
  state: RecordingCompletion.finished,
  createdAt: DateTime(2026, 10, 1, 9, 5),
  sizeBytes: 1024 * 1024,
);

const _file = PendingFile(
  path: '/a.m4a',
  fileName: 'Yozuv.m4a',
  sizeBytes: 1,
  source: UploadSource.recording,
);

void main() {
  late _Recovery cubit;
  final l10n = AppLocalizationsUz();

  setUpAll(() => registerFallbackValue(_FakeItem()));

  setUp(() {
    cubit = _Recovery();
    when(() => cubit.recover(any(), title: any(named: 'title')))
        .thenAnswer((_) async {});
    when(() => cubit.discard(any())).thenAnswer((_) async {});
  });

  Widget app(Widget child) => MaterialApp(
    theme: AppTheme.dark(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: BlocProvider<RecoveryCubit>.value(value: cubit, child: child),
    ),
  );

  group('summary text', () {
    final now = DateTime(2026, 10, 29, 12);

    test('one recording: length and when', () {
      expect(
        recoverySummary(l10n, [_interrupted], now),
        'Yuborilmagan yozuv bor — 3:12, kecha 18:40',
      );
    });

    test('several: a count', () {
      expect(
        recoverySummary(l10n, [_interrupted, _finished], now),
        'Yuborilmagan yozuvlar: 2 ta',
      );
    });

    test('today, older, and long durations', () {
      expect(
        recoveryWhen(l10n, DateTime(2026, 10, 29, 8, 1), now),
        'bugun 08:01',
      );
      expect(
        recoveryWhen(l10n, DateTime(2026, 10, 1, 9, 5), now),
        '01.10.2026 09:05',
      );
      expect(shortDuration(const Duration(hours: 1, seconds: 7)), '1:00:07');
    });
  });

  testWidgets('the banner is hidden when nothing waits', (tester) async {
    when(() => cubit.state)
        .thenReturn(const RecoveryState(status: RecoveryStatus.empty));
    await tester.pumpWidget(app(RecoveryBanner(onRecovered: (_) {})));
    expect(find.byType(InkWell), findsNothing);
  });

  testWidgets('banner → sheet: interrupted is marked; delete asks in the row', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(
      RecoveryState(
        status: RecoveryStatus.success,
        items: [_interrupted, _finished],
      ),
    );
    await tester.pumpWidget(app(RecoveryBanner(onRecovered: (_) {})));
    await tester.tap(find.text('Yuborilmagan yozuvlar: 2 ta'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.recoverySheetTitle), findsOneWidget);
    expect(find.text(l10n.recoveryInterrupted), findsOneWidget);
    expect(find.text(l10n.recoveryUnknownLength), findsOneWidget);

    await tester.tap(find.text(l10n.recoveryDelete).first);
    await tester.pump();
    expect(find.text(l10n.recoveryDeleteAsk), findsOneWidget);
    verifyNever(() => cubit.discard(any()));

    await tester.tap(find.text(l10n.recoveryDeleteYes));
    await tester.pump();
    verify(() => cubit.discard(_interrupted)).called(1);
  });

  testWidgets('send recovers, and the sheet hands the file back', (
    tester,
  ) async {
    final states = StreamController<RecoveryState>();
    addTearDown(states.close);
    final initial = RecoveryState(
      status: RecoveryStatus.success,
      items: [_interrupted],
    );
    whenListen(cubit, states.stream, initialState: initial);

    PendingFile? got;
    await tester.pumpWidget(app(RecoveryCard(onRecovered: (f) => got = f)));
    await tester.tap(find.text(l10n.recoveryOpen));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.recoverySend));
    await tester.pump();
    verify(() => cubit.recover(_interrupted, title: any(named: 'title')))
        .called(1);

    // What the real cubit emits on success, in one go: emptied, then
    // recovered. The sheet must not close empty-handed in between.
    const done = RecoveryState(status: RecoveryStatus.empty, recovered: _file);
    when(() => cubit.state).thenReturn(done);
    when(() => cubit.consumed()).thenReturn(null);
    states
      ..add(const RecoveryState(status: RecoveryStatus.empty))
      ..add(done);
    await tester.pumpAndSettle();

    expect(got, _file);
    verify(() => cubit.consumed()).called(1);
    expect(find.text(l10n.recoverySend), findsNothing);
  });
}
