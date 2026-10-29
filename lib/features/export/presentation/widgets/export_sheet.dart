import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Two steps, then the system share sheet (Files, Telegram, mail…):
/// 1. Uslub — how the text is laid out, times, names, the apostrophe;
/// 2. Format — DOCX, PDF, TXT, SRT, VTT, CSV.
/// Subtitles and CSV split by time, so step 1 does not shape them; the
/// format row says so.
class ExportSheet extends StatelessWidget {
  const ExportSheet({required this.transcript, super.key});

  /// The copy on screen, edits included.
  final Transcript transcript;

  static Future<void> show(BuildContext context, Transcript transcript) {
    return showAppSheet<void>(
      context,
      builder: (_) => ExportSheet(transcript: transcript),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExportCubit>(),
      child: _ExportView(transcript: transcript),
    );
  }
}

class _ExportView extends StatefulWidget {
  const _ExportView({required this.transcript});

  final Transcript transcript;

  @override
  State<_ExportView> createState() => _ExportViewState();
}

class _ExportViewState extends State<_ExportView> {
  bool _formatStep = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ExportCubit, ExportState>(
      builder: (context, state) {
        final cubit = context.read<ExportCubit>();
        final busy = state.status == ExportStatus.sharing;
        final failure = state.failure;
        return AppSheet(
          title:
              '${l10n.exportTitle} · '
              '${_formatStep ? l10n.exportStepFormat : l10n.exportStepStyle}',
          footer: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (failure != null) ...[
                Text(
                  failure.message(l10n),
                  style: const TextStyle(color: AppColors.bad),
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  if (_formatStep) ...[
                    TextButton(
                      key: const Key('export_back'),
                      onPressed: busy
                          ? null
                          : () => setState(() => _formatStep = false),
                      child: Text(l10n.back),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: _formatStep
                        ? FilledButton.icon(
                            key: const Key('export_share'),
                            onPressed: busy
                                ? null
                                : () => cubit.share(widget.transcript),
                            icon: const Icon(Icons.ios_share, size: 18),
                            label: Text(l10n.exportShare),
                          )
                        : FilledButton(
                            key: const Key('export_next'),
                            onPressed: () => setState(() => _formatStep = true),
                            child: Text(l10n.exportNext),
                          ),
                  ),
                ],
              ),
            ],
          ),
          child: _formatStep
              ? _FormatStep(state: state, busy: busy)
              : _StyleStep(
                  state: state,
                  busy: busy,
                  hasSpeakers: widget.transcript.speakers.isNotEmpty,
                ),
        );
      },
    );
  }
}

class _StyleStep extends StatelessWidget {
  const _StyleStep({
    required this.state,
    required this.busy,
    required this.hasSpeakers,
  });

  final ExportState state;
  final bool busy;
  final bool hasSpeakers;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ExportCubit>();
    final options = state.options;
    // «Bitta paragraf» carries no times and no names; the web disables
    // both switches for it.
    final single = options.layout == ExportLayout.single;
    void set(ExportOptions o) {
      if (!busy) cubit.setOptions(o);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ActionGroup(
          title: l10n.exportLayout,
          children: [
            for (final layout in ExportLayout.values)
              ActionRow(
                key: Key('export_layout_${layout.name}'),
                icon: _layoutIcon(layout),
                label: _layoutLabel(l10n, layout),
                onTap: () => set(options.copyWith(layout: layout)),
                trailing: options.layout == layout
                    ? const Icon(Icons.check_rounded, color: AppColors.accent)
                    : const SizedBox(width: 24),
              ),
          ],
        ),
        if (options.layout == ExportLayout.paragraphs) ...[
          const SizedBox(height: 16),
          Text(l10n.exportSentences, style: AppText.muted),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in sentenceCounts)
                ChoiceChip(
                  key: Key('export_sentences_$n'),
                  label: Text(l10n.exportSentenceCount(n)),
                  selected: options.sentences == n,
                  onSelected: busy
                      ? null
                      : (_) => cubit.setOptions(options.copyWith(sentences: n)),
                ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: options.timecodes,
          onChanged: busy || single
              ? null
              : (v) => cubit.setOptions(options.copyWith(timecodes: v)),
          title: Text(l10n.exportTimecodes),
        ),
        if (hasSpeakers)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: options.speakers,
            onChanged: busy || single
                ? null
                : (v) => cubit.setOptions(options.copyWith(speakers: v)),
            title: Text(l10n.exportSpeakers),
          ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: options.plainApostrophe,
          onChanged: busy
              ? null
              : (v) => cubit.setOptions(options.copyWith(plainApostrophe: v)),
          title: Text(l10n.exportPlainApostrophe),
          subtitle: Text(l10n.exportPlainApostropheHint, style: AppText.muted),
        ),
      ],
    );
  }
}

class _FormatStep extends StatelessWidget {
  const _FormatStep({required this.state, required this.busy});

  final ExportState state;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ExportCubit>();
    return ActionGroup(
      children: [
        for (final format in ExportFormat.values)
          ActionRow(
            key: Key('export_${format.extension}'),
            icon: _formatIcon(format),
            label: format.extension.toUpperCase(),
            subtitle: switch (format) {
              ExportFormat.srt || ExportFormat.vtt => l10n.exportTimedOnly,
              ExportFormat.csv => l10n.exportTableHint,
              _ => null,
            },
            onTap: busy ? null : () => cubit.setFormat(format),
            showChevron: false,
            trailing: state.format == format
                ? const Icon(Icons.check_rounded, color: AppColors.accent)
                : const SizedBox(width: 24),
          ),
      ],
    );
  }
}

String _layoutLabel(AppLocalizations l10n, ExportLayout layout) =>
    switch (layout) {
      ExportLayout.segments => l10n.exportLayoutSegments,
      ExportLayout.speaker => l10n.exportLayoutSpeaker,
      ExportLayout.paragraphs => l10n.exportLayoutParagraphs,
      ExportLayout.single => l10n.exportLayoutSingle,
    };

IconData _layoutIcon(ExportLayout layout) => switch (layout) {
  ExportLayout.segments => Icons.view_agenda_outlined,
  ExportLayout.speaker => Icons.people_outline_rounded,
  ExportLayout.paragraphs => Icons.subject_rounded,
  ExportLayout.single => Icons.notes_rounded,
};

IconData _formatIcon(ExportFormat format) => switch (format) {
  ExportFormat.docx || ExportFormat.txt => Icons.description_outlined,
  ExportFormat.pdf => Icons.picture_as_pdf_outlined,
  ExportFormat.srt || ExportFormat.vtt => Icons.subtitles_outlined,
  ExportFormat.csv => Icons.table_chart_outlined,
};
