import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_empty_view.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_text_sheet.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/segment_tile.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/speaker_filter_bar.dart';

class TranscriptPage extends StatelessWidget {
  const TranscriptPage({required this.transcriptId, super.key});

  final String transcriptId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<TranscriptCubit>();
        unawaited(cubit.load(transcriptId));
        return cubit;
      },
      child: _TranscriptView(transcriptId: transcriptId),
    );
  }
}

class _TranscriptView extends StatelessWidget {
  const _TranscriptView({required this.transcriptId});

  final String transcriptId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TranscriptCubit, TranscriptState>(
        builder: (context, state) {
          final transcript = state.transcript;
          return switch (state.status) {
            TranscriptStatus.initial ||
            TranscriptStatus.loading => const AppLoadingView(),
            TranscriptStatus.failure => AppErrorView(
              failure: state.failure!,
              onRetry: () => context.read<TranscriptCubit>().load(transcriptId),
            ),
            TranscriptStatus.empty => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (transcript != null) _Header(transcript: transcript),
                Expanded(child: AppEmptyView(message: l10n.transcriptEmpty)),
              ],
            ),
            TranscriptStatus.success => _Body(state: state),
          };
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.transcript});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final duration = transcript.duration;
    final meta = [
      if (duration != null) Formatters.timecode(duration),
      if (transcript.speakers.isNotEmpty)
        l10n.transcriptSpeakers(transcript.speakers.length),
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(transcript.title, style: AppText.title),
          if (meta.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(meta, style: AppText.mono),
          ],
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final TranscriptState state;

  Future<void> _editText(BuildContext context, Segment segment) {
    final l10n = context.l10n;
    return EditTextSheet.show(
      context,
      EditTextSheet(
        title: l10n.transcriptEditSegment,
        initial: segment.text,
        multiline: true,
        tooLong: EditRules.segmentTextTooLong,
        tooLongMessage: l10n.transcriptTextTooLong,
        onSave: (cubit, text) => cubit.saveSegmentText(segment.id, text),
      ),
    );
  }

  Future<void> _rename(BuildContext context, Speaker speaker) {
    final l10n = context.l10n;
    return EditTextSheet.show(
      context,
      EditTextSheet(
        title: l10n.transcriptRenameSpeaker,
        initial: speaker.label,
        multiline: false,
        tooLong: EditRules.speakerLabelTooLong,
        tooLongMessage: l10n.transcriptLabelTooLong,
        onSave: (cubit, label) => cubit.renameSpeaker(speaker.id, label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transcript = state.transcript!;
    final speakers = {for (final s in transcript.speakers) s.id: s};
    final segments = state.visibleSegments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(transcript: transcript),
        if (transcript.speakers.length > 1)
          SpeakerFilterBar(
            speakers: transcript.speakers,
            selected: state.speakerFilter,
            onChanged: context.read<TranscriptCubit>().filterSpeaker,
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
            itemCount: segments.length,
            itemBuilder: (_, i) {
              final segment = segments[i];
              return SegmentTile(
                segment: segment,
                speaker: speakers[segment.speakerId],
                onTap: () => _editText(context, segment),
                onSpeakerTap: (speaker) => _rename(context, speaker),
              );
            },
          ),
        ),
      ],
    );
  }
}
