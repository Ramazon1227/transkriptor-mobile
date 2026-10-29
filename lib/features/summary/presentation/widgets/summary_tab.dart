import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/confirm_sheet.dart';
import 'package:transkriptor_uz/core/widgets/demo_banner.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/note_body.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/summary_sections.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/template_picker_sheet.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The editor's «Xulosa» tab. Real on a server with the summary API; on
/// one without it the summary is the demo sample and says so
/// (`DemoBanner`). Lives in a tab view under the player: fills a bounded
/// height, scrolls itself.
class SummaryTab extends StatelessWidget {
  const SummaryTab({required this.transcript, super.key});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<SummaryCubit>();
        unawaited(cubit.start(transcript));
        return cubit;
      },
      child: _SummaryView(transcript: transcript),
    );
  }
}

class _SummaryView extends StatelessWidget {
  const _SummaryView({required this.transcript});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<SummaryCubit, SummaryState>(
      listenWhen: (a, b) =>
          a.noteStatus != b.noteStatus ||
          (b.actionFailure != null && a.actionFailure != b.actionFailure),
      listener: (context, state) {
        final action = state.actionFailure;
        final text = action != null
            ? summaryFailureText(l10n, action)
            : switch (state.noteStatus) {
                NoteSaveStatus.saved => l10n.summaryNoteSaved,
                NoteSaveStatus.failure =>
                  (state.noteFailure ?? const Failure.unknown()).message(l10n),
                _ => null,
              };
        if (text == null) return;
        ScaffoldMessenger.maybeOf(context)
          ?..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(text)));
      },
      builder: (context, state) {
        return ListView(
          key: const Key('summary_list'),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            if (state.sample) ...[
              DemoBanner(message: l10n.summaryDemoBanner),
              const SizedBox(height: 12),
            ],
            if (state.status == SummaryStatus.tooShort)
              _Notice(
                key: const Key('summary_too_short'),
                icon: Icons.short_text_rounded,
                text: l10n.summaryTooShort,
              )
            else ...[
              _TemplateChip(state: state),
              const SizedBox(height: 12),
              _body(context, state),
            ],
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context, SummaryState state) {
    final l10n = context.l10n;
    final cubit = context.read<SummaryCubit>();
    switch (state.status) {
      case SummaryStatus.tooShort:
        return const SizedBox.shrink();
      case SummaryStatus.idle:
        return _Empty(onCreate: cubit.generate);
      case SummaryStatus.loading:
        return _Notice(
          key: const Key('summary_loading'),
          text: l10n.summaryLoading,
          busy: true,
        );
      case SummaryStatus.generating:
        return _Notice(
          key: const Key('summary_generating'),
          text: l10n.summaryGenerating,
          busy: true,
        );
      case SummaryStatus.failure:
        final failure = state.failure;
        // No request failure: the server could not write it and said why.
        final text = failure != null
            ? summaryFailureText(l10n, failure)
            : state.summary?.error ?? l10n.summaryFailedDefault;
        return Column(
          key: const Key('summary_failure'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: AppText.body.copyWith(color: AppColors.bad)),
            const SizedBox(height: 8),
            OutlinedButton(
              key: const Key('summary_retry'),
              onPressed: cubit.retry,
              child: Text(l10n.retry),
            ),
          ],
        );
      case SummaryStatus.success:
        final summary = state.summary;
        if (summary == null) return const SizedBox.shrink();
        return _SummaryCard(
          summary: summary,
          transcript: transcript,
          saving: state.noteStatus == NoteSaveStatus.saving,
        );
    }
  }
}

class _TemplateChip extends StatelessWidget {
  const _TemplateChip({required this.state});

  final SummaryState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = state.template?.name ?? l10n.summaryTemplateDefault;
    final busy =
        state.status == SummaryStatus.generating ||
        state.status == SummaryStatus.loading;
    return Row(
      children: [
        Text(l10n.summaryTemplateLabel, style: AppText.caption),
        const SizedBox(width: 8),
        Flexible(
          child: ActionChip(
            key: const Key('summary_template_chip'),
            onPressed: busy ? null : () => showTemplatePicker(context),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.expand_more_rounded, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      key: const Key('summary_empty'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.mint, size: 22),
          const SizedBox(height: 8),
          Text(l10n.summaryEmptyTitle, style: AppText.heading),
          const SizedBox(height: 4),
          Text(l10n.summaryEmptyBody, style: AppText.caption),
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('summary_create'),
            onPressed: onCreate,
            child: Text(l10n.summaryCreate),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.summary,
    required this.transcript,
    required this.saving,
  });

  final Summary summary;
  final Transcript transcript;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<SummaryCubit>();
    final heading = summary.templateName ?? l10n.summaryTemplateDefault;
    final sections = resolveSectionTitles(l10n, summary.sections);
    final fromServer = summary.body != null;
    return Column(
      key: const Key('summary_result'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.auto_awesome, color: AppColors.mint, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(heading, style: AppText.heading)),
          ],
        ),
        if (fromServer)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: NoteBody(blocks: summary.blocks),
          )
        else
          SummarySections(sections: sections),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              key: const Key('summary_copy'),
              onPressed: () => _copy(
                context,
                fromServer
                    ? summaryBlocksPlainText(heading, summary.blocks)
                    : summaryPlainText(heading, sections),
              ),
              icon: const Icon(Icons.copy_rounded, size: 18),
              label: Text(l10n.summaryCopy),
            ),
            OutlinedButton.icon(
              key: const Key('summary_regenerate'),
              onPressed: cubit.generate,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(l10n.summaryRegenerate),
            ),
            OutlinedButton.icon(
              key: const Key('summary_save_note'),
              onPressed: saving
                  ? null
                  : () => cubit.saveAsNote(
                      title: l10n.summaryNoteTitle(transcript.title),
                      sections: sections,
                    ),
              icon: saving
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.note_add_outlined, size: 18),
              label: Text(l10n.summarySaveNote),
            ),
            OutlinedButton.icon(
              key: const Key('summary_delete'),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.bad),
              onPressed: () => _delete(context),
              icon: const Icon(Icons.delete_outline_rounded, size: 18),
              label: Text(l10n.summaryDelete),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _copy(BuildContext context, String text) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final copied = context.l10n.shareCopied;
    await Clipboard.setData(ClipboardData(text: text));
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(copied)));
  }

  Future<void> _delete(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<SummaryCubit>();
    final ok = await showConfirmSheet(
      context,
      title: l10n.summaryDeleteTitle,
      message: l10n.summaryDeleteBody,
      confirmLabel: l10n.summaryDelete,
    );
    if (ok) await cubit.delete();
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text, this.icon, this.busy = false, super.key});

  final String text;
  final IconData? icon;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          if (busy)
            const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (icon != null)
            Icon(icon, color: AppColors.mutedDark),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppText.body)),
        ],
      ),
    );
  }
}

/// What a failed summary request means to the person.
String summaryFailureText(AppLocalizations l10n, Failure failure) =>
    switch (failure) {
      ServerFailure(statusCode: 409) => l10n.summaryBusy,
      ServerFailure(statusCode: 503) => l10n.summaryUnavailable,
      ServerFailure(statusCode: 403) => l10n.summaryForbidden,
      _ => failure.message(l10n),
    };
