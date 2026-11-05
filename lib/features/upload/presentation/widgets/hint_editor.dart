import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/upload/application/advanced_settings_cubit.dart';
import 'package:transkriptor_uz/features/upload/application/hint_player_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/advanced_problem_text.dart';

/// Plays [source] and ties intervals of it to names (A-3): a transport,
/// «Boshi» / «Oxiri» with «set from the current position», «Kim», then
/// the list with jump-to and delete. One editor per file; a new file is a
/// new editor (and a new player).
class HintEditor extends StatelessWidget {
  const HintEditor({required this.source, super.key});

  final HintSource source;

  static const Duration step = Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final player = getIt<HintPlayerCubit>();
        unawaited(player.open(source.path));
        return player;
      },
      child: const _HintEditorView(),
    );
  }
}

class _HintEditorView extends StatefulWidget {
  const _HintEditorView();

  @override
  State<_HintEditorView> createState() => _HintEditorViewState();
}

class _HintEditorViewState extends State<_HintEditorView> {
  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();
  final TextEditingController _label = TextEditingController();

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    _label.dispose();
    super.dispose();
  }

  void _add() {
    final added = context.read<AdvancedSettingsCubit>().addHint(
      label: _label.text,
      start: _start.text,
      end: _end.text,
      length: context.read<HintPlayerCubit>().state.duration,
    );
    if (!added) return;
    // The name stays: the next interval is often the same person's.
    _start.clear();
    _end.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Transport(),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TimeField(
                fieldKey: const Key('hint_start'),
                controller: _start,
                label: l10n.advancedHintsStart,
                hint: '0:15',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TimeField(
                fieldKey: const Key('hint_end'),
                controller: _end,
                label: l10n.advancedHintsEnd,
                hint: '0:25',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('hint_label'),
          controller: _label,
          maxLength: AdvancedRules.maxHintLabel,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          onSubmitted: (_) => _add(),
          decoration: InputDecoration(
            labelText: l10n.advancedHintsWho,
            hintText: l10n.advancedHintsWhoHint,
            counterText: '',
          ),
        ),
        _People(onPick: (name) => _label.text = name),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const Key('hint_add'),
          onPressed: _add,
          child: Text(l10n.advancedHintsAdd),
        ),
        BlocSelector<
          AdvancedSettingsCubit,
          AdvancedSettingsState,
          AdvancedProblem?
        >(
          selector: (s) => s.hintProblem,
          builder: (context, problem) => problem == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    advancedProblemText(l10n, problem),
                    key: const Key('hint_problem'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 12),
        const _HintList(),
      ],
    );
  }
}

/// Play/pause, ±5 s, a seek bar and the time.
class _Transport extends StatefulWidget {
  const _Transport();

  @override
  State<_Transport> createState() => _TransportState();
}

class _TransportState extends State<_Transport> {
  /// Where the thumb is while a finger holds it.
  double? _dragMs;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HintPlayerCubit, HintPlayerState>(
      builder: (context, state) {
        final player = context.read<HintPlayerCubit>();
        if (state.status == HintPlayerStatus.failure) {
          return Text(
            l10n.advancedHintsPlayerFailed,
            key: const Key('hint_player_failed'),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          );
        }
        final ready = state.status == HintPlayerStatus.ready;
        final totalMs = state.duration.inMilliseconds.toDouble();
        final posMs = (_dragMs ?? state.position.inMilliseconds.toDouble())
            .clamp(0, totalMs > 0 ? totalMs : 0)
            .toDouble();
        final now = AdvancedRules.formatTime(posMs.round());
        return Container(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
          decoration: BoxDecoration(
            color: AppColors.sf1,
            borderRadius: BorderRadius.circular(AppRadii.segment),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                label: l10n.advancedHintsSeek,
                child: Slider(
                  key: const Key('hint_seek'),
                  max: totalMs > 0 ? totalMs : 1,
                  value: totalMs > 0 ? posMs : 0,
                  onChanged: ready && totalMs > 0
                      ? (v) => setState(() => _dragMs = v)
                      : null,
                  onChangeEnd: ready && totalMs > 0
                      ? (v) {
                          setState(() => _dragMs = null);
                          unawaited(
                            player.seekTo(Duration(milliseconds: v.round())),
                          );
                        }
                      : null,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      totalMs > 0
                          ? '$now / ${AdvancedRules.formatTime(totalMs.round())}'
                          : now,
                      key: const Key('hint_now'),
                      style: AppText.mono.copyWith(fontSize: 13),
                    ),
                  ),
                  IconButton(
                    key: const Key('hint_back'),
                    tooltip: l10n.playerBack,
                    onPressed: ready
                        ? () => player.seekBy(-HintEditor.step)
                        : null,
                    icon: const Icon(Icons.replay_5_rounded),
                  ),
                  IconButton.filled(
                    key: const Key('hint_play'),
                    tooltip: state.playing ? l10n.playerPause : l10n.playerPlay,
                    onPressed: ready ? player.toggle : null,
                    icon: Icon(
                      state.playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                  IconButton(
                    key: const Key('hint_forward'),
                    tooltip: l10n.playerForward,
                    onPressed: ready
                        ? () => player.seekBy(HintEditor.step)
                        : null,
                    icon: const Icon(Icons.forward_5_rounded),
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

/// «Boshi» / «Oxiri»: typed («0:15», «1:02:03») or taken from the player.
class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.fieldKey,
    required this.controller,
    required this.label,
    required this.hint,
  });

  final Key fieldKey;
  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: AppText.mono.copyWith(fontSize: 14, color: AppColors.cotton),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: IconButton(
          tooltip: context.l10n.advancedHintsNow,
          icon: const Icon(Icons.schedule_rounded, size: 20),
          onPressed: () => controller.text = AdvancedRules.formatTime(
            context.read<HintPlayerCubit>().state.position.inMilliseconds,
          ),
        ),
      ),
    );
  }
}

/// The names already used in this file, to fill «Kim» with one tap.
class _People extends StatelessWidget {
  const _People({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final names = context.select<AdvancedSettingsCubit, List<String>>(
      (c) => AdvancedRules.people(c.state.sourceHints),
    );
    if (names.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final name in names)
            ActionChip(label: Text(name), onPressed: () => onPick(name)),
        ],
      ),
    );
  }
}

class _HintList extends StatelessWidget {
  const _HintList();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hints = context.select<AdvancedSettingsCubit, List<SpeakerHint>>(
      (c) => c.state.sourceHints,
    );
    if (hints.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        children: [
          for (final h in hints)
            Padding(
              key: ValueKey('hint_${h.label}_${h.startMs}'),
              padding: const EdgeInsets.fromLTRB(16, 2, 4, 2),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      h.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyStrong,
                    ),
                  ),
                  // Large text on a narrow phone: the times shrink rather
                  // than push the delete button off the row.
                  Flexible(
                    child: Tooltip(
                      message: l10n.advancedHintsPlayFrom,
                      child: TextButton(
                        onPressed: () => context
                            .read<HintPlayerCubit>()
                            .playFrom(Duration(milliseconds: h.startMs)),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${AdvancedRules.formatTime(h.startMs)} – '
                            '${AdvancedRules.formatTime(h.endMs)}',
                            style: AppText.mono.copyWith(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.advancedHintsDelete(h.label),
                    onPressed: () =>
                        context.read<AdvancedSettingsCubit>().removeHint(h),
                    icon: const Icon(Icons.delete_outline_rounded, size: 20),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
