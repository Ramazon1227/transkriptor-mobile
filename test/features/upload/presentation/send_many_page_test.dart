import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/application/upload_queue_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/upload_cancel.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/send_many_page.dart';

class _Account extends MockCubit<AccountState> implements AccountCubit;

class _MockFacade extends Mock implements IUploadFacade;

class _FakePendingFile extends Fake implements PendingFile;

PendingFile _file(String name) => PendingFile(
  path: '/tmp/$name',
  fileName: name,
  sizeBytes: 10,
  source: UploadSource.upload,
);

const _job = Job(id: 'j1', mediaId: 'm1', status: JobStatus.queued);

void main() {
  late _Account account;
  late _MockFacade facade;
  final l10n = AppLocalizationsUz();

  setUpAll(() => registerFallbackValue(_FakePendingFile()));

  void stubUpload(UploadResult result) => when(
    () => facade.upload(
      file: any(named: 'file'),
      workspaceId: any(named: 'workspaceId'),
      title: any(named: 'title'),
      startTranscription: any(named: 'startTranscription'),
      jobKey: any(named: 'jobKey'),
      numSpeakers: any(named: 'numSpeakers'),
      service: any(named: 'service'),
      onProgress: any(named: 'onProgress'),
      cancel: any(named: 'cancel'),
    ),
  ).thenAnswer((_) async => Right(result));

  setUp(() {
    account = _Account();
    facade = _MockFacade();
    when(() => account.state).thenReturn(
      const AccountState(
        status: AccountStatus.success,
        account: Account(
          user: AppUser(id: 'u1', email: 'a@misol.uz'),
          workspaces: [
            Workspace(id: 'w1', name: 'Shaxsiy', balanceSeconds: 600),
          ],
        ),
      ),
    );
    getIt.registerFactory<UploadQueueCubit>(() => UploadQueueCubit(facade));
    stubUpload(const UploadResult(mediaId: 'm1', job: _job));
  });

  tearDown(() async => await getIt.reset());

  Future<void> pump(WidgetTester tester, List<PendingFile> files) async {
    tester.view
      ..physicalSize = const Size(800, 2000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final router = GoRouter(
      initialLocation: Routes.home,
      routes: [
        GoRoute(path: Routes.home, builder: (_, _) => const Text('STUDIO')),
        GoRoute(path: Routes.files, builder: (_, _) => const Text('FILES')),
        GoRoute(
          path: Routes.sendMany,
          builder: (_, _) => SendManyPage(files: files),
        ),
      ],
    );
    await tester.pumpWidget(
      BlocProvider<AccountCubit>.value(
        value: account,
        child: MaterialApp.router(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    // Pushed, so the page has somewhere to go back to. The future ends only
    // when the page is popped.
    unawaited(router.push<void>(Routes.sendMany));
    await tester.pumpAndSettle();
  }

  Future<void> settle(WidgetTester tester) => tester.pumpAndSettle();

  // BlocProvider closes the real cubit here, inside the test's zone.
  Future<void> unmount(WidgetTester tester) =>
      tester.pumpWidget(const SizedBox.shrink());

  testWidgets('lists the files and starts them all with one button', (
    tester,
  ) async {
    await pump(tester, [_file('a.mp3'), _file('b.wav')]);

    expect(find.text('a.mp3'), findsOneWidget);
    expect(find.text('b.wav'), findsOneWidget);
    expect(find.text(l10n.sendManyFiles(2)), findsOneWidget);

    await tester.tap(find.text(l10n.sendManyStart(2)));
    await settle(tester);

    verify(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: 'w1',
        title: any(named: 'title'),
        startTranscription: true,
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).called(2);
    expect(find.textContaining(l10n.sendManyStarted), findsNWidgets(2));
    expect(find.text(l10n.sendManyAdd), findsNothing);

    await tester.tap(find.text(l10n.sendGoToFiles));
    await settle(tester);
    expect(find.text('FILES'), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('× takes a file off; the last one closes the page', (
    tester,
  ) async {
    await pump(tester, [_file('a.mp3'), _file('b.wav')]);

    await tester.tap(find.byTooltip(l10n.sendManyRemove).first);
    await settle(tester);
    expect(find.text('a.mp3'), findsNothing);
    expect(find.text(l10n.sendManyStart(1)), findsOneWidget);

    await tester.tap(find.byTooltip(l10n.sendManyRemove));
    await settle(tester);
    expect(find.text('STUDIO'), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('a stored file says why and retries only its job', (
    tester,
  ) async {
    stubUpload(
      const UploadResult(
        mediaId: 'm1',
        startFailure: Failure.server(statusCode: 503),
      ),
    );
    when(
      () => facade.startTranscription(
        mediaId: 'm1',
        idempotencyKey: any(named: 'idempotencyKey'),
        service: JobService.transcription,
      ),
    ).thenAnswer((_) async => const Right(_job));

    await pump(tester, [_file('a.mp3'), _file('b.wav')]);
    await tester.tap(find.text(l10n.sendManyStart(2)));
    await settle(tester);

    expect(find.textContaining(l10n.sendManyNotStarted), findsNWidgets(2));
    expect(find.text(l10n.retry), findsNWidgets(2));
    await tester.tap(find.text(l10n.retry).first);
    await settle(tester);

    verify(
      () => facade.startTranscription(
        mediaId: 'm1',
        idempotencyKey: any(named: 'idempotencyKey'),
        service: JobService.transcription,
      ),
    ).called(1);
    expect(find.textContaining(l10n.sendManyStarted), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('back during an upload asks, then cancels it and leaves; × on '
      'the uploading file cancels it', (tester) async {
    final cancels = <UploadCancel>[];
    when(
      () => facade.upload(
        file: any(named: 'file'),
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        startTranscription: any(named: 'startTranscription'),
        jobKey: any(named: 'jobKey'),
        numSpeakers: any(named: 'numSpeakers'),
        service: any(named: 'service'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((call) {
      final cancel = call.namedArguments[#cancel]! as UploadCancel;
      cancels.add(cancel);
      final done = Completer<Either<Failure, UploadResult>>();
      cancel.onCancel(() => done.complete(const Left(Failure.cancelled())));
      return done.future;
    });

    await pump(tester, [_file('a.mp3'), _file('b.wav'), _file('c.mov')]);
    await tester.tap(find.text(l10n.sendManyStart(3)));
    await tester.pump();

    // The uploading file is cancelled, the next one starts.
    await tester.tap(find.byTooltip(l10n.sendCancelUpload));
    await tester.pump();
    expect(find.text('a.mp3'), findsNothing);
    expect(cancels, hasLength(2));
    expect(cancels.first.isCancelled, isTrue);

    // Back: a sheet asks; «Bekor qilish» stays on the page.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text(l10n.sendLeaveTitle), findsOneWidget);
    await tester.tap(find.byKey(const Key('confirm_sheet_cancel')));
    await tester.pumpAndSettle();
    expect(find.text('b.wav'), findsOneWidget);
    expect(cancels.last.isCancelled, isFalse);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm_sheet_confirm')));
    await tester.pumpAndSettle();
    expect(find.text('STUDIO'), findsOneWidget);
    expect(cancels, hasLength(2));
    expect(cancels.last.isCancelled, isTrue);
    await unmount(tester);
  });
}
