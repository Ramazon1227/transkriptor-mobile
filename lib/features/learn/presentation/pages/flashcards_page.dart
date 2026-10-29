import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/learn/application/flashcards_cubit.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';

/// Studies one flashcard set: tap to flip, «Bilaman» / «Takrorlash» to
/// mark and move on, arrows to step back and forth.
class FlashcardsPage extends StatelessWidget {
  const FlashcardsPage({required this.set, super.key});

  final FlashcardSet set;

  static Route<void> route(FlashcardSet set) =>
      MaterialPageRoute(builder: (_) => FlashcardsPage(set: set));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FlashcardsCubit>()..start(set),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.learnFlashcardsTitle)),
        body: const SafeArea(child: ContentWidth(child: _FlashcardsView())),
      ),
    );
  }
}

class _FlashcardsView extends StatelessWidget {
  const _FlashcardsView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<FlashcardsCubit, FlashcardsState>(
      builder: (context, state) {
        final cubit = context.read<FlashcardsCubit>();
        if (state.finished) return _Finished(state: state);
        final card = state.current;
        if (card == null) return const SizedBox.shrink();
        final total = state.cards.length;
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _CardFace(
                  card: card,
                  flipped: state.flipped,
                  onTap: cubit.flip,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                children: [
                  Text(
                    l10n.learnKnownCount(state.known.length),
                    style: AppText.caption,
                  ),
                  Text(
                    l10n.learnRepeatCount(state.repeat.length),
                    style: AppText.caption,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Row(
                children: [
                  IconButton(
                    key: const Key('flashcard_prev'),
                    tooltip: l10n.learnPreviousCard,
                    onPressed: state.hasPrevious ? cubit.previous : null,
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      key: const Key('flashcard_repeat'),
                      onPressed: () => cubit.mark(known: false),
                      child: Text(
                        l10n.learnRepeat,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      key: const Key('flashcard_know'),
                      onPressed: () => cubit.mark(known: true),
                      child: Text(
                        l10n.learnKnow,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    key: const Key('flashcard_next'),
                    tooltip: l10n.learnNextCard,
                    onPressed: cubit.next,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.card,
    required this.flipped,
    required this.onTap,
  });

  final Flashcard card;
  final bool flipped;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final radius = BorderRadius.circular(AppRadii.card);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: .96, end: 1).animate(animation),
          child: child,
        ),
      ),
      child: Material(
        key: ValueKey('${card.front}|$flipped'),
        color: flipped ? AppColors.sf2 : AppColors.sf1,
        borderRadius: radius,
        child: InkWell(
          key: const Key('flashcard_card'),
          borderRadius: radius,
          onTap: onTap,
          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (flipped ? l10n.learnCardBack : l10n.learnCardFront)
                        .toUpperCase(),
                    style: AppText.label,
                  ),
                  const SizedBox(height: 12),
                  if (flipped) ...[
                    Text(card.back, style: AppText.title),
                    const SizedBox(height: 12),
                    Text(card.source, style: AppText.caption),
                  ] else ...[
                    Text(
                      card.front,
                      style: AppText.body.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.learnTapToFlip, style: AppText.caption),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Finished extends StatelessWidget {
  const _Finished({required this.state});

  final FlashcardsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<FlashcardsCubit>();
    return ListView(
      key: const Key('flashcards_finished'),
      padding: const EdgeInsets.all(24),
      children: [
        const Icon(Icons.task_alt_rounded, size: 40, color: AppColors.accent),
        const SizedBox(height: 12),
        Text(
          l10n.learnFlashcardsDone,
          style: AppText.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          '${l10n.learnKnownCount(state.known.length)} · '
          '${l10n.learnRepeatCount(state.repeat.length)}',
          style: AppText.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        if (state.repeat.isNotEmpty) ...[
          FilledButton(
            key: const Key('flashcards_restart_repeat'),
            onPressed: () => cubit.restart(onlyRepeat: true),
            child: Text(l10n.learnRestartRepeat),
          ),
          const SizedBox(height: 8),
        ],
        OutlinedButton(
          key: const Key('flashcards_restart'),
          onPressed: cubit.restart,
          child: Text(l10n.learnRestart),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(l10n.close),
        ),
      ],
    );
  }
}
