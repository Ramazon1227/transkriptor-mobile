import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/speed_sheet.dart';

/// One set of controls for audio and video: seek bar, times, speed,
/// ±5 s, play/pause, and — for a video — fold/unfold the picture.
class PlayerTransport extends StatefulWidget {
  const PlayerTransport({super.key});

  static const Duration step = Duration(seconds: 5);

  @override
  State<PlayerTransport> createState() => _PlayerTransportState();
}

class _PlayerTransportState extends State<PlayerTransport> {
  /// Where the thumb is while a finger holds it; the player's position
  /// must not pull it back mid-drag.
  double? _dragMs;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        final cubit = context.read<PlayerCubit>();
        final totalMs = state.duration.inMilliseconds.toDouble();
        final posMs = (_dragMs ?? state.position.inMilliseconds.toDouble())
            .clamp(0, totalMs > 0 ? totalMs : 0)
            .toDouble();
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 32,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 14,
                    ),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    activeTrackColor: AppColors.accent,
                    inactiveTrackColor: AppColors.sf3,
                    thumbColor: AppColors.accent,
                  ),
                  child: Slider(
                    key: const Key('player_seek'),
                    max: totalMs > 0 ? totalMs : 1,
                    value: totalMs > 0 ? posMs : 0,
                    onChanged: totalMs > 0
                        ? (v) => setState(() => _dragMs = v)
                        : null,
                    onChangeEnd: totalMs > 0
                        ? (v) {
                            setState(() => _dragMs = null);
                            unawaited(
                              cubit.seekTo(Duration(milliseconds: v.round())),
                            );
                          }
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      Formatters.timecode(
                        Duration(milliseconds: posMs.round()),
                      ),
                      style: AppText.mono,
                    ),
                    const Spacer(),
                    Text(
                      Formatters.timecode(state.duration),
                      style: AppText.mono,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        key: const Key('player_speed'),
                        onPressed: () => showSpeedSheet(context, cubit),
                        child: Text(
                          formatSpeed(state.speed),
                          style: AppText.mono.copyWith(
                            fontSize: 14,
                            color: AppColors.cotton,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    key: const Key('player_back'),
                    tooltip: l10n.playerBack,
                    onPressed: () => cubit.seekBy(-PlayerTransport.step),
                    icon: const Icon(Icons.replay_5_rounded),
                  ),
                  IconButton.filled(
                    key: const Key('player_play'),
                    tooltip: state.playing ? l10n.playerPause : l10n.playerPlay,
                    onPressed: cubit.togglePlay,
                    icon: Icon(
                      state.playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                  IconButton(
                    key: const Key('player_forward'),
                    tooltip: l10n.playerForward,
                    onPressed: () => cubit.seekBy(PlayerTransport.step),
                    icon: const Icon(Icons.forward_5_rounded),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: state.hasVideo
                          ? IconButton(
                              key: const Key('player_fold'),
                              tooltip: state.videoFolded
                                  ? l10n.playerUnfold
                                  : l10n.playerFold,
                              onPressed: cubit.toggleFold,
                              icon: Icon(
                                state.videoFolded
                                    ? Icons.expand_more_rounded
                                    : Icons.expand_less_rounded,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
