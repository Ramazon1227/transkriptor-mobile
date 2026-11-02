import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/speed_sheet.dart';

import '../../../helpers/editor_fakes.dart';

const _labels = [
  '0,25×',
  '0,5×',
  '0,75×',
  '1×',
  '1,25×',
  '1,5×',
  '1,75×',
  '2×',
];

void main() {
  for (final (width, scale) in [(320.0, 1.0), (320.0, 2.0), (393.0, 1.3)]) {
    testWidgets('all eight speeds fit at ${width}px × text $scale', (
      tester,
    ) async {
      tester.view
        ..physicalSize = Size(width, 700)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final cubit = PlayerCubit(FakePlayerFacade(), FakeEngineFactory());
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(width, 700),
              textScaler: TextScaler.linear(scale),
            ),
            child: Scaffold(
              body: BlocProvider.value(value: cubit, child: const SpeedSheet()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      for (final label in _labels) {
        expect(find.text(label), findsOneWidget);
      }
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('0,25×'));
      await tester.pump();
      expect(cubit.state.speed, 0.25);

      await tester.pumpWidget(const SizedBox.shrink());
      await cubit.close();
    });
  }
}
