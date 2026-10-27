import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/share/application/share_cubit.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';
import 'package:transkriptor_uz/features/share/domain/i_share_facade.dart';
import 'package:transkriptor_uz/features/share/presentation/widgets/share_sheet.dart';

class _MockShareFacade extends Mock implements IShareFacade;

void main() {
  late _MockShareFacade facade;

  setUp(() {
    facade = _MockShareFacade();
    when(() => facade.listLinks('t1')).thenAnswer((_) async => const Right([]));
    when(
      () => facade.createLink(
        transcriptId: 't1',
        includeMedia: true,
        expiresDays: 30,
      ),
    ).thenAnswer(
      (_) async => const Right(
        ShareLink(id: 'l1', includeMedia: true, url: 'https://app.test/s/tok'),
      ),
    );
    getIt.registerFactory(() => ShareCubit(facade));
  });
  tearDown(getIt.reset);

  testWidgets('open a link with the defaults and copy it', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ShareSheet(transcriptId: 't1')),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('share_create')));
    await tester.pumpAndSettle();
    expect(find.text('https://app.test/s/tok'), findsOneWidget);

    await tester.tap(find.byKey(const Key('share_copy')));
    await tester.pumpAndSettle();
    expect(copied, 'https://app.test/s/tok');
    expect(find.text('Nusxalandi'), findsOneWidget);
  });
}
