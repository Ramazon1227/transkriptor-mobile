import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/copy_link_fallback.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/player_transport.dart';

/// The top of the editor: the video surface (video files only), then one
/// transport for audio and video alike. YouTube media get a link card,
/// a file without audio a muted line; the transcript works either way.
class PlayerPanel extends StatelessWidget {
  const PlayerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      buildWhen: (p, n) =>
          p.status != n.status ||
          p.source != n.source ||
          p.hasVideo != n.hasVideo ||
          p.videoFolded != n.videoFolded ||
          p.aspectRatio != n.aspectRatio ||
          p.failure != n.failure,
      builder: (context, state) {
        final l10n = context.l10n;
        return switch (state.status) {
          PlayerStatus.initial || PlayerStatus.loading => const SizedBox(
            height: 3,
            child: LinearProgressIndicator(),
          ),
          PlayerStatus.unavailable => _MutedLine(
            text: switch (state.failure) {
              ServerFailure(statusCode: 410) => l10n.playerGone,
              _ => l10n.playerUnavailable,
            },
          ),
          PlayerStatus.failure => _MutedLine(
            text: l10n.playerFailed,
            onRetry: context.read<PlayerCubit>().retry,
          ),
          PlayerStatus.youtube => _YoutubeCard(url: state.source?.url ?? ''),
          PlayerStatus.ready => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.hasVideo && !state.videoFolded)
                _VideoSurface(aspectRatio: state.aspectRatio),
              const PlayerTransport(),
            ],
          ),
        };
      },
    );
  }
}

/// Black 16:9 box with the picture fitted in. Never taller than a third
/// of the screen, so the transcript keeps its room.
class _VideoSurface extends StatelessWidget {
  const _VideoSurface({required this.aspectRatio});

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(
      builder: (context, box) {
        final height = math.min(box.maxWidth * 9 / 16, screen * .34);
        final surface = context.read<PlayerCubit>().surface();
        return SizedBox(
          height: height,
          child: ColoredBox(
            color: Colors.black,
            child: Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: surface ?? const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MutedLine extends StatelessWidget {
  const _MutedLine({required this.text, this.onRetry});

  final String text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final retry = onRetry;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
      child: Row(
        children: [
          const Icon(
            Icons.music_off_outlined,
            size: 18,
            color: AppColors.mutedDark,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppText.caption)),
          if (retry != null)
            TextButton(
              key: const Key('player_retry'),
              onPressed: retry,
              child: Text(context.l10n.retry),
            ),
        ],
      ),
    );
  }
}

/// No in-app playback for YouTube: the link opens in the YouTube app (or
/// the browser), or goes to the clipboard.
class _YoutubeCard extends StatelessWidget {
  const _YoutubeCard({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        decoration: BoxDecoration(
          color: AppColors.sf1,
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        child: Row(
          children: [
            const SourceIcon(source: CaptureSource.youtube),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.playerYoutubeBody, style: AppText.caption),
                  const SizedBox(height: 6),
                  TextButton.icon(
                    key: const Key('player_youtube_open'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: url.isEmpty
                        ? null
                        : () async {
                            final opened = await context
                                .read<PlayerCubit>()
                                .openLink();
                            if (!opened && context.mounted) {
                              await copyLinkInstead(context, url);
                            }
                          },
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: Text(l10n.playerYoutubeOpen),
                  ),
                ],
              ),
            ),
            IconButton(
              key: const Key('player_youtube_copy'),
              tooltip: l10n.playerYoutubeCopy,
              onPressed: url.isEmpty
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.maybeOf(context);
                      await Clipboard.setData(ClipboardData(text: url));
                      messenger?.showSnackBar(
                        SnackBar(content: Text(l10n.shareCopied)),
                      );
                    },
              icon: const Icon(Icons.copy_rounded, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
