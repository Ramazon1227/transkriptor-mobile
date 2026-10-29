import 'package:dartz/dartz.dart' show Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_cubit.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_poll_policy.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/i_ai_chat_facade.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/ai_chat_tab.dart';

class _MockFacade extends Mock implements IAiChatFacade;

Widget _host(Widget child) => MaterialApp(
  theme: AppTheme.dark(),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // A fixed-height box under a "player", as in the editor's tab view.
  home: Scaffold(
    body: Column(
      children: [
        const SizedBox(height: 150),
        SizedBox(height: 420, child: child),
      ],
    ),
  ),
);

void main() {
  late _MockFacade facade;

  setUp(() {
    facade = _MockFacade();
    getIt.registerFactory(
      () => AiChatCubit(
        facade,
        AiChatPollPolicy.custom(
          first: const Duration(seconds: 30),
          max: const Duration(seconds: 30),
        ),
      ),
    );
  });
  tearDown(getIt.reset);

  testWidgets('empty chat offers starters; tapping one asks it', (
    tester,
  ) async {
    when(() => facade.history('t1'))
        .thenAnswer((_) async => const Right(AiChat()));
    when(() => facade.ask('t1', any())).thenAnswer(
      (inv) async => Right(
        AiExchange(
          question: AiMessage(
            id: 'q1',
            role: AiRole.user,
            status: AiMessageStatus.done,
            content: inv.positionalArguments[1] as String,
          ),
          answer: const AiMessage(
            id: 'a1',
            role: AiRole.assistant,
            status: AiMessageStatus.pending,
          ),
        ),
      ),
    );
    await tester.pumpWidget(_host(const AiChatTab(transcriptId: 't1')));
    await tester.pump();

    expect(find.byKey(const Key('ai_chat_empty')), findsOneWidget);
    await tester.tap(find.text('Kim nima dedi?'));
    await tester.pump();
    await tester.pump();

    verify(() => facade.ask('t1', 'Kim nima dedi?')).called(1);
    expect(find.text('Kim nima dedi?'), findsOneWidget);
    expect(find.textContaining('Transkriptni oʻqiyapti'), findsOneWidget);
    // Pending: the composer cannot send.
    final send = tester.widget<IconButton>(
      find.byKey(const Key('ai_chat_send')),
    );
    expect(send.onPressed, isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('timecodes in an answer seek the player', (tester) async {
    when(() => facade.history('t1')).thenAnswer(
      (_) async => const Right(
        AiChat(
          items: [
            AiMessage(
              id: 'q1',
              role: AiRole.user,
              status: AiMessageStatus.done,
              content: 'Qachon?',
            ),
            AiMessage(
              id: 'a1',
              role: AiRole.assistant,
              status: AiMessageStatus.done,
              content: 'Byudjet [01:23] da aytildi.',
            ),
          ],
        ),
      ),
    );
    Duration? seeked;
    await tester.pumpWidget(
      _host(AiChatTab(transcriptId: 't1', onSeek: (d) => seeked = d)),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI'), findsOneWidget);
    await tester.tap(find.byKey(const Key('ai_timecode_01:23')));
    expect(seeked, const Duration(minutes: 1, seconds: 23));
  });

  testWidgets('a failed answer shows its error and a resend button', (
    tester,
  ) async {
    when(() => facade.history('t1')).thenAnswer(
      (_) async => const Right(
        AiChat(
          items: [
            AiMessage(
              id: 'q1',
              role: AiRole.user,
              status: AiMessageStatus.done,
              content: 'Qachon?',
            ),
            AiMessage(
              id: 'a1',
              role: AiRole.assistant,
              status: AiMessageStatus.failed,
              error: 'AI hozir javob bermayapti.',
            ),
          ],
        ),
      ),
    );
    await tester.pumpWidget(_host(const AiChatTab(transcriptId: 't1')));
    await tester.pumpAndSettle();
    expect(find.text('AI hozir javob bermayapti.'), findsOneWidget);
    expect(find.byKey(const Key('ai_retry_a1')), findsOneWidget);
  });

  testWidgets('clearing asks inside a sheet first', (tester) async {
    when(() => facade.history('t1')).thenAnswer(
      (_) async => const Right(
        AiChat(
          items: [
            AiMessage(
              id: 'q1',
              role: AiRole.user,
              status: AiMessageStatus.done,
              content: 'Savol',
            ),
          ],
        ),
      ),
    );
    when(() => facade.clear('t1')).thenAnswer((_) async => const Right(unit));
    await tester.pumpWidget(_host(const AiChatTab(transcriptId: 't1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('ai_chat_clear')));
    await tester.pumpAndSettle();
    expect(find.text('Suhbat tozalansinmi?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('confirm_sheet_confirm')));
    await tester.pumpAndSettle();

    verify(() => facade.clear('t1')).called(1);
    expect(find.byKey(const Key('ai_chat_empty')), findsOneWidget);
  });
}
