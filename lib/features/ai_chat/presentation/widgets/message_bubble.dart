import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/answer_text.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/typing_indicator.dart';

/// One chat line. The person's questions sit on the right; the model's
/// answers on the left under a small mint «AI» marker — mint is how the
/// reader tells the machine's words from a person's. Long-press copies.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    this.onSeek,
    this.onRetry,
    super.key,
  });

  final AiMessage message;
  final ValueChanged<Duration>? onSeek;

  /// Shown under a failed answer; null hides it (e.g. while busy).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final mine = message.role == AiRole.user;
    final maxWidth = MediaQuery.sizeOf(context).width * .86;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: mine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!mine) const _AiMarker(),
            GestureDetector(
              onLongPress: _copyable ? () => _copy(context) : null,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 9, 12, 10),
                decoration: BoxDecoration(
                  color: mine ? AppColors.sf2 : AppColors.sf1,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: message.status == AiMessageStatus.failed
                      ? const Border(
                          left: BorderSide(color: AppColors.bad, width: 3),
                        )
                      : null,
                ),
                child: _body(context, mine),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _copyable =>
      message.content.isNotEmpty && message.status == AiMessageStatus.done;

  Widget _body(BuildContext context, bool mine) {
    final l10n = context.l10n;
    if (mine) {
      return Text(
        message.content,
        style: AppText.body.copyWith(
          color: message.local ? AppColors.mutedDark : AppColors.cotton,
        ),
      );
    }
    switch (message.status) {
      case AiMessageStatus.pending:
        return Semantics(
          liveRegion: true,
          label: l10n.aiChatThinking,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TypingIndicator(),
              ),
              Text(l10n.aiChatThinking, style: AppText.caption),
            ],
          ),
        );
      case AiMessageStatus.failed:
        final onRetry = this.onRetry;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.error ?? l10n.aiChatAnswerFailed,
              style: AppText.body.copyWith(color: AppColors.bad),
            ),
            if (onRetry != null)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  key: Key('ai_retry_${message.id}'),
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(l10n.aiChatResend),
                ),
              ),
          ],
        );
      case AiMessageStatus.done:
      case AiMessageStatus.unknown:
        return AnswerText(text: message.content, onSeek: onSeek);
    }
  }

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final copied = context.l10n.shareCopied;
    await HapticFeedback.selectionClick();
    await Clipboard.setData(ClipboardData(text: message.content));
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(copied)));
  }
}

class _AiMarker extends StatelessWidget {
  const _AiMarker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 13, color: AppColors.mint),
          const SizedBox(width: 4),
          Text(
            context.l10n.aiMarker,
            style: AppText.label.copyWith(color: AppColors.mint),
          ),
        ],
      ),
    );
  }
}
