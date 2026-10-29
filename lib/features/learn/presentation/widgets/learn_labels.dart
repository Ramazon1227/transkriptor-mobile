import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';

extension LearnDifficultyLabel on LearnDifficulty {
  String label(AppLocalizations l10n) => switch (this) {
    LearnDifficulty.easy => l10n.learnEasy,
    LearnDifficulty.medium => l10n.learnMedium,
    LearnDifficulty.hard => l10n.learnHard,
  };
}

extension QuizQuestionLabels on QuizQuestion {
  /// The text of answer [i]: an option, or «Toʻgʻri» / «Notoʻgʻri».
  String answerLabel(AppLocalizations l10n, int i) =>
      type == QuizQuestionType.trueFalse
      ? (i == 0 ? l10n.learnTrue : l10n.learnFalse)
      : options[i];
}
