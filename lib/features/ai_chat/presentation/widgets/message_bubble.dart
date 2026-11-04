import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/rich_text.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/answer_text.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/typing_indicator.dart';

/// One chat line. The person's questions sit on the right; the model's
/// answers on the left under a small mint «AI» marker — mint is how the
/// reader tells the machine's words from a person's. A finished answer has
/// «Nusxalash» under it (long-press copies too).
///
/// A stopped answer is `FAILED` with the part written so far: the text
/// stays, with the server's note under it.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    this.onSeek,
    this.onRetry,
    super.key,
  });

  final AiMessage message;
  final ValueChanged<Duration>? onSeek;

  /// The last answer only: «Qayta yozdirish» under a finished answer,
  /// «Qayta yuborish» under a failed or stopped one. Null hides it (an
  /// older answer, or busy).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final mine = message.role == AiRole.user;
    final maxWidth = MediaQuery.sizeOf(context).width * .86;
    final failedEmpty =
        message.status == AiMessageStatus.failed && message.content.isEmpty;
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
                  border: failedEmpty
                      ? const Border(
                          left: BorderSide(color: AppColors.bad, width: 3),
                        )
                      : null,
                ),
                child: _body(context, mine),
              ),
            ),
            if (!mine) _actions(context),
          ],
        ),
      ),
    );
  }

  bool get _copyable =>
      message.content.isNotEmpty && message.status != AiMessageStatus.pending;

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
      case AiMessageStatus.pending when message.content.isNotEmpty:
        // Not a live region: the text grows every second and would be
        // read out again each time.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnswerText(text: message.content, onSeek: onSeek),
            const SizedBox(height: 6),
            Row(
              key: Key('ai_writing_${message.id}'),
              mainAxisSize: MainAxisSize.min,
              children: [
                const TypingIndicator(),
                const SizedBox(width: 8),
                Text(l10n.aiChatWriting, style: AppText.caption),
              ],
            ),
          ],
        );
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
      case AiMessageStatus.failed when message.content.isNotEmpty:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnswerText(text: message.content, onSeek: onSeek),
            const SizedBox(height: 6),
            Text(
              message.error ?? l10n.aiChatStopped,
              key: Key('ai_stopped_${message.id}'),
              style: AppText.caption,
            ),
          ],
        );
      case AiMessageStatus.failed:
        return Text(
          message.error ?? l10n.aiChatAnswerFailed,
          style: AppText.body.copyWith(color: AppColors.bad),
        );
      case AiMessageStatus.done:
      case AiMessageStatus.unknown:
        return AnswerText(text: message.content, onSeek: onSeek);
    }
  }

  Widget _actions(BuildContext context) {
    final l10n = context.l10n;
    final onRetry = this.onRetry;
    if (!_copyable && onRetry == null) return const SizedBox.shrink();
    return Wrap(
      spacing: 4,
      children: [
        if (_copyable)
          TextButton.icon(
            key: Key('ai_copy_${message.id}'),
            onPressed: () => _copy(context),
            icon: const Icon(Icons.copy_rounded, size: 16),
            label: Text(l10n.aiChatCopy),
          ),
        if (onRetry != null)
          TextButton.icon(
            key: Key('ai_retry_${message.id}'),
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(
              message.status == AiMessageStatus.done
                  ? l10n.aiChatRewrite
                  : l10n.aiChatResend,
            ),
          ),
      ],
    );
  }

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final copied = context.l10n.shareCopied;
    await HapticFeedback.selectionClick();
    await Clipboard.setData(ClipboardData(text: richPlain(message.content)));
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
