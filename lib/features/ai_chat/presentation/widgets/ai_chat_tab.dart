import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/confirm_sheet.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_cubit.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/message_bubble.dart';

/// The editor's «AI suhbat» tab: questions about this one transcript,
/// answered from it, with timecodes that move the player. Lives in a tab
/// view under the player, so it fills a bounded height and scrolls on
/// its own; the composer stays at the bottom.
class AiChatTab extends StatelessWidget {
  const AiChatTab({required this.transcriptId, this.onSeek, super.key});

  final String transcriptId;

  /// A timecode chip in an answer was tapped. Null: chips do nothing.
  final ValueChanged<Duration>? onSeek;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<AiChatCubit>();
        unawaited(cubit.load(transcriptId));
        return cubit;
      },
      child: _AiChatView(onSeek: onSeek),
    );
  }
}

class _AiChatView extends StatefulWidget {
  const _AiChatView({this.onSeek});

  final ValueChanged<Duration>? onSeek;

  @override
  State<_AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<_AiChatView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send(String text) async {
    final cubit = context.read<AiChatCubit>();
    if (text.trim().isEmpty || cubit.state.busy) return;
    _controller.clear();
    final accepted = await cubit.send(text);
    // Not accepted: give the question back, unless something new was
    // typed meanwhile.
    if (!accepted && mounted && _controller.text.isEmpty) {
      _controller.text = text;
    }
  }

  Future<void> _clear() async {
    final l10n = context.l10n;
    final cubit = context.read<AiChatCubit>();
    final ok = await showConfirmSheet(
      context,
      title: l10n.aiChatClearTitle,
      message: l10n.aiChatClearBody,
      confirmLabel: l10n.aiChatClearConfirm,
    );
    if (ok) unawaited(cubit.clear());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiChatCubit, AiChatState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(child: _content(context, state)),
            if (state.actionFailure != null || state.pollFailure != null)
              _ErrorStrip(state: state),
            _Composer(
              controller: _controller,
              enabled: state.status == AiChatStatus.success,
              busy: state.busy,
              pending: state.pending,
              onSend: _send,
            ),
          ],
        );
      },
    );
  }

  Widget _content(BuildContext context, AiChatState state) {
    final cubit = context.read<AiChatCubit>();
    switch (state.status) {
      case AiChatStatus.initial:
      case AiChatStatus.loading:
        return const AppLoadingView();
      case AiChatStatus.failure:
        return AppErrorView(
          failure: state.failure ?? const Failure.unknown(),
          onRetry: cubit.reload,
        );
      case AiChatStatus.success:
        if (state.items.isEmpty) {
          return _Suggestions(enabled: !state.busy, onPick: _send);
        }
        final items = state.items.reversed.toList();
        return ListView.separated(
          key: const Key('ai_chat_list'),
          // Newest at the bottom, and the list opens there. The header
          // (privacy note, clear) is the list's last item, so it scrolls
          // away instead of taking height from a short tab.
          reverse: true,
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          itemCount: items.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            if (i == items.length) {
              return _ChatHeader(
                onClear: state.busy ? null : _clear,
                clearing: state.clearing,
              );
            }
            final m = items[i];
            return MessageBubble(
              key: ValueKey(m.id),
              message: m,
              onSeek: widget.onSeek,
              onRetry:
                  m.status == AiMessageStatus.failed &&
                      m.role == AiRole.assistant &&
                      !state.busy
                  ? () => cubit.retry(m.id)
                  : null,
            );
          },
        );
    }
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.onClear, required this.clearing});

  final VoidCallback? onClear;
  final bool clearing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 14,
            color: AppColors.mutedDark,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              l10n.aiChatPrivate,
              style: AppText.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (clearing)
            const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              key: const Key('ai_chat_clear'),
              tooltip: l10n.aiChatClear,
              onPressed: onClear,
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
    );
  }
}

class _Suggestions extends StatelessWidget {
  const _Suggestions({required this.enabled, required this.onPick});

  final bool enabled;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final suggestions = [
      l10n.aiChatSuggestionTopics,
      l10n.aiChatSuggestionWho,
      l10n.aiChatSuggestionDecisions,
    ];
    return ListView(
      key: const Key('ai_chat_empty'),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      children: [
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Icon(Icons.auto_awesome, color: AppColors.mint, size: 22),
        ),
        const SizedBox(height: 8),
        Text(l10n.aiChatIntroTitle, style: AppText.heading),
        const SizedBox(height: 4),
        Text(l10n.aiChatIntro, style: AppText.caption),
        const SizedBox(height: 16),
        for (final s in suggestions)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SuggestionButton(
              label: s,
              onTap: enabled ? () => onPick(s) : null,
            ),
          ),
      ],
    );
  }
}

class _SuggestionButton extends StatelessWidget {
  const _SuggestionButton({required this.label, required this.onTap});

  final String label;
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(child: Text(label, style: AppText.body)),
                const SizedBox(width: 8),
                const Icon(
                  Icons.north_east_rounded,
                  size: 16,
                  color: AppColors.mutedDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorStrip extends StatelessWidget {
  const _ErrorStrip({required this.state});

  final AiChatState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final action = state.actionFailure;
    final text = action != null
        ? switch (action) {
            ServerFailure(statusCode: 409) => l10n.aiChatBusy,
            ServerFailure(statusCode: 503) => l10n.aiChatUnavailable,
            _ => action.message(l10n),
          }
        : l10n.aiChatPollFailed;
    return Container(
      key: const Key('ai_chat_error'),
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
      decoration: BoxDecoration(
        color: AppColors.badSoft,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppText.caption.copyWith(color: AppColors.bad),
            ),
          ),
          if (action != null)
            IconButton(
              tooltip: l10n.close,
              visualDensity: VisualDensity.compact,
              onPressed: context.read<AiChatCubit>().dismissActionFailure,
              icon: const Icon(Icons.close_rounded, size: 18),
            ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.enabled,
    required this.busy,
    required this.pending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool busy;
  final bool pending;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.sf0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  key: const Key('ai_chat_input'),
                  controller: controller,
                  enabled: enabled,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: aiQuestionMaxLength,
                  textInputAction: TextInputAction.send,
                  onSubmitted: busy ? null : onSend,
                  decoration: InputDecoration(
                    hintText: pending
                        ? l10n.aiChatHintPending
                        : l10n.aiChatHint,
                    counterText: '',
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, _) {
                  final canSend =
                      enabled && !busy && value.text.trim().isNotEmpty;
                  return IconButton.filled(
                    key: const Key('ai_chat_send'),
                    tooltip: l10n.aiChatSend,
                    onPressed: canSend ? () => onSend(controller.text) : null,
                    icon: const Icon(Icons.arrow_upward_rounded),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
