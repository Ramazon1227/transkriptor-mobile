import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/learn/application/flashcards_cubit.dart';
import 'package:transkriptor_uz/features/learn/application/learn_cubit.dart';
import 'package:transkriptor_uz/features/learn/application/quiz_cubit.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/demo/demo_learn_repository.dart';
import 'package:transkriptor_uz/features/learn/infrastructure/facades/learn_facade.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_tab.dart';

import '../../../helpers/transcripts.dart';

Widget _host(Widget child) => MaterialApp(
  theme: AppTheme.dark(),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
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
  setUp(() {
    final facade = LearnFacade(
      DemoLearnRepository.custom(delay: Duration.zero),
    );
    getIt
      ..registerFactory(() => LearnCubit(facade))
      ..registerFactory(FlashcardsCubit.new)
      ..registerFactory(QuizCubit.new);
  });
  tearDown(getIt.reset);

  testWidgets('short transcript: explains instead of offering', (tester) async {
    await tester.pumpWidget(_host(LearnTab(transcript: shortTranscript())));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('learn_too_short')), findsOneWidget);
    expect(find.byKey(const Key('learn_flashcards')), findsNothing);
  });

  testWidgets('create flashcards, study one, come back to the list', (
    tester,
  ) async {
    await tester.pumpWidget(_host(LearnTab(transcript: meetingTranscript())));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('learn_flashcards')));
    await tester.pumpAndSettle();
    expect(find.text('Kartochkalar yaratish'), findsOneWidget);
    await tester.tap(find.text('5'));
    await tester.tap(find.byKey(const Key('learn_create_submit')));
    await tester.pumpAndSettle();

    expect(find.text('1 / 5'), findsOneWidget);
    await tester.tap(find.byKey(const Key('flashcard_card')));
    await tester.pumpAndSettle();
    expect(find.text('JAVOB'), findsOneWidget);
    await tester.tap(find.byKey(const Key('flashcard_know')));
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('Bilaman: 1'), findsOneWidget);

    Navigator.of(tester.element(find.byKey(const Key('flashcard_card')))).pop();
    await tester.pumpAndSettle();
    expect(find.text('Kartochkalar · 5 ta'), findsOneWidget);
  });

  testWidgets('quiz: needs a type, answers are marked at once', (tester) async {
    await tester.pumpWidget(_host(LearnTab(transcript: meetingTranscript())));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('learn_quiz')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('learn_type_multipleChoice')));
    await tester.tap(find.byKey(const Key('learn_type_trueFalse')));
    await tester.pump();
    final create = find.byKey(const Key('learn_create_submit'));
    expect(tester.widget<FilledButton>(create).onPressed, isNull);
    await tester.tap(find.byKey(const Key('learn_type_trueFalse')));
    await tester.pump();
    await tester.tap(create);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('quiz_question')), findsOneWidget);
    final next = find.byKey(const Key('quiz_next'));
    expect(tester.widget<FilledButton>(next).onPressed, isNull);
    await tester.tap(find.byKey(const Key('quiz_option_0')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('quiz_verdict')), findsOneWidget);
    expect(tester.widget<FilledButton>(next).onPressed, isNotNull);
  });
}
