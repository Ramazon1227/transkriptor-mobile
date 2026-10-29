import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/comments/application/comments_cubit.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';
import 'package:transkriptor_uz/features/comments/domain/i_comments_facade.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/summary_tab.dart';
import 'package:transkriptor_uz/features/transcript/application/retranscribe_cubit.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/presentation/pages/transcript_page.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/editor_actions_sheet.dart';

import '../../../helpers/editor_fakes.dart';

class _MockTranscriptFacade extends Mock implements ITranscriptFacade;

class _MockCommentsFacade extends Mock implements ICommentsFacade;

class _MockExportFacade extends Mock implements IExportFacade;

class _MockJobFacade extends Mock implements IJobFacade;

class _Account extends MockCubit<AccountState> implements AccountCubit;

class _Summary extends MockCubit<SummaryState> implements SummaryCubit;

const _transcript = Transcript(
  id: 't1',
  title: 'Kengash yigʻilishi',
  mediaId: 'm1',
  speakers: [
    Speaker(id: 's1', label: 'Dilnoza', ordinal: 1),
    Speaker(id: 's2', label: 'Sardor', ordinal: 2),
  ],
  segments: [
    Segment(
      id: 'g1',
      start: Duration(seconds: 1),
      end: Duration(seconds: 10),
      text: 'birinchi gap',
      speakerId: 's1',
    ),
    Segment(
      id: 'g2',
      start: Duration(seconds: 10),
      end: Duration(seconds: 20),
      text: 'ikkinchi gap',
      speakerId: 's2',
    ),
  ],
  revision: 2,
);

void main() {
  late _MockTranscriptFacade facade;
  late FakePlayerFacade player;
  late FakeEngineFactory engines;
  late _Account account;

  setUp(() {
    facade = _MockTranscriptFacade();
    when(() => facade.getTranscript('t1'))
        .thenAnswer((_) async => const Right(_transcript));
    player = FakePlayerFacade(
      const Right(PlayableMedia(url: 'https://s3.test/a.m4a')),
    );
    engines = FakeEngineFactory();
    account = _Account();
    when(() => account.state).thenReturn(
      const AccountState(
        status: AccountStatus.success,
        account: Account(
          user: AppUser(id: 'u1', email: 'e@misol.uz'),
        ),
      ),
    );
    getIt
      ..registerFactory(() => TranscriptCubit(facade))
      ..registerFactory(() => PlayerCubit(player, engines))
      ..registerFactory(() => ExportCubit(_MockExportFacade()))
      ..registerFactory(() => RetranscribeCubit(_MockJobFacade()))
      ..registerFactory<SummaryCubit>(() {
        final summary = _Summary();
        when(() => summary.state).thenReturn(const SummaryState());
        when(() => summary.start(_transcript)).thenAnswer((_) async {});
        return summary;
      });
  });
  tearDown(getIt.reset);

  Future<void> pumpPage(WidgetTester tester) async {
    // A phone in portrait: the player sits above the tabs.
    tester.view
      ..physicalSize = const Size(800, 1400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      BlocProvider<AccountCubit>.value(
        value: account,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: TranscriptPage(transcriptId: 't1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('tabs and player', () {
    testWidgets('four tabs; another tab opens and the transcript is kept', (
      tester,
    ) async {
      await pumpPage(tester);
      for (final t in ['Transkript', 'AI suhbat', 'Xulosa', 'Oʻrganish']) {
        expect(find.text(t), findsOneWidget);
      }
      await tester.tap(find.text('Xulosa'));
      await tester.pumpAndSettle();
      expect(find.byType(SummaryTab), findsOneWidget);
      await tester.tap(find.text('Transkript'));
      await tester.pumpAndSettle();
      expect(find.text('birinchi gap'), findsOneWidget);
    });

    testWidgets('a timecode seeks and plays; the active segment is marked', (
      tester,
    ) async {
      await pumpPage(tester);
      expect(find.byKey(const Key('player_play')), findsOneWidget);
      expect(find.byKey(const Key('player_fold')), findsNothing);

      await tester.tap(find.byKey(const Key('seek_g2')));
      await tester.pumpAndSettle();
      final engine = engines.made.single;
      expect(engine.calls, containsAllInOrder(['seek:10000', 'play']));
      expect(find.text('00:00:10'), findsWidgets);
    });

    testWidgets('a video folds away without touching playback', (tester) async {
      await pumpPage(tester);
      final engine = engines.made.single
        ..push(
          const PlaybackSnapshot(
            duration: Duration(minutes: 1),
            hasVideo: true,
          ),
        );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('fake_surface')), findsOneWidget);

      await tester.tap(find.byKey(const Key('player_play')));
      await tester.pumpAndSettle();
      final before = List.of(engine.calls);
      await tester.tap(find.byKey(const Key('player_fold')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('fake_surface')), findsNothing);
      expect(engine.calls, before);
    });

    testWidgets('YouTube: a link card, the transcript still works', (
      tester,
    ) async {
      player.answer = const Right(
        PlayableMedia(url: 'https://www.youtube.com/watch?v=x', youtubeId: 'x'),
      );
      await pumpPage(tester);
      expect(find.byKey(const Key('player_youtube_open')), findsOneWidget);
      expect(find.byKey(const Key('player_play')), findsNothing);
      expect(find.text('birinchi gap'), findsOneWidget);
      // Nothing to seek: the timecodes are plain text.
      expect(find.byKey(const Key('seek_g1')), findsNothing);

      await tester.tap(find.byKey(const Key('player_youtube_open')));
      await tester.pumpAndSettle();
      expect(player.opened, ['https://www.youtube.com/watch?v=x']);
    });

    testWidgets('YouTube: nothing opens the link, so it is copied', (
      tester,
    ) async {
      final copied = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied.add((call.arguments as Map)['text'] as String);
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      player
        ..answer = const Right(
          PlayableMedia(
            url: 'https://www.youtube.com/watch?v=x',
            youtubeId: 'x',
          ),
        )
        ..openSucceeds = false;
      await pumpPage(tester);
      await tester.tap(find.byKey(const Key('player_youtube_open')));
      await tester.pumpAndSettle();
      expect(copied, ['https://www.youtube.com/watch?v=x']);
      expect(
        find.text(AppLocalizationsUz().linkOpenFailedCopied),
        findsOneWidget,
      );
    });
  });

  group('read and edit mode', () {
    testWidgets('read mode: no hint, a double tap opens nothing', (
      tester,
    ) async {
      await pumpPage(tester);
      expect(find.byKey(const Key('edit_hint')), findsNothing);
      await doubleTap(tester, find.text('birinchi gap'));
      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('the pencil shows the hint; a double tap edits', (
      tester,
    ) async {
      await pumpPage(tester);
      await enterEditMode(tester);
      expect(find.byKey(const Key('edit_hint')), findsOneWidget);
      expect(
        find.text('Satrni tahrirlash uchun ikki marta bosing'),
        findsOneWidget,
      );
      await doubleTap(tester, find.text('birinchi gap'));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Matnni tahrirlash'), findsOneWidget);
    });

    testWidgets('the eye hides the speaker chips', (tester) async {
      await pumpPage(tester);
      expect(find.byKey(const Key('speaker_chip_s1')), findsOneWidget);
      await tester.tap(find.byKey(const Key('transcript_toggle_speakers')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('speaker_chip_s1')), findsNothing);
    });
  });

  group('file actions sheet', () {
    Future<void> openSheet(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('transcript_more')));
      await tester.pumpAndSettle();
    }

    testWidgets('lists every action; the switches act at once', (tester) async {
      await pumpPage(tester);
      await openSheet(tester);
      for (final key in [
        'file_show_speakers',
        'file_speed',
        'file_edit',
        'file_rename',
        'file_export',
        'file_share',
        'file_comments',
        'file_rating',
        'file_retranscribe',
      ]) {
        expect(find.byKey(Key(key)), findsOneWidget, reason: key);
      }
      expect(find.text('1×'), findsWidgets);

      await tester.tap(find.byKey(const Key('file_edit')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('file_show_speakers')));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(EditorActionsSheet), findsNothing);
      expect(find.byKey(const Key('edit_hint')), findsOneWidget);
      expect(find.byKey(const Key('speaker_chip_s1')), findsNothing);
    });

    testWidgets('speed opens the choices and applies one', (tester) async {
      await pumpPage(tester);
      await openSheet(tester);
      await tester.tap(find.byKey(const Key('file_speed')));
      await tester.pumpAndSettle();
      expect(find.byType(EditorActionsSheet), findsNothing);
      await tester.tap(find.text('1,5×'));
      await tester.pumpAndSettle();
      expect(engines.made.single.calls, contains('speed:1.5'));
    });

    testWidgets('export closes the sheet and opens the export steps', (
      tester,
    ) async {
      await pumpPage(tester);
      await openSheet(tester);
      await tester.tap(find.byKey(const Key('file_export')));
      await tester.pumpAndSettle();
      expect(find.byType(EditorActionsSheet), findsNothing);
      expect(find.byKey(const Key('export_next')), findsOneWidget);
    });

    testWidgets('retranscribe asks inside its sheet first', (tester) async {
      await pumpPage(tester);
      await openSheet(tester);
      await tester.tap(find.byKey(const Key('file_retranscribe')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('retranscribe_confirm')), findsOneWidget);
      expect(
        find.text(
          'Fayl qaytadan transkripsiya qilinadi va balansdan daqiqa '
          'yechiladi.',
        ),
        findsOneWidget,
      );
    });
  });

  testWidgets('a comment is added from the segment menu', (tester) async {
    final comments = _MockCommentsFacade();
    when(() => comments.list('t1')).thenAnswer((_) async => const Right([]));
    when(
      () => comments.create(transcriptId: 't1', segmentId: 'g1', body: 'ism'),
    ).thenAnswer(
      (_) async => const Right(
        Comment(id: 'c1', segmentId: 'g1', body: 'ism', authorId: 'u1'),
      ),
    );
    getIt.registerFactory(() => CommentsCubit(comments));
    await pumpPage(tester);

    await tester.longPress(find.text('birinchi gap'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('segment_comment')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('comment_field')), 'ism');
    await tester.pump();
    await tester.tap(find.byKey(const Key('comment_send')));
    await tester.pumpAndSettle();
    verify(
      () => comments.create(transcriptId: 't1', segmentId: 'g1', body: 'ism'),
    ).called(1);

    expect(find.byKey(const Key('comment_field')), findsNothing);
    expect(find.text('ism'), findsOneWidget);
    // Own comment: edit and delete are offered.
    expect(find.byKey(const Key('comment_edit_c1')), findsOneWidget);
    expect(find.text('Siz'), findsOneWidget);
  });
}
