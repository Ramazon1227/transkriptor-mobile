import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/choice_group.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_labels.dart';

/// What the create sheet asked for.
class LearnRequest {
  const LearnRequest({
    required this.count,
    required this.difficulty,
    this.types = const {},
  });

  final int count;
  final LearnDifficulty difficulty;

  /// Quiz only; empty for flashcards.
  final Set<QuizQuestionType> types;
}

/// «Kartochkalar yaratish» / «Test yaratish»: count, difficulty and, for
/// a quiz, the question types (at least one). Pops a [LearnRequest].
class LearnCreateSheet extends StatefulWidget {
  const LearnCreateSheet({required this.quiz, super.key});

  final bool quiz;

  @override
  State<LearnCreateSheet> createState() => _LearnCreateSheetState();
}

class _LearnCreateSheetState extends State<LearnCreateSheet> {
  int _count = 10;
  LearnDifficulty _difficulty = LearnDifficulty.easy;
  final Set<QuizQuestionType> _types = {...QuizQuestionType.values};

  bool get _valid => !widget.quiz || _types.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      title: widget.quiz ? l10n.learnCreateQuiz : l10n.learnCreateFlashcards,
      footer: FilledButton(
        key: const Key('learn_create_submit'),
        onPressed: _valid
            ? () => Navigator.of(context).pop(
                LearnRequest(
                  count: _count,
                  difficulty: _difficulty,
                  types: widget.quiz ? {..._types} : const {},
                ),
              )
            : null,
        child: Text(l10n.learnCreate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.learnCount, style: AppText.bodyMedium),
          const SizedBox(height: 8),
          ChoiceGroup<int>(
            options: [for (final c in learnCounts) ChoiceOption(c, '$c')],
            selected: _count,
            onChanged: (v) => setState(() => _count = v),
          ),
          const SizedBox(height: 16),
          Text(l10n.learnDifficulty, style: AppText.bodyMedium),
          const SizedBox(height: 8),
          ChoiceGroup<LearnDifficulty>(
            options: [
              for (final d in LearnDifficulty.values)
                ChoiceOption(d, d.label(l10n)),
            ],
            selected: _difficulty,
            onChanged: (v) => setState(() => _difficulty = v),
          ),
          if (widget.quiz) ...[
            const SizedBox(height: 16),
            Text(l10n.learnQuestionType, style: AppText.bodyMedium),
            const SizedBox(height: 8),
            _TypeOption(
              key: const Key('learn_type_multipleChoice'),
              icon: Icons.checklist_rounded,
              title: l10n.learnMultipleChoice,
              body: l10n.learnMultipleChoiceBody,
              selected: _types.contains(QuizQuestionType.multipleChoice),
              onTap: () => _toggle(QuizQuestionType.multipleChoice),
            ),
            const SizedBox(height: 8),
            _TypeOption(
              key: const Key('learn_type_trueFalse'),
              icon: Icons.rule_rounded,
              title: l10n.learnTrueFalse,
              body: l10n.learnTrueFalseBody,
              selected: _types.contains(QuizQuestionType.trueFalse),
              onTap: () => _toggle(QuizQuestionType.trueFalse),
            ),
            if (!_valid) ...[
              const SizedBox(height: 8),
              Text(
                l10n.learnTypeRequired,
                style: AppText.caption.copyWith(color: AppColors.warn),
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _toggle(QuizQuestionType type) => setState(() {
    if (!_types.remove(type)) _types.add(type);
  });
}

class _TypeOption extends StatelessWidget {
  const _TypeOption({
    required this.icon,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadii.card);
    return Semantics(
      checked: selected,
      child: Material(
        color: selected ? AppColors.accentSoft : AppColors.sf1,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: selected ? AppColors.accent : AppColors.sf3),
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, color: AppColors.mutedDark),
                const SizedBox(width: 12),
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
                const SizedBox(width: 8),
                Icon(
                  selected
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: selected ? AppColors.accent : AppColors.mutedDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
