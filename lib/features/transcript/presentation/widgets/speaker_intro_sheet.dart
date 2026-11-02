import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/transcript/application/speaker_intro_cubit.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/speaker_intro.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_failure_text.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_sheet_route.dart';

/// «Maʼruzachilarni tanishtiring»: a name and a sample of the voice for
/// each speaker. However it closes, it does not come back by itself for
/// this transcript; the «…» sheet opens it again.
class SpeakerIntroSheet extends StatefulWidget {
  const SpeakerIntroSheet({required this.transcript, super.key});

  final Transcript transcript;

  /// Over [context], which must see the page's three cubits.
  static Future<void> show(BuildContext context) async {
    final transcripts = context.read<TranscriptCubit>();
    final player = context.read<PlayerCubit>();
    final intro = context.read<SpeakerIntroCubit>();
    final transcript = transcripts.state.transcript;
    if (transcript == null) return;
    await intro.loadOff();
    if (!context.mounted) return;
    await showEditSheet<void>(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: player),
          BlocProvider.value(value: intro),
        ],
        child: SpeakerIntroSheet(transcript: transcript),
      ),
    );
    if (intro.isClosed) return;
    await intro.closed(transcript.id);
    if (!player.isClosed) await player.leaveClips();
  }

  @override
  State<SpeakerIntroSheet> createState() => _SpeakerIntroSheetState();
}

class _SpeakerIntroSheetState extends State<SpeakerIntroSheet> {
  late final List<SpeakerIntroRow> _rows = SpeakerIntro.rows(widget.transcript);

  /// A default name stays out of the field, as its hint: no need to clear
  /// it before typing.
  late final Map<String, TextEditingController> _names = {
    for (final row in _rows)
      row.speaker.id: TextEditingController(
        text: SpeakerIntro.isDefaultLabel(row.speaker.label)
            ? ''
            : row.speaker.label,
      )..addListener(_changed),
  };

  bool _saving = false;

  void _changed() => setState(() {});

  @override
  void dispose() {
    for (final c in _names.values) {
      c.dispose();
    }
    super.dispose();
  }

  /// An empty field keeps the name it had.
  String _final(SpeakerIntroRow row) {
    final typed = EditRules.clean(_names[row.speaker.id]!.text);
    return typed.isEmpty ? row.speaker.label : typed;
  }

  /// The filter and the export go by name, so two speakers with one name
  /// read as one person.
  bool _shared(SpeakerIntroRow row) {
    final name = _final(row).toLowerCase();
    return _rows.where((r) => _final(r).toLowerCase() == name).length > 1;
  }

  bool get _tooLong =>
      _names.values.any((c) => EditRules.speakerLabelTooLong(c.text));

  Future<void> _save() async {
    final cubit = context.read<TranscriptCubit>();
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    await cubit.renameSpeakers({
      for (final row in _rows) row.speaker.id: _final(row),
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (cubit.state.editStatus != EditStatus.failure) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final failure = context.select<TranscriptCubit, Failure?>(
      (c) => c.state.editFailure,
    );
    return PopScope(
      canPop: !_saving,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          16,
          20,
          16 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.speakerIntroTitle, style: AppText.label),
              const SizedBox(height: 6),
              Text(l10n.speakerIntroBody, style: AppText.caption),
              const SizedBox(height: 12),
              for (final row in _rows)
                _Row(
                  row: row,
                  controller: _names[row.speaker.id]!,
                  enabled: !_saving,
                  shared: _shared(row),
                ),
              if (failure != null) ...[
                const SizedBox(height: 10),
                EditFailureText(failure: failure),
              ],
              const SizedBox(height: 4),
              BlocBuilder<SpeakerIntroCubit, SpeakerIntroState>(
                builder: (context, state) => SwitchListTile(
                  key: const Key('speaker_intro_off'),
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.speakerIntroOff, style: AppText.caption),
                  value: state.off,
                  onChanged: (v) =>
                      context.read<SpeakerIntroCubit>().setOff(off: v),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    key: const Key('speaker_intro_later'),
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(l10n.speakerIntroLater),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    key: const Key('speaker_intro_save'),
                    onPressed: _saving || _tooLong ? null : _save,
                    child: Text(l10n.transcriptSave),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.row,
    required this.controller,
    required this.enabled,
    required this.shared,
  });

  final SpeakerIntroRow row;
  final TextEditingController controller;
  final bool enabled;
  final bool shared;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tooLong = EditRules.speakerLabelTooLong(controller.text);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              key: Key('speaker_intro_name_${row.speaker.id}'),
              controller: controller,
              enabled: enabled,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.edit_outlined, size: 18),
                hintText: row.speaker.label,
                errorText: tooLong ? l10n.transcriptLabelTooLong : null,
                helperText: shared ? l10n.speakerIntroSameName : null,
                helperMaxLines: 2,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _Listen(row: row),
        ],
      ),
    );
  }
}

/// Hidden where this phone cannot play the file: YouTube opens outside
/// the app, and a file that failed or is gone has nothing to play.
class _Listen extends StatelessWidget {
  const _Listen({required this.row});

  final SpeakerIntroRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final start = row.start;
    final end = row.end;
    if (start == null || end == null) return const SizedBox.shrink();
    return BlocBuilder<PlayerCubit, PlayerState>(
      buildWhen: (p, n) =>
          p.status != n.status || p.clipStart != n.clipStart,
      builder: (context, state) {
        if (state.status != PlayerStatus.ready &&
            state.status != PlayerStatus.loading) {
          return const SizedBox.shrink();
        }
        final player = context.read<PlayerCubit>();
        final on = state.clipStart == start;
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: OutlinedButton.icon(
            key: Key('speaker_intro_play_${row.speaker.id}'),
            onPressed: !state.canPlay
                ? null
                : on
                ? player.stopClip
                : () => player.playClip(start, end),
            icon: Icon(
              on ? Icons.stop_rounded : Icons.play_arrow_rounded,
              size: 18,
            ),
            label: Text(on ? l10n.speakerIntroStop : l10n.speakerIntroListen),
          ),
        );
      },
    );
  }
}
