import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/demo_banner.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/capture/application/dictation_cubit.dart';

/// «Jonli diktovka»: text appears while the person speaks. The screen is
/// real; its source is a demo until the STT service streams (see
/// `DemoDictationRepository`), so the demo banner stays on.
class DictationPage extends StatelessWidget {
  const DictationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DictationCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.sourceDictationTitle)),
        body: ContentWidth(
          child: WorkspaceGate(
            builder: (context, workspaceId) =>
                _DictationView(workspaceId: workspaceId),
          ),
        ),
      ),
    );
  }
}

class _DictationView extends StatelessWidget {
  const _DictationView({required this.workspaceId});

  final String workspaceId;

  List<String> _samples(AppLocalizations l10n) => [
    l10n.dictationSample1,
    l10n.dictationSample2,
    l10n.dictationSample3,
    l10n.dictationSample4,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<DictationCubit, DictationState>(
      listenWhen: (prev, next) =>
          prev.status != next.status || prev.failure != next.failure,
      listener: (context, state) {
        final failure = state.failure;
        if (state.status == DictationStatus.saved) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.dictationSaved)));
        } else if (failure != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(failure.message(l10n))));
        }
      },
      builder: (context, state) {
        final cubit = context.read<DictationCubit>();
        final listening = state.status == DictationStatus.listening;
        final hasText = state.finals.isNotEmpty;
        final stopped =
            state.status == DictationStatus.stopped ||
            state.status == DictationStatus.saving ||
            state.status == DictationStatus.saved;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            DemoBanner(message: l10n.dictationBanner),
            const SizedBox(height: 16),
            Row(
              children: [
                const _RealtimeBadge(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    listening ? l10n.dictationListening : '',
                    style: AppText.caption,
                  ),
                ),
                Text(
                  Formatters.timecode(state.elapsed),
                  style: AppText.mono.copyWith(
                    fontSize: 16,
                    color: AppColors.cotton,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _TextArea(state: state),
            const SizedBox(height: 24),
            Center(
              child: _MicButton(
                listening: listening,
                label: listening ? l10n.dictationStop : l10n.dictationStart,
                onPressed: switch (state.status) {
                  DictationStatus.listening => cubit.stop,
                  DictationStatus.saving => null,
                  _ => () => cubit.start(samples: _samples(l10n)),
                },
              ),
            ),
            if (state.status == DictationStatus.idle) ...[
              const SizedBox(height: 16),
              Text(
                l10n.dictationIntro,
                textAlign: TextAlign.center,
                style: AppText.caption,
              ),
            ],
            if (stopped && hasText) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: state.status == DictationStatus.stopped
                    ? () => cubit.saveAsNote(
                        workspaceId: workspaceId,
                        title: l10n.dictationNoteTitle(
                          Formatters.date(DateTime.now()),
                        ),
                      )
                    : null,
                child: state.status == DictationStatus.saving
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.dictationSaveNote),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: state.text));
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.dictationCopied)),
                      );
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: Text(l10n.dictationCopy),
                  ),
                  TextButton.icon(
                    onPressed: state.status == DictationStatus.saving
                        ? null
                        : () => unawaited(cubit.discard()),
                    style: TextButton.styleFrom(foregroundColor: AppColors.bad),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: Text(l10n.dictationDiscard),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}

/// Mint: a machine marker — the text is the model's, live.
class _RealtimeBadge extends StatelessWidget {
  const _RealtimeBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.mint.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        context.l10n.sourceRealtimeBadge.toUpperCase(),
        style: AppText.label.copyWith(color: AppColors.mint, letterSpacing: .4),
      ),
    );
  }
}

/// Settled sentences in normal text, the one still being heard muted.
class _TextArea extends StatelessWidget {
  const _TextArea({required this.state});

  final DictationState state;

  @override
  Widget build(BuildContext context) {
    final empty = state.finals.isEmpty && state.partial.isEmpty;
    return Container(
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: empty
          ? Text(context.l10n.dictationEmpty, style: AppText.caption)
          : Text.rich(
              TextSpan(
                style: AppText.body.copyWith(color: AppColors.cotton),
                children: [
                  for (final f in state.finals) TextSpan(text: '$f '),
                  if (state.partial.isNotEmpty)
                    TextSpan(
                      text: state.partial,
                      style: const TextStyle(color: AppColors.mutedDark),
                    ),
                ],
              ),
            ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.listening,
    required this.label,
    required this.onPressed,
  });

  final bool listening;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: Material(
            color: onPressed == null ? AppColors.sf1 : AppColors.accent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: SizedBox.square(
                dimension: 88,
                child: Icon(
                  listening ? Icons.stop_rounded : Icons.mic_rounded,
                  size: 40,
                  color: AppColors.accentText,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppText.caption),
      ],
    );
  }
}
