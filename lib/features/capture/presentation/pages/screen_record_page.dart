import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/capture/application/screen_capture_cubit.dart';
import 'package:transkriptor_uz/features/recorder/presentation/widgets/level_meter.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

/// «Ekranni yozish»: what the phone plays (audio only), optionally with
/// the microphone. Android 10+; elsewhere the page says why instead of
/// offering a button that would silently do nothing.
class ScreenRecordPage extends StatelessWidget {
  const ScreenRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<ScreenCaptureCubit>();
        unawaited(cubit.init());
        return cubit;
      },
      child: const _ScreenRecordView(),
    );
  }
}

class _ScreenRecordView extends StatelessWidget {
  const _ScreenRecordView();

  static bool _running(ScreenCaptureStatus s) =>
      s == ScreenCaptureStatus.recording ||
      s == ScreenCaptureStatus.starting ||
      s == ScreenCaptureStatus.stopping;

  static Future<void> _confirmCancel(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<ScreenCaptureCubit>();
    final yes = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.screenCancelTitle),
        content: Text(l10n.screenCancelBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.recorderKeep),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.bad),
            child: Text(l10n.recorderDiscardConfirm),
          ),
        ],
      ),
    );
    if (yes != true || !context.mounted) return;
    await cubit.cancel();
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<ScreenCaptureCubit, ScreenCaptureState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        final recording = state.recording;
        if (state.status != ScreenCaptureStatus.done || recording == null) {
          return;
        }
        // Stopped by itself but kept what it had: say so on the way.
        if (state.failure != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.screenKeptPartial)));
        }
        final title = l10n.screenRecordingName(Formatters.date(DateTime.now()));
        context.pushReplacement(
          Routes.send,
          extra: PendingFile(
            path: recording.path,
            fileName: '$title.m4a',
            sizeBytes: recording.sizeBytes,
            source: UploadSource.recording,
            duration: recording.duration,
          ),
        );
      },
      builder: (context, state) {
        final running = _running(state.status);
        final Widget body;
        if (state.supported == null) {
          body = const AppLoadingView();
        } else if (state.supported == false) {
          body = const _Unsupported();
        } else if (running || state.status == ScreenCaptureStatus.done) {
          body = _Recording(state: state);
        } else {
          body = _Setup(state: state);
        }
        return PopScope(
          canPop: !running,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && state.status == ScreenCaptureStatus.recording) {
              unawaited(_confirmCancel(context));
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.sourceScreenTitle),
              leading: IconButton(
                tooltip: l10n.close,
                icon: const Icon(Icons.close_rounded),
                onPressed: switch (state.status) {
                  ScreenCaptureStatus.recording => () => _confirmCancel(
                    context,
                  ),
                  ScreenCaptureStatus.starting ||
                  ScreenCaptureStatus.stopping => null,
                  _ => () => context.pop(),
                },
              ),
            ),
            body: ContentWidth(child: SafeArea(child: body)),
          ),
        );
      },
    );
  }
}

/// iOS, or Android below 10.
class _Unsupported extends StatelessWidget {
  const _Unsupported();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        const Center(child: SourceIcon(source: CaptureSource.screen, size: 64)),
        const SizedBox(height: 20),
        Text(
          l10n.screenUnsupportedTitle,
          textAlign: TextAlign.center,
          style: AppText.title,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.screenUnsupportedBody,
          textAlign: TextAlign.center,
          style: AppText.caption,
        ),
        const SizedBox(height: 28),
        OutlinedButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(l10n.back),
        ),
      ],
    );
  }
}

/// Before starting: what is and is not captured, the microphone switch,
/// and — after a failed try — exactly why.
class _Setup extends StatefulWidget {
  const _Setup({required this.state});

  final ScreenCaptureState state;

  @override
  State<_Setup> createState() => _SetupState();
}

class _SetupState extends State<_Setup> {
  late bool _withMic = widget.state.withMic;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final failure = widget.state.status == ScreenCaptureStatus.failure
        ? widget.state.failure
        : null;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Text(l10n.screenIntro, style: AppText.body),
        const SizedBox(height: 16),
        _Point(icon: Icons.check_rounded, text: l10n.screenWhatYes),
        _Point(icon: Icons.call_end_rounded, text: l10n.screenWhatNoCalls),
        _Point(icon: Icons.block_rounded, text: l10n.screenWhatBlocked),
        _Point(icon: Icons.videocam_off_rounded, text: l10n.screenWhatNoVideo),
        const SizedBox(height: 12),
        Material(
          color: AppColors.sf1,
          borderRadius: BorderRadius.circular(AppRadii.card),
          clipBehavior: Clip.antiAlias,
          child: SwitchListTile(
            value: _withMic,
            onChanged: (v) => setState(() => _withMic = v),
            title: Text(l10n.screenWithMic),
            subtitle: Text(l10n.screenWithMicBody, style: AppText.caption),
          ),
        ),
        if (failure != null) ...[
          const SizedBox(height: 20),
          _FailureNote(failure: failure),
        ],
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () =>
              context.read<ScreenCaptureCubit>().start(withMic: _withMic),
          icon: const Icon(Icons.fiber_manual_record_rounded),
          label: Text(failure == null ? l10n.screenStart : l10n.retry),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.screenConsentNote,
          textAlign: TextAlign.center,
          style: AppText.caption,
        ),
      ],
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.mutedDark),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppText.caption)),
        ],
      ),
    );
  }
}

/// The failure's own sentence, then what to do about it.
class _FailureNote extends StatelessWidget {
  const _FailureNote({required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hint = switch (failure) {
      CaptureFailure(reason: CaptureError.consentDenied) =>
        l10n.screenHintConsent,
      PermissionDeniedFailure() => l10n.screenHintMic,
      CaptureFailure(reason: CaptureError.busy) => l10n.screenHintBusy,
      CaptureFailure(reason: CaptureError.captureFailed) ||
      StorageFailure() => l10n.screenHintFailed,
      _ => null,
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
        border: const Border(left: BorderSide(color: AppColors.bad, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(failure.message(l10n), style: AppText.bodyStrong),
          if (hint != null) ...[
            const SizedBox(height: 6),
            Text(hint, style: AppText.caption),
          ],
        ],
      ),
    );
  }
}

/// Starting (consent dialog), recording, stopping.
class _Recording extends StatelessWidget {
  const _Recording({required this.state});

  final ScreenCaptureState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ScreenCaptureCubit>();
    final recording = state.status == ScreenCaptureStatus.recording;
    final waiting = switch (state.status) {
      ScreenCaptureStatus.starting => l10n.screenStarting,
      ScreenCaptureStatus.stopping ||
      ScreenCaptureStatus.done => l10n.screenStopping,
      _ => null,
    };
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        Center(
          child: Text(
            Formatters.timecode(state.elapsed),
            style: AppText.mono
                .copyWith(fontSize: 48, color: AppColors.cotton)
                .weighted(FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          waiting ??
              (state.withMic ? l10n.screenWithMicOn : l10n.recorderRecording),
          textAlign: TextAlign.center,
          style: AppText.caption,
        ),
        const SizedBox(height: 28),
        SizedBox(height: 100, child: LevelMeter(levels: state.levels)),
        if (recording && state.playbackSilent) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sf1,
              borderRadius: BorderRadius.circular(AppRadii.segment),
              border: const Border(
                left: BorderSide(color: AppColors.warn, width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.screenSilentTitle, style: AppText.bodyStrong),
                const SizedBox(height: 4),
                Text(l10n.screenSilentBody, style: AppText.caption),
              ],
            ),
          ),
        ],
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: recording ? cubit.stop : null,
          icon: waiting != null
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.stop_rounded),
          label: Text(l10n.recorderStop),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: recording
              ? () => _ScreenRecordView._confirmCancel(context)
              : null,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.cotton,
            minimumSize: const Size.fromHeight(48),
          ),
          child: Text(l10n.cancel),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.screenRecordingHint,
          textAlign: TextAlign.center,
          style: AppText.caption,
        ),
      ],
    );
  }
}
