import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/learn/application/quiz_cubit.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_labels.dart';

/// Runs one quiz: a question per screen, the answer is marked right or
/// wrong at once, then the score with a review of every answer.
class QuizPage extends StatelessWidget {
  const QuizPage({required this.set, super.key});

  final QuizSet set;

  static Route<void> route(QuizSet set) =>
      MaterialPageRoute(builder: (_) => QuizPage(set: set));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizCubit>()..start(set),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.learnQuizTitle)),
        body: const SafeArea(child: ContentWidth(child: _QuizView())),
      ),
    );
  }
}

class _QuizView extends StatelessWidget {
  const _QuizView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        final cubit = context.read<QuizCubit>();
        if (state.finished) return _Result(state: state);
        final q = state.current;
        if (q == null) return const SizedBox.shrink();
        final answer = state.currentAnswer;
        final total = state.questions.length;
        final last = state.index == total - 1;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (state.index + 1) / total,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.learnProgress(state.index + 1, total),
                    style: AppText.mono,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                key: const Key('quiz_question'),
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    (q.type == QuizQuestionType.trueFalse
                            ? l10n.learnQuizTrueFalsePrompt
                            : l10n.learnQuizChoosePrompt)
                        .toUpperCase(),
                    style: AppText.label,
                  ),
                  const SizedBox(height: 10),
                  Text(q.prompt, style: AppText.body.copyWith(fontSize: 18)),
                  const SizedBox(height: 20),
                  for (var i = 0; i < q.answerCount; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _Option(
                        key: Key('quiz_option_$i'),
                        label: q.answerLabel(l10n, i),
                        mark: answer == null
                            ? _Mark.none
                            : i == q.correctIndex
                            ? _Mark.right
                            : i == answer
                            ? _Mark.wrong
                            : _Mark.none,
                        onTap: answer == null ? () => cubit.choose(i) : null,
                      ),
                    ),
                  if (answer != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      answer == q.correctIndex
                          ? l10n.learnCorrect
                          : l10n.learnWrong,
                      key: const Key('quiz_verdict'),
                      style: AppText.bodyStrong.copyWith(
                        color: answer == q.correctIndex
                            ? AppColors.accent
                            : AppColors.bad,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(l10n.learnSource(q.source), style: AppText.caption),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: FilledButton(
                key: const Key('quiz_next'),
                onPressed: answer == null ? null : cubit.next,
                child: Text(last ? l10n.learnFinish : l10n.learnNextCard),
              ),
            ),
          ],
        );
      },
    );
  }
}

enum _Mark { none, right, wrong }

class _Option extends StatelessWidget {
  const _Option({
    required this.label,
    required this.mark,
    required this.onTap,
    super.key,
  });

  final String label;
  final _Mark mark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadii.card);
    final (border, icon) = switch (mark) {
      _Mark.none => (AppColors.sf3, null),
      _Mark.right => (AppColors.accent, Icons.check_circle_rounded),
      _Mark.wrong => (AppColors.bad, Icons.cancel_rounded),
    };
    return Material(
      color: AppColors.sf1,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: border, width: mark == _Mark.none ? 1 : 2),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(child: Text(label, style: AppText.body)),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, color: border, size: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<QuizCubit>();
    return ListView(
      key: const Key('quiz_result'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.learnScoreTitle,
          style: AppText.caption,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          l10n.learnProgress(state.score, state.questions.length),
          key: const Key('quiz_score'),
          style: AppText.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                key: const Key('quiz_restart'),
                onPressed: cubit.restart,
                child: Text(
                  l10n.learnRestart,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(
                  l10n.close,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(l10n.learnReview.toUpperCase(), style: AppText.label),
        const SizedBox(height: 8),
        for (var i = 0; i < state.questions.length; i++)
          _ReviewItem(
            number: i + 1,
            question: state.questions[i],
            answer: i < state.answers.length ? state.answers[i] : null,
          ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({
    required this.number,
    required this.question,
    required this.answer,
  });

  final int number;
  final QuizQuestion question;
  final int? answer;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final answer = this.answer;
    final right = answer == question.correctIndex;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border(
          left: BorderSide(
            color: right ? AppColors.accent : AppColors.bad,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number. ${question.prompt}', style: AppText.body),
          const SizedBox(height: 6),
          if (answer != null)
            Text(
              l10n.learnYourAnswer(question.answerLabel(l10n, answer)),
              style: AppText.caption.copyWith(
                color: right ? AppColors.accent : AppColors.bad,
              ),
            ),
          if (!right)
            Text(
              l10n.learnRightAnswer(
                question.answerLabel(l10n, question.correctIndex),
              ),
              style: AppText.caption,
            ),
        ],
      ),
    );
  }
}
