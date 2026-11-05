import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';

/// The sentence for a refusal of the «Qoʻshimcha sozlamalar» panel.
String advancedProblemText(AppLocalizations l10n, AdvancedProblem problem) =>
    switch (problem) {
      TermTooLong(:final start) => l10n.advancedErrTermTooLong(
        start,
        AdvancedRules.maxTermLength,
      ),
      TooManyTerms(:final count) => l10n.advancedErrTooManyTerms(
        AdvancedRules.maxTerms,
        count,
      ),
      HintNoName() => l10n.advancedErrHintNoName,
      HintNameTooLong() => l10n.advancedErrHintNameTooLong(
        AdvancedRules.maxHintLabel,
      ),
      HintEndBeforeStart() => l10n.advancedErrHintOrder,
      HintTooShort() => l10n.advancedErrHintShort,
      HintTooLong() => l10n.advancedErrHintLong,
      TooManyHints() => l10n.advancedErrTooManyHints(AdvancedRules.maxHints),
      HintOverlap(:final name) => l10n.advancedErrHintOverlap(name),
      TooManyPeople() => l10n.advancedErrTooManyPeople(AdvancedRules.maxPeople),
      MorePeopleThanSpeakers(:final speakers, :final people) =>
        l10n.advancedErrMorePeople(speakers, people),
      HintBadTime() => l10n.advancedErrBadTime,
      HintPastEnd() => l10n.advancedErrPastEnd,
      PeopleExceedSpeakers(:final people, :final speakers) =>
        l10n.advancedErrPeopleExceed(people, speakers),
    };
