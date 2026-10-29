import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/choice_group.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';

/// `1×`, `0,75×` — a decimal comma, as Uzbek writes numbers.
String formatSpeed(double speed) {
  final text = speed == speed.roundToDouble()
      ? speed.round().toString()
      : speed.toString().replaceAll('.', ',');
  return '$text×';
}

/// The five playback speeds; the choice applies at once.
Future<void> showSpeedSheet(BuildContext context, PlayerCubit cubit) {
  return showAppSheet<void>(
    context,
    builder: (_) => BlocProvider.value(value: cubit, child: const SpeedSheet()),
  );
}

class SpeedSheet extends StatelessWidget {
  const SpeedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: context.l10n.editorPlaybackSpeed,
      child: BlocSelector<PlayerCubit, PlayerState, double>(
        selector: (s) => s.speed,
        builder: (context, speed) => ChoiceGroup<double>(
          key: const Key('speed_choices'),
          options: [
            for (final s in playbackSpeeds) ChoiceOption(s, formatSpeed(s)),
          ],
          selected: speed,
          onChanged: context.read<PlayerCubit>().setSpeed,
        ),
      ),
    );
  }
}
