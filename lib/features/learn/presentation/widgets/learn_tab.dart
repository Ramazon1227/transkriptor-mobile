import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/demo_banner.dart';
import 'package:transkriptor_uz/features/learn/application/learn_cubit.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/presentation/pages/flashcards_page.dart';
import 'package:transkriptor_uz/features/learn/presentation/pages/quiz_page.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_create_sheet.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_labels.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The editor's «Oʻrganish» tab: flashcards and a quiz built from this
/// transcript. No backend yet — a demo source makes them and the tab
/// says so. Lives in a tab view under the player: fills a bounded height
/// and scrolls on its own.
class LearnTab extends StatelessWidget {
  const LearnTab({required this.transcript, super.key});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<LearnCubit>();
        unawaited(cubit.start(transcript));
        return cubit;
      },
      child: const _LearnView(),
    );
  }
}

class _LearnView extends StatelessWidget {
  const _LearnView();

  Future<void> _create(BuildContext context, {required bool quiz}) async {
    final cubit = context.read<LearnCubit>();
    final navigator = Navigator.of(context);
    final request = await showAppSheet<LearnRequest>(
      context,
      builder: (_) => LearnCreateSheet(quiz: quiz),
    );
    if (request == null) return;
    if (quiz) {
      final set = await cubit.createQuiz(
        count: request.count,
        difficulty: request.difficulty,
        types: request.types,
      );
      if (set != null) await navigator.push(QuizPage.route(set));
    } else {
      final set = await cubit.createFlashcards(
        count: request.count,
        difficulty: request.difficulty,
      );
      if (set != null) await navigator.push(FlashcardsPage.route(set));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LearnCubit, LearnState>(
      builder: (context, state) {
        final creating = state.createStatus == LearnCreateStatus.creating;
        return ListView(
          key: const Key('learn_list'),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            DemoBanner(message: l10n.learnDemoBanner),
            const SizedBox(height: 12),
            if (state.status == LearnStatus.tooShort)
              _Info(key: const Key('learn_too_short'), text: l10n.learnTooShort)
            else ...[
              Text(l10n.learnIntro, style: AppText.caption),
              const SizedBox(height: 8),
              _EntryCard(
                key: const Key('learn_flashcards'),
                icon: Icons.style_outlined,
                title: l10n.learnFlashcardsTitle,
                body: l10n.learnFlashcardsBody,
                onTap: creating ? null : () => _create(context, quiz: false),
              ),
              const SizedBox(height: 8),
              _EntryCard(
                key: const Key('learn_quiz'),
                icon: Icons.quiz_outlined,
                title: l10n.learnQuizTitle,
                body: l10n.learnQuizBody,
                onTap: creating ? null : () => _create(context, quiz: true),
              ),
              if (creating) ...[
                const SizedBox(height: 12),
                _Info(text: l10n.learnCreating, busy: true),
              ],
              if (state.createStatus == LearnCreateStatus.empty) ...[
                const SizedBox(height: 12),
                _Info(
                  key: const Key('learn_empty_result'),
                  text: l10n.learnEmptyResult,
                ),
              ],
              if (state.createStatus == LearnCreateStatus.failure) ...[
                const SizedBox(height: 12),
                _Info(
                  text: (state.failure ?? const Failure.unknown()).message(
                    l10n,
                  ),
                ),
              ],
              if (!state.sets.isEmpty) ...[
                const SizedBox(height: 20),
                _PreviousSets(sets: state.sets),
              ],
            ],
          ],
        );
      },
    );
  }
}

class _PreviousSets extends StatelessWidget {
  const _PreviousSets({required this.sets});

  final LearnSets sets;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final rows = <(DateTime, Widget)>[
      for (final s in sets.flashcards)
        (
          s.createdAt,
          ActionRow(
            key: Key('learn_set_${s.id}'),
            icon: Icons.style_outlined,
            label: l10n.learnFlashcardSetTitle(s.cards.length),
            subtitle: l10n.learnSetSubtitle(
              s.difficulty.label(l10n),
              Formatters.clock(s.createdAt),
            ),
            onTap: () => navigator.push(FlashcardsPage.route(s)),
          ),
        ),
      for (final s in sets.quizzes)
        (
          s.createdAt,
          ActionRow(
            key: Key('learn_set_${s.id}'),
            icon: Icons.quiz_outlined,
            label: l10n.learnQuizSetTitle(s.questions.length),
            subtitle: l10n.learnSetSubtitle(
              s.difficulty.label(l10n),
              Formatters.clock(s.createdAt),
            ),
            onTap: () => navigator.push(QuizPage.route(s)),
          ),
        ),
    ]..sort((a, b) => b.$1.compareTo(a.$1));
    return ActionGroup(
      title: l10n.learnPrevious,
      children: [for (final r in rows) r.$2],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadii.card);
    return Material(
      color: AppColors.sf1,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                ),
                child: Icon(icon, color: AppColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.bodyStrong),
                    const SizedBox(height: 2),
                    Text(body, style: AppText.caption),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.mutedDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.text, this.busy = false, super.key});

  final String text;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          if (busy) ...[
            const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(child: Text(text, style: AppText.body)),
        ],
      ),
    );
  }
}
