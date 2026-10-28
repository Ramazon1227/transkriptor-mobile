import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Format and options, then the system share sheet: the person saves the
/// file to Files or sends it to Telegram, mail, and so on.
class ExportSheet extends StatelessWidget {
  const ExportSheet({required this.transcript, super.key});

  /// The copy on screen, edits included.
  final Transcript transcript;

  static Future<void> show(BuildContext context, Transcript transcript) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
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

class _ExportView extends StatelessWidget {
  const _ExportView({required this.transcript});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ExportCubit, ExportState>(
      builder: (context, state) {
        final cubit = context.read<ExportCubit>();
        final busy = state.status == ExportStatus.sharing;
        final options = state.options;
        final failure = state.failure;
        // «Bitta paragraf» carries no times and no names; the web disables
        // both switches for it.
        final single =
            state.format.usesLayout && options.layout == ExportLayout.single;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.exportTitle, style: AppText.title),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  for (final format in ExportFormat.values)
                    ChoiceChip(
                      key: Key('export_${format.extension}'),
                      label: Text(format.extension.toUpperCase()),
                      selected: state.format == format,
                      onSelected: busy ? null : (_) => cubit.setFormat(format),
                    ),
                ],
              ),
              if (state.format.usesLayout) ...[
                const SizedBox(height: 16),
                Text(l10n.exportLayout, style: AppText.muted),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final layout in ExportLayout.values)
                      ChoiceChip(
                        key: Key('export_layout_${layout.name}'),
                        label: Text(_layoutLabel(l10n, layout)),
                        selected: options.layout == layout,
                        onSelected: busy
                            ? null
                            : (_) => cubit.setOptions(
                                options.copyWith(layout: layout),
                              ),
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
                              : (_) => cubit.setOptions(
                                  options.copyWith(sentences: n),
                                ),
                        ),
                    ],
                  ),
                ],
              ],
              const SizedBox(height: 8),
              if (state.format.usesTimecodeSwitch)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: options.timecodes,
                  onChanged: busy || single
                      ? null
                      : (v) => cubit.setOptions(options.copyWith(timecodes: v)),
                  title: Text(l10n.exportTimecodes),
                ),
              if (transcript.speakers.isNotEmpty &&
                  state.format.usesSpeakerSwitch)
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
                    : (v) => cubit.setOptions(
                        options.copyWith(plainApostrophe: v),
                      ),
                title: Text(l10n.exportPlainApostrophe),
                subtitle: Text(
                  l10n.exportPlainApostropheHint,
                  style: AppText.muted,
                ),
              ),
              if (failure != null) ...[
                const SizedBox(height: 8),
                Text(
                  failure.message(l10n),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const Key('export_share'),
                onPressed: busy ? null : () => cubit.share(transcript),
                icon: const Icon(Icons.ios_share, size: 18),
                label: Text(l10n.exportShare),
              ),
            ],
          ),
        );
      },
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
