import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/chat_hints.dart';

extension ChatHintText on ChatHint {
  /// The question as it is shown and sent; the web uses the same texts.
  String text(AppLocalizations l10n) => switch (this) {
    ChatHint.whatSaid => l10n.aiChatHintWhatSaid,
    ChatHint.whoSaid => l10n.aiChatHintWhoSaid,
    ChatHint.decisions => l10n.aiChatHintDecisions,
    ChatHint.openIssues => l10n.aiChatHintOpenIssues,
    ChatHint.proposals => l10n.aiChatHintProposals,
    ChatHint.disagreements => l10n.aiChatHintDisagreements,
    ChatHint.mainPoints => l10n.aiChatHintMainPoints,
    ChatHint.examples => l10n.aiChatHintExamples,
    ChatHint.terms => l10n.aiChatHintTerms,
    ChatHint.whoTalked => l10n.aiChatHintWhoTalked,
    ChatHint.agreements => l10n.aiChatHintAgreements,
    ChatHint.chapters => l10n.aiChatHintChapters,
  };
}
