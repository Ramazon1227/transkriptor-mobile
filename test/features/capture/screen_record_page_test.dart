import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/capture/application/screen_capture_cubit.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/screen_record_page.dart';

class _Screen extends MockCubit<ScreenCaptureState>
    implements ScreenCaptureCubit;

void main() {
  late _Screen cubit;
  final l10n = AppLocalizationsUz();

  setUp(() {
    cubit = _Screen();
    when(() => cubit.init()).thenAnswer((_) async {});
    when(() => cubit.start(withMic: any(named: 'withMic')))
        .thenAnswer((_) async {});
    when(() => cubit.stop()).thenAnswer((_) async {});
    getIt.registerFactory<ScreenCaptureCubit>(() => cubit);
  });

  tearDown(() async => await getIt.reset());

  Future<void> pump(WidgetTester tester, ScreenCaptureState state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ScreenRecordPage(),
      ),
    );
    await tester.pump();
  }

  testWidgets('unsupported: explains, offers no start', (tester) async {
    await pump(tester, const ScreenCaptureState(supported: false));
    expect(find.text(l10n.screenUnsupportedTitle), findsOneWidget);
    expect(find.text(l10n.screenStart), findsNothing);
  });

  testWidgets('idle: says what is captured, starts with the mic switch', (
    tester,
  ) async {
    await pump(tester, const ScreenCaptureState(supported: true));
    expect(find.text(l10n.screenWhatNoCalls), findsOneWidget);
    expect(find.text(l10n.screenWhatBlocked), findsOneWidget);

    await tester.tap(find.text(l10n.screenWithMic));
    await tester.pump();
    await tester.ensureVisible(find.text(l10n.screenStart));
    await tester.tap(find.text(l10n.screenStart));
    verify(() => cubit.start(withMic: true)).called(1);
  });

  testWidgets('recording with silent playback warns, stop stops', (
    tester,
  ) async {
    await pump(
      tester,
      const ScreenCaptureState(
        supported: true,
        status: ScreenCaptureStatus.recording,
        playbackSilent: true,
        elapsed: Duration(minutes: 1, seconds: 5),
      ),
    );
    expect(find.text('00:01:05'), findsOneWidget);
    expect(find.text(l10n.screenSilentTitle), findsOneWidget);
    await tester.ensureVisible(find.text(l10n.recorderStop));
    await tester.tap(find.text(l10n.recorderStop));
    verify(() => cubit.stop()).called(1);
  });

  testWidgets('recording with sound: no warning', (tester) async {
    await pump(
      tester,
      const ScreenCaptureState(
        supported: true,
        status: ScreenCaptureStatus.recording,
      ),
    );
    expect(find.text(l10n.screenSilentTitle), findsNothing);
  });

  for (final c in [
    (const Failure.capture(CaptureError.consentDenied), 'screenHintConsent'),
    (const Failure.permissionDenied(), 'screenHintMic'),
    (const Failure.capture(CaptureError.busy), 'screenHintBusy'),
    (const Failure.capture(CaptureError.captureFailed), 'screenHintFailed'),
  ]) {
    testWidgets('failure ${c.$2}: its own message and hint', (tester) async {
      await pump(
        tester,
        ScreenCaptureState(
          supported: true,
          status: ScreenCaptureStatus.failure,
          failure: c.$1,
        ),
      );
      final hint = switch (c.$2) {
        'screenHintConsent' => l10n.screenHintConsent,
        'screenHintMic' => l10n.screenHintMic,
        'screenHintBusy' => l10n.screenHintBusy,
        _ => l10n.screenHintFailed,
      };
      expect(find.text(hint), findsOneWidget);
      await tester.scrollUntilVisible(find.text(l10n.retry), 200);
      expect(find.text(l10n.retry), findsOneWidget);
    });
  }
}
