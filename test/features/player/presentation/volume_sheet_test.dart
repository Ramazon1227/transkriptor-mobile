import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/volume_sheet.dart';

import '../../../helpers/editor_fakes.dart';

void main() {
  for (final (width, scale) in [(320.0, 1.0), (320.0, 2.0)]) {
    testWidgets('mute and level fit at ${width}px × text $scale', (
      tester,
    ) async {
      tester.view
        ..physicalSize = Size(width, 700)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final facade = FakePlayerFacade();
      final cubit = PlayerCubit(facade, FakeEngineFactory());
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
              body: BlocProvider.value(
                value: cubit,
                child: const VolumeSheet(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('100%'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byKey(const Key('volume_mute')));
      await tester.pump();
      expect(cubit.state.muted, isTrue);
      expect(find.text('0%'), findsOneWidget);
      expect(find.byIcon(Icons.volume_off_rounded), findsOneWidget);
      expect(facade.savedLevel, (volume: 1.0, muted: true));

      await tester.pumpWidget(const SizedBox.shrink());
      await cubit.close();
    });
  }
}
