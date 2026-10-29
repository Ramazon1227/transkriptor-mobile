import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_cubit.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/presentation/widgets/sentiment_bar.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The editor's «Tahlil» tab: sentiment per segment, per speaker and
/// overall. Started by a button, never on its own. Takes the
/// [SentimentCubit] from above (the editor shares it with the transcript
/// markers). Lives in a tab view under the player: fills a bounded
/// height, scrolls itself.
class SentimentTab extends StatelessWidget {
  const SentimentTab({this.speakers = const [], super.key});

  /// The transcript's speakers, for their colour dots. The names come
  /// from the analysis (it follows renames).
  final List<Speaker> speakers;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentimentCubit, SentimentState>(
      builder: (context, state) {
        final cubit = context.read<SentimentCubit>();
        switch (state.status) {
          case SentimentViewStatus.initial:
          case SentimentViewStatus.loading:
            return const AppLoadingView();
          case SentimentViewStatus.failure:
            return AppErrorView(
              failure: state.failure ?? const Failure.unknown(),
              onRetry: cubit.reload,
            );
          case SentimentViewStatus.success:
            return ListView(
              key: const Key('sentiment_list'),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                if (state.startFailure != null) ...[
                  _ErrorStrip(failure: state.startFailure!),
                  const SizedBox(height: 12),
                ],
                ..._body(context, state),
                if (state.pollFailure != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.sentimentPollFailed,
                    key: const Key('sentiment_poll_failed'),
                    style: AppText.caption,
                  ),
                ],
              ],
            );
        }
      },
    );
  }

  List<Widget> _body(BuildContext context, SentimentState state) {
    final l10n = context.l10n;
    final cubit = context.read<SentimentCubit>();
    final analysis = state.analysis;
    if (analysis == null) {
      return [_Intro(starting: state.starting, onStart: cubit.analyze)];
    }
    final rerun = _RerunButton(
      key: const Key('sentiment_rerun'),
      label: l10n.sentimentRerun,
      starting: state.starting,
      onPressed: state.canStart ? cubit.analyze : null,
    );
    switch (analysis.status) {
      case SentimentStatus.pending:
        return const [_Pending()];
      case SentimentStatus.failed:
      case SentimentStatus.unknown:
        return [
          _Card(
            key: const Key('sentiment_failed'),
            children: [
              Text(l10n.sentimentFailedTitle, style: AppText.heading),
              const SizedBox(height: 4),
              Text(
                analysis.error ?? l10n.sentimentFailedGeneric,
                style: AppText.body.copyWith(color: AppColors.bad),
              ),
              const SizedBox(height: 16),
              _RerunButton(
                key: const Key('sentiment_retry'),
                label: l10n.retry,
                starting: state.starting,
                onPressed: state.canStart ? cubit.analyze : null,
                filled: true,
              ),
            ],
          ),
        ];
      case SentimentStatus.done:
        return [
          if (analysis.outdated) ...[
            const _OutdatedBanner(),
            const SizedBox(height: 12),
          ],
          if (analysis.note.isNotEmpty) ...[
            _Note(text: analysis.note),
            const SizedBox(height: 12),
          ],
          _Overall(share: analysis.overall),
          if (analysis.speakers.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(l10n.sentimentSpeakers, style: AppText.label),
            const SizedBox(height: 8),
            for (final s in analysis.speakers)
              _SpeakerRow(speaker: s, ordinal: _ordinalOf(s.speakerId)),
          ],
          if (analysis.unlabeled > 0) ...[
            const SizedBox(height: 12),
            Text(
              l10n.sentimentUnlabeled(analysis.unlabeled),
              key: const Key('sentiment_unlabeled'),
              style: AppText.caption,
            ),
          ],
          const SizedBox(height: 20),
          Align(alignment: AlignmentDirectional.centerStart, child: rerun),
        ];
    }
  }

  int? _ordinalOf(String? id) {
    if (id == null) return null;
    for (final s in speakers) {
      if (s.id == id) return s.ordinal;
    }
    return null;
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.starting, required this.onStart});

  final bool starting;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _Card(
      key: const Key('sentiment_intro'),
      children: [
        const Icon(Icons.insights_rounded, color: AppColors.mint, size: 22),
        const SizedBox(height: 8),
        Text(l10n.sentimentIntroTitle, style: AppText.heading),
        const SizedBox(height: 4),
        Text(l10n.sentimentIntroBody, style: AppText.caption),
        const SizedBox(height: 16),
        _RerunButton(
          key: const Key('sentiment_start'),
          label: l10n.sentimentAnalyze,
          starting: starting,
          onPressed: starting ? null : onStart,
          filled: true,
        ),
      ],
    );
  }
}

/// The start / re-run / retry button; a spinner replaces the icon while
/// the request is on its way.
class _RerunButton extends StatelessWidget {
  const _RerunButton({
    required this.label,
    required this.starting,
    required this.onPressed,
    this.filled = false,
    super.key,
  });

  final String label;
  final bool starting;
  final VoidCallback? onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final icon = starting
        ? const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.refresh_rounded, size: 18);
    final text = Text(label, maxLines: 2, overflow: TextOverflow.ellipsis);
    return filled
        ? FilledButton.icon(onPressed: onPressed, icon: icon, label: text)
        : OutlinedButton.icon(onPressed: onPressed, icon: icon, label: text);
  }
}

class _Pending extends StatelessWidget {
  const _Pending();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _Card(
      key: const Key('sentiment_pending'),
      children: [
        Row(
          children: [
            const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(l10n.sentimentPending, style: AppText.bodyStrong),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(l10n.sentimentPendingBody, style: AppText.caption),
      ],
    );
  }
}

class _OutdatedBanner extends StatelessWidget {
  const _OutdatedBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      key: const Key('sentiment_outdated'),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: const BoxDecoration(
        color: AppColors.sf1,
        border: Border(left: BorderSide(color: AppColors.warn, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.update_rounded, size: 18, color: AppColors.warn),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.sentimentOutdated,
                  style: AppText.caption.copyWith(color: AppColors.cotton),
                ),
                const SizedBox(height: 2),
                Text(l10n.sentimentOutdatedBody, style: AppText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The model's 1–2 sentences. Machine text gets the mint marker icon;
/// the text itself stays in the reading colour.
class _Note extends StatelessWidget {
  const _Note({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('sentiment_note'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.auto_awesome, size: 16, color: AppColors.mint),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: AppText.body)),
      ],
    );
  }
}

class _Overall extends StatelessWidget {
  const _Overall({required this.share});

  final SentimentShare share;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _Card(
      key: const Key('sentiment_overall'),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(l10n.sentimentOverall, style: AppText.heading),
            ),
            const SizedBox(width: 8),
            Text(
              l10n.sentimentScore(formatSentimentScore(share.score)),
              key: const Key('sentiment_score'),
              style: AppText.mono,
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(l10n.sentimentShareHint, style: AppText.caption),
        const SizedBox(height: 12),
        SentimentBar(share: share, height: 10),
        const SizedBox(height: 10),
        SentimentLegend(share: share),
      ],
    );
  }
}

class _SpeakerRow extends StatelessWidget {
  const _SpeakerRow({required this.speaker, this.ordinal});

  final SpeakerSentiment speaker;

  /// Null: no speaker (or unknown to the transcript) — a muted dot.
  final int? ordinal;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = speaker.speakerId == null
        ? l10n.sentimentNoSpeaker
        : (speaker.label.isEmpty ? l10n.transcriptNoSpeaker : speaker.label);
    final dot = ordinal == null
        ? AppColors.mutedDark
        : AppColors.speaker(ordinal!);
    return Padding(
      key: Key('sentiment_speaker_${speaker.speakerId ?? 'none'}'),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyMedium,
                ),
              ),
              const SizedBox(width: 8),
              Text(Formatters.timecode(speaker.talk), style: AppText.mono),
            ],
          ),
          const SizedBox(height: 6),
          SentimentBar(share: speaker.share),
          const SizedBox(height: 6),
          SentimentLegend(share: speaker.share, compact: true),
        ],
      ),
    );
  }
}

class _ErrorStrip extends StatelessWidget {
  const _ErrorStrip({required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      key: const Key('sentiment_error'),
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
      decoration: BoxDecoration(
        color: AppColors.badSoft,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              sentimentStartFailureText(failure, l10n),
              style: AppText.caption.copyWith(color: AppColors.bad),
            ),
          ),
          IconButton(
            tooltip: l10n.close,
            visualDensity: VisualDensity.compact,
            onPressed: context.read<SentimentCubit>().dismissStartFailure,
            icon: const Icon(Icons.close_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}

/// Why a start was refused. 403: mobile knows no workspace role, so the
/// button is always shown and a VIEWER learns here. 409 / 503: the
/// server's own sentence is Uzbek and written for people; the fallback
/// covers an empty one.
String sentimentStartFailureText(Failure failure, AppLocalizations l10n) {
  String server(String? message, String fallback) {
    final m = message?.trim() ?? '';
    if (m.isEmpty) return fallback;
    return m[0].toUpperCase() + m.substring(1);
  }

  return switch (failure) {
    ServerFailure(statusCode: 403) => l10n.sentimentForbidden,
    ServerFailure(statusCode: 409, :final message) => server(
      message,
      l10n.sentimentBusy,
    ),
    ServerFailure(statusCode: 503, :final message) => server(
      message,
      l10n.sentimentUnavailable,
    ),
    _ => failure.message(l10n),
  };
}

/// `+0.25`, `−0.13`, `0.00`: the score's sign is part of the reading.
String formatSentimentScore(double score) {
  final fixed = score.abs().toStringAsFixed(2);
  if (fixed == '0.00') return fixed;
  return score > 0 ? '+$fixed' : '−$fixed';
}
