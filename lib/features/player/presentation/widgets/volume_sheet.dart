import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';

/// The player's own volume, under the phone's: a quiet recording can be
/// turned down next to another sound, or muted, without the phone's keys.
Future<void> showVolumeSheet(BuildContext context, PlayerCubit cubit) {
  return showAppSheet<void>(
    context,
    builder: (_) =>
        BlocProvider.value(value: cubit, child: const VolumeSheet()),
  );
}

/// The icon for the transport and the sheet: silent when muted or at zero.
IconData volumeIcon({required double volume, required bool muted}) {
  if (muted || volume == 0) return Icons.volume_off_rounded;
  return volume < .5 ? Icons.volume_down_rounded : Icons.volume_up_rounded;
}

class VolumeSheet extends StatelessWidget {
  const VolumeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      title: l10n.playerVolume,
      child: BlocBuilder<PlayerCubit, PlayerState>(
        buildWhen: (a, b) => a.volume != b.volume || a.muted != b.muted,
        builder: (context, state) {
          final cubit = context.read<PlayerCubit>();
          final level = state.muted ? 0.0 : state.volume;
          return Row(
            children: [
              IconButton(
                key: const Key('volume_mute'),
                tooltip: state.muted ? l10n.playerUnmute : l10n.playerMute,
                onPressed: cubit.toggleMute,
                icon: Icon(
                  volumeIcon(volume: state.volume, muted: state.muted),
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.accent,
                    inactiveTrackColor: AppColors.sf3,
                    thumbColor: AppColors.accent,
                  ),
                  child: Slider(
                    key: const Key('volume_slider'),
                    value: level,
                    divisions: 20,
                    label: '${(level * 100).round()}%',
                    semanticFormatterCallback: (v) => '${(v * 100).round()}%',
                    // Every tick is two keystore writes: saved on release.
                    onChanged: (v) => cubit.setVolume(v, save: false),
                    onChangeEnd: cubit.setVolume,
                  ),
                ),
              ),
              SizedBox(
                width: 44,
                child: Text(
                  '${(level * 100).round()}%',
                  textAlign: TextAlign.end,
                  style: AppText.mono,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
