import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart';
import 'package:transkriptor_uz/features/recorder/presentation/widgets/level_meter.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

class RecorderPage extends StatelessWidget {
  const RecorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Recording starts on open: the person tapped "record" to get here.
      create: (_) {
        final cubit = getIt<RecorderCubit>();
        unawaited(cubit.start());
        return cubit;
      },
      child: const _RecorderView(),
    );
  }
}

class _RecorderView extends StatelessWidget {
  const _RecorderView();

  bool _active(RecorderStatus s) =>
      s == RecorderStatus.recording || s == RecorderStatus.paused;

  Future<void> _confirmDiscard(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<RecorderCubit>();
    final discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.recorderDiscardTitle),
        content: Text(l10n.recorderDiscardBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.recorderKeep),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: Text(l10n.recorderDiscardConfirm),
          ),
        ],
      ),
    );
    if (discard != true || !context.mounted) return;
    await cubit.discard();
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<RecorderCubit, RecorderState>(
      listenWhen: (prev, next) =>
          prev.status != next.status || prev.failure != next.failure,
      listener: (context, state) {
        // A failed pause or resume keeps recording; say so, briefly.
        final failure = state.failure;
        if (failure != null && state.status != RecorderStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message(context.l10n))),
          );
        }
        final recording = state.recording;
        if (state.status == RecorderStatus.done && recording != null) {
          final title = context.l10n.recordingName(
            Formatters.date(DateTime.now()),
          );
          context.pushReplacement(
            Routes.send,
            extra: PendingFile(
              path: recording.path,
              // The extension comes from the file the recorder wrote.
              fileName: '$title.m4a',
              sizeBytes: recording.sizeBytes,
              source: UploadSource.recording,
              duration: recording.duration,
            ),
          );
        }
      },
      builder: (context, state) {
        final active = _active(state.status);
        // Starting (permission dialog) and stopping (file being closed)
        // cannot be left halfway: the mic would stay on, or the recording
        // would be lost.
        final settling =
            state.status == RecorderStatus.starting ||
            state.status == RecorderStatus.stopping;
        return PopScope(
          canPop: !active && !settling,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && active) unawaited(_confirmDiscard(context));
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                tooltip: l10n.close,
                icon: const Icon(Icons.close_rounded),
                onPressed: settling
                    ? null
                    : () => active ? _confirmDiscard(context) : context.pop(),
              ),
              title: _StatusTitle(status: state.status),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      Formatters.timecode(state.elapsed),
                      style: AppText.mono.copyWith(
                        fontSize: 52,
                        color: AppColors.cotton,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.recorderFormat.toUpperCase(),
                      style: AppText.label,
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      height: 120,
                      child: LevelMeter(levels: state.levels),
                    ),
                    if (state.status == RecorderStatus.failure) ...[
                      const SizedBox(height: 24),
                      Text(
                        state.failure!.message(l10n),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () => context.read<RecorderCubit>().start(),
                        child: Text(l10n.retry),
                      ),
                    ],
                    const Spacer(),
                    _Controls(state: state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatusTitle extends StatelessWidget {
  const _StatusTitle({required this.status});

  final RecorderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (String text, Color? dot) = switch (status) {
      RecorderStatus.recording => (l10n.recorderRecording, AppColors.warn),
      RecorderStatus.paused => (l10n.recorderPaused, AppColors.mutedDark),
      RecorderStatus.starting => (l10n.recorderStarting, null),
      _ => (l10n.recorderReady, null),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (dot != null) ...[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
        ],
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({required this.state});

  final RecorderState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<RecorderCubit>();
    final active =
        state.status == RecorderStatus.recording ||
        state.status == RecorderStatus.paused;
    final paused = state.status == RecorderStatus.paused;
    final stopping = state.status == RecorderStatus.stopping;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Keeps the stop button centred.
        const SizedBox(width: 72),
        _RoundButton(
          size: 80,
          label: l10n.recorderStop,
          background: AppColors.accent,
          foreground: AppColors.accentText,
          onPressed: active && !stopping ? cubit.stop : null,
          child: stopping
              ? const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accentText,
                  ),
                )
              : const Icon(Icons.stop_rounded, size: 36),
        ),
        _RoundButton(
          size: 60,
          label: paused ? l10n.recorderResume : l10n.recorderPause,
          background: AppColors.sf2,
          foreground: AppColors.cotton,
          onPressed: active ? cubit.togglePause : null,
          child: Icon(
            paused ? Icons.fiber_manual_record_rounded : Icons.pause_rounded,
            color: paused ? AppColors.warn : null,
          ),
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.size,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onPressed,
    required this.child,
  });

  final double size;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return SizedBox(
      width: 72 + (size > 72 ? size - 72 : 0),
      child: Column(
        children: [
          Semantics(
            button: true,
            label: label,
            excludeSemantics: true,
            child: Material(
              color: enabled ? background : AppColors.sf1,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPressed,
                child: SizedBox.square(
                  dimension: size,
                  child: IconTheme(
                    data: IconThemeData(
                      color: enabled ? foreground : AppColors.mutedDark,
                    ),
                    child: Center(child: child),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppText.muted.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
