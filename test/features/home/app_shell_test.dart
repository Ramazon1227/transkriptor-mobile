import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/app_shell.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/source_sheet.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';

class _Pick extends MockCubit<PickFileState> implements PickFileCubit;

final _l10n = AppLocalizationsUz();

Widget _app(GoRouter router) => MaterialApp.router(
  theme: AppTheme.dark(),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  routerConfig: router,
);

GoRouter _router() => GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: Routes.home, builder: (_, _) => const Text('STUDIO')),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: Routes.files, builder: (_, _) => const Text('FILES')),
          ],
        ),
      ],
    ),
    for (final path in [
      Routes.link,
      Routes.record,
      Routes.dictation,
      Routes.screenRecord,
      Routes.meeting,
      Routes.url,
    ])
      GoRoute(path: path, builder: (_, _) => Text('PAGE $path')),
  ],
);

void main() {
  late _Pick pick;

  setUp(() {
    pick = _Pick();
    when(() => pick.state).thenReturn(const PickFileState());
    when(() => pick.pick()).thenAnswer((_) async {});
    getIt.registerFactory<PickFileCubit>(() => pick);
  });

  tearDown(() async => await getIt.reset());

  testWidgets('two tabs and the plus; Files switches the tab', (t) async {
    await t.pumpWidget(_app(_router()));
    await t.pumpAndSettle();

    expect(find.text(_l10n.navStudio), findsOneWidget);
    expect(find.text(_l10n.navFiles), findsOneWidget);
    expect(find.bySemanticsLabel(_l10n.navNew), findsOneWidget);
    expect(find.text('STUDIO'), findsOneWidget);

    await t.tap(find.text(_l10n.navFiles));
    await t.pumpAndSettle();
    expect(find.text('FILES'), findsOneWidget);
  });

  testWidgets('plus opens the sources in the agreed order', (t) async {
    await t.pumpWidget(_app(_router()));
    await t.pumpAndSettle();

    await t.tap(find.bySemanticsLabel(_l10n.navNew));
    await t.pumpAndSettle();

    expect(find.text(_l10n.sourceSheetTitle), findsOneWidget);
    expect(find.text(_l10n.sourceRealtimeBadge), findsOneWidget);
    final titles = [
      _l10n.sourceUploadTitle,
      _l10n.sourceYoutubeTitle,
      _l10n.sourceRecordTitle,
      _l10n.sourceDictationTitle,
      _l10n.sourceScreenTitle,
      _l10n.sourceCloudTitle,
      _l10n.sourceMeetingTitle,
      _l10n.sourceUrlTitle,
    ];
    expect(SourceSheet.order, const [
      CaptureSource.upload,
      CaptureSource.youtube,
      CaptureSource.recording,
      CaptureSource.dictation,
      CaptureSource.screen,
      CaptureSource.cloud,
      CaptureSource.meeting,
      CaptureSource.url,
    ]);
    // Every row is rendered (the sheet scrolls on small screens).
    for (final title in titles) {
      final f = find.text(title);
      await t.ensureVisible(f);
      expect(f, findsOneWidget);
    }
  });

  testWidgets('a placeholder source opens its page', (t) async {
    await t.pumpWidget(_app(_router()));
    await t.pumpAndSettle();

    await t.tap(find.bySemanticsLabel(_l10n.navNew));
    await t.pumpAndSettle();
    await t.tap(find.text(_l10n.sourceDictationTitle));
    await t.pumpAndSettle();

    expect(find.text('PAGE ${Routes.dictation}'), findsOneWidget);
  });

  testWidgets('file upload asks the shell picker', (t) async {
    await t.pumpWidget(_app(_router()));
    await t.pumpAndSettle();

    await t.tap(find.bySemanticsLabel(_l10n.navNew));
    await t.pumpAndSettle();
    await t.tap(find.text(_l10n.sourceUploadTitle));
    await t.pumpAndSettle();

    verify(() => pick.pick()).called(1);
  });
}
