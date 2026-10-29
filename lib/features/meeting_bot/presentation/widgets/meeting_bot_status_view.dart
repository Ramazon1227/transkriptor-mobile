import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/meeting_bot/application/meeting_bot_cubit.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';

String meetingStatusLabel(AppLocalizations l10n, MeetingBotStatus s) =>
    switch (s) {
      MeetingBotStatus.scheduled => l10n.meetStatusScheduled,
      MeetingBotStatus.joining => l10n.meetStatusJoining,
      MeetingBotStatus.waiting => l10n.meetStatusWaiting,
      MeetingBotStatus.recording => l10n.meetStatusRecording,
      MeetingBotStatus.uploading => l10n.meetStatusUploading,
      MeetingBotStatus.done => l10n.meetStatusDone,
      MeetingBotStatus.failed ||
      MeetingBotStatus.unknown => l10n.meetStatusFailed,
      MeetingBotStatus.denied => l10n.meetStatusDenied,
      MeetingBotStatus.cancelled => l10n.meetStatusCancelled,
    };

/// Which of the five steps a status stands on; null for the endings that
/// are not «done».
int? _stepOf(MeetingBotStatus s) => switch (s) {
  MeetingBotStatus.scheduled || MeetingBotStatus.joining => 0,
  MeetingBotStatus.waiting => 1,
  MeetingBotStatus.recording => 2,
  MeetingBotStatus.uploading => 3,
  MeetingBotStatus.done => 4,
  _ => null,
};

/// One bot, followed: the steps from joining to done, or how it ended.
class MeetingBotStatusView extends StatelessWidget {
  const MeetingBotStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MeetingBotCubit, MeetingBotState>(
      builder: (context, state) {
        final bot = state.active;
        if (bot == null) return const SizedBox.shrink();
        final cubit = context.read<MeetingBotCubit>();
        final step = _stepOf(bot.status);
        final failedEnd = bot.status.isTerminal && step == null;
        final steps = [
          (l10n.meetStatusJoining, null),
          (l10n.meetStatusWaiting, l10n.meetStepWaitingHint),
          (l10n.meetStatusRecording, null),
          (l10n.meetStatusUploading, l10n.meetStepUploadingHint),
          (l10n.meetStatusDone, null),
        ];
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(bot.meetingTitle ?? bot.meetUrl, style: AppText.heading),
            if (bot.botName.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(l10n.meetBotName(bot.botName), style: AppText.caption),
            ],
            const SizedBox(height: 20),
            if (failedEnd)
              _Ending(bot: bot)
            else
              for (var i = 0; i < steps.length; i++)
                _Step(
                  label: steps[i].$1,
                  hint: i == step ? steps[i].$2 : null,
                  done: step != null && (i < step || step == 4),
                  current: i == step && step != 4,
                  last: i == steps.length - 1,
                ),
            if (bot.cancelRequested && !bot.status.isTerminal) ...[
              const SizedBox(height: 12),
              Text(l10n.meetLeaving, style: AppText.caption),
            ],
            if (state.pollFailure != null) ...[
              const SizedBox(height: 12),
              Text(
                l10n.meetPollFailed,
                style: AppText.caption.copyWith(color: AppColors.warn),
              ),
            ],
            if (state.actionFailure != null) ...[
              const SizedBox(height: 12),
              Text(
                state.actionFailure!.message(l10n),
                style: const TextStyle(color: AppColors.bad),
              ),
            ],
            const SizedBox(height: 24),
            if (bot.status == MeetingBotStatus.done && bot.jobId != null)
              FilledButton(
                onPressed: () =>
                    unawaited(context.push(Routes.jobOf(bot.jobId!))),
                child: Text(l10n.meetOpenResult),
              ),
            if (bot.status.isCancellable && !bot.cancelRequested) ...[
              if (bot.status == MeetingBotStatus.recording) ...[
                Text(l10n.meetCancelRecordingNote, style: AppText.caption),
                const SizedBox(height: 8),
              ],
              OutlinedButton(
                onPressed: state.cancelling ? null : cubit.cancel,
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.bad),
                child: state.cancelling
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.meetCancel),
              ),
            ],
            const SizedBox(height: 6),
            TextButton(
              onPressed: cubit.dismiss,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.cotton,
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(l10n.meetNew),
            ),
          ],
        );
      },
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.label,
    required this.hint,
    required this.done,
    required this.current,
    required this.last,
  });

  final String label;
  final String? hint;
  final bool done;
  final bool current;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final Widget dot;
    if (done) {
      dot = const Icon(Icons.check_circle_rounded, color: AppColors.mint);
    } else if (current) {
      dot = const SizedBox.square(
        dimension: 22,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.accent,
          ),
        ),
      );
    } else {
      dot = const Icon(
        Icons.radio_button_unchecked_rounded,
        color: AppColors.sf3,
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              SizedBox(width: 24, height: 24, child: Center(child: dot)),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    color: done ? AppColors.mint : AppColors.sf2,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: current
                        ? AppText.bodyStrong
                        : AppText.body.copyWith(
                            color: done
                                ? AppColors.cotton
                                : AppColors.mutedDark,
                          ),
                  ),
                  if (hint != null) ...[
                    const SizedBox(height: 2),
                    Text(hint!, style: AppText.caption),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Failed, denied or cancelled: the server's own sentence when it has one.
class _Ending extends StatelessWidget {
  const _Ending({required this.bot});

  final MeetingBot bot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cancelled = bot.status == MeetingBotStatus.cancelled;
    final fallback = switch (bot.status) {
      MeetingBotStatus.denied => l10n.meetDeniedDefault,
      MeetingBotStatus.cancelled => l10n.meetCancelledBody,
      _ => l10n.meetFailedDefault,
    };
    final color = cancelled ? AppColors.mutedDark : AppColors.bad;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            meetingStatusLabel(l10n, bot.status),
            style: AppText.bodyStrong.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(bot.errorMessage ?? fallback, style: AppText.body),
        ],
      ),
    );
  }
}
