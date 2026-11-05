import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/glossary/domain/entities/glossary.dart';
import 'package:transkriptor_uz/features/glossary/domain/i_glossary_facade.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/upload/application/advanced_settings_cubit.dart';
import 'package:transkriptor_uz/features/upload/application/hint_player_cubit.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/link_page.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/send_page.dart';

import '../../../helpers/editor_fakes.dart';

class _Account extends MockCubit<AccountState> implements AccountCubit;

class _Upload extends Mock implements IUploadFacade;

class _Library extends Mock implements ILibraryFacade;

class _Glossaries extends Mock implements IGlossaryFacade;

class _Billing extends Mock implements IBillingFacade;

class _FakePendingFile extends Fake implements PendingFile;

const _file = PendingFile(
  path: '/tmp/kengash.mp3',
  fileName: 'kengash.mp3',
  sizeBytes: 10,
  source: UploadSource.upload,
);

void main() {
  final l10n = AppLocalizationsUz();
  late _Account account;
  late _Upload upload;

  setUpAll(() {
    registerFallbackValue(_FakePendingFile());
    registerFallbackValue(const JobOptions());
  });

  setUp(() {
    account = _Account();
    upload = _Upload();
    final library = _Library();
    final glossaries = _Glossaries();
    final billing = _Billing();
    when(() => account.state).thenReturn(
      const AccountState(
        status: AccountStatus.success,
        account: Account(
          user: AppUser(id: 'u1', email: 'a@misol.uz'),
          workspaces: [
            Workspace(
              id: 'w1',
              name: 'Shaxsiy',
              isPersonal: true,
              balanceSeconds: 600,
              role: WorkspaceRole.owner,
            ),
          ],
        ),
      ),
    );
    when(() => library.getFolders(workspaceId: 'w1')).thenAnswer(
      (_) async => const Right([Folder(id: 'f1', name: 'Hisobotlar')]),
    );
    when(() => glossaries.glossaries(workspaceId: 'w1')).thenAnswer(
      (_) async =>
          const Right([Glossary(id: 'g1', name: 'Kengash', termCount: 4)]),
    );
    when(() => billing.balance('w1'))
        .thenAnswer((_) async => const Right(Balance(balanceSeconds: 1200)));
    when(
      () => upload.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        folderId: any(named: 'folderId'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        options: any(named: 'options'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer(
      // Stored, not started: the page stays, nothing navigates away.
      (_) async => const Right(
        UploadResult(mediaId: 'm1', startFailure: Failure.network()),
      ),
    );
    getIt
      ..registerFactory<UploadBloc>(() => UploadBloc(upload))
      ..registerFactory<AdvancedSettingsCubit>(
        () => AdvancedSettingsCubit(library, glossaries, billing),
      )
      ..registerFactory<HintPlayerCubit>(
        () => HintPlayerCubit(FakeEngineFactory()),
      );
  });

  tearDown(() async => await getIt.reset());

  Future<void> pump(WidgetTester tester, Widget page) async {
    tester.view
      ..physicalSize = const Size(800, 2400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      BlocProvider<AccountCubit>.value(
        value: account,
        child: MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: page,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> unmount(WidgetTester tester) =>
      tester.pumpWidget(const SizedBox.shrink());

  String summary(WidgetTester tester) {
    final row = find.byKey(const Key('advanced_open'));
    return tester
        .widgetList<Text>(find.descendant(of: row, matching: find.byType(Text)))
        .map((t) => t.data)
        .last!;
  }

  testWidgets('the panel opens, saves for this upload and the summary and '
      'the request follow', (tester) async {
    await pump(tester, const SendPage(file: _file));
    expect(
      summary(tester),
      '${l10n.advancedSummaryFiles} · ${l10n.advancedSummarySpeakersAuto}',
    );

    await tap(tester, find.byKey(const Key('advanced_open')));
    expect(find.text(l10n.advancedTitle), findsWidgets);
    // Terms are open first: pick the list, write a free term.
    await tap(tester, find.byKey(const Key('advanced_glossary_g1')));
    await tester.enterText(
      find.byKey(const Key('advanced_terms')),
      'IT Park\nit park',
    );
    await tester.pumpAndSettle();
    expect(find.text(l10n.advancedTermsCounter(1, 200)), findsOneWidget);

    await tap(tester, find.byKey(const Key('advanced_fold_destination')));
    await tap(tester, find.byKey(const Key('advanced_folder_f1')));
    expect(find.text(l10n.advancedDestBalance('20 daq')), findsOneWidget);

    await tap(tester, find.byKey(const Key('advanced_fold_speakers')));
    await tap(tester, find.text('3'));

    await tap(tester, find.byKey(const Key('advanced_save')));
    expect(find.byKey(const Key('advanced_save')), findsNothing);
    expect(
      summary(tester),
      'Hisobotlar · ${l10n.advancedSummarySpeakers(3)} · '
      '${l10n.advancedSummaryTerms('Kengash +1')}',
    );

    await tap(tester, find.text(l10n.sendStart));
    verify(
      () => upload.upload(
        file: any(named: 'file'),
        workspaceId: 'w1',
        title: any(named: 'title'),
        startTranscription: true,
        jobKey: any(named: 'jobKey'),
        folderId: 'f1',
        numSpeakers: 3,
        service: any(named: 'service'),
        options: const JobOptions(glossaryId: 'g1', terms: ['IT Park']),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).called(1);

    // Stored now: the destination went with the file and is locked.
    await tap(tester, find.byKey(const Key('advanced_open')));
    await tap(tester, find.byKey(const Key('advanced_fold_destination')));
    expect(find.byKey(const Key('advanced_dest_locked')), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('back drops the draft', (tester) async {
    await pump(tester, const SendPage(file: _file));
    await tap(tester, find.byKey(const Key('advanced_open')));
    await tap(tester, find.byKey(const Key('advanced_fold_speakers')));
    await tap(tester, find.text('4'));
    await tap(tester, find.byType(BackButton));
    expect(find.byKey(const Key('advanced_save')), findsNothing);
    expect(summary(tester), contains(l10n.advancedSummarySpeakersAuto));
    await unmount(tester);
  });

  testWidgets('a speaker hint is marked on the picked file and refused '
      'with a reason when it breaks a rule', (tester) async {
    await pump(tester, const SendPage(file: _file));
    await tap(tester, find.byKey(const Key('advanced_open')));
    await tap(tester, find.byKey(const Key('advanced_fold_hints')));
    expect(find.text(l10n.advancedHintsDemo), findsOneWidget);
    expect(find.byKey(const Key('hint_play')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('hint_start')), '0:10');
    await tester.enterText(find.byKey(const Key('hint_end')), '0:10.5');
    await tester.enterText(find.byKey(const Key('hint_label')), 'Sarvar');
    await tap(tester, find.byKey(const Key('hint_add')));
    expect(find.text(l10n.advancedErrHintShort), findsOneWidget);

    await tester.enterText(find.byKey(const Key('hint_end')), '0:20');
    await tap(tester, find.byKey(const Key('hint_add')));
    expect(find.byKey(const Key('hint_problem')), findsNothing);
    expect(find.text('0:10 – 0:20'), findsOneWidget);

    await tap(tester, find.byKey(const Key('advanced_save')));
    expect(summary(tester), endsWith(l10n.advancedSummaryHints(1)));
    await unmount(tester);
  });

  testWidgets('a link has nothing to play: the hints fold says so', (
    tester,
  ) async {
    await pump(tester, const LinkPage());
    await tap(tester, find.byKey(const Key('advanced_open')));
    await tap(tester, find.byKey(const Key('advanced_fold_hints')));
    expect(find.text(l10n.advancedHintsLinkNote), findsOneWidget);
    expect(find.byKey(const Key('hint_play')), findsNothing);
    await unmount(tester);
  });
}
