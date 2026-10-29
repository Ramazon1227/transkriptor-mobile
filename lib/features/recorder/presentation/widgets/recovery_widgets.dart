import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/recorder/application/recovery_cubit.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

/// `3:12`, or `1:03:12` past an hour.
String shortDuration(Duration d) {
  final total = d.inSeconds < 0 ? 0 : d.inSeconds;
  final h = total ~/ 3600;
  final m = (total % 3600) ~/ 60;
  final s = (total % 60).toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$s' : '$m:$s';
}

/// «bugun 18:40», «kecha 18:40», else «12.10.2026 18:40».
String recoveryWhen(AppLocalizations l10n, DateTime at, DateTime now) {
  final local = at.toLocal();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(local.year, local.month, local.day);
  final time = Formatters.clock(local);
  final days = today.difference(day).inDays;
  if (days == 0) return l10n.recoveryToday(time);
  if (days == 1) return l10n.recoveryYesterday(time);
  return l10n.recoveryOn(Formatters.date(local), time);
}

/// The one-line summary of what is waiting.
String recoverySummary(
  AppLocalizations l10n,
  List<RecoverableRecording> items,
  DateTime now,
) {
  if (items.length != 1) return l10n.recoveryBannerMany(items.length);
  final item = items.single;
  final d = item.duration;
  return l10n.recoveryBannerOne(
    d == null ? l10n.recoveryUnknownLength : shortDuration(d),
    recoveryWhen(l10n, item.createdAt, now),
  );
}

/// Opens the list of unsent recordings over the page that owns [cubit].
/// Returns the recovered file once «Yuborish» succeeded (the caller takes
/// it to the send page and calls [RecoveryCubit.consumed]).
Future<PendingFile?> showRecoverySheet(
  BuildContext context,
  RecoveryCubit cubit,
) {
  return showAppSheet<PendingFile>(
    context,
    builder: (_) =>
        BlocProvider.value(value: cubit, child: const RecoverySheet()),
  );
}

/// Opens the sheet and, when a recording was recovered, hands it to
/// [onRecovered].
Future<void> openRecovery(
  BuildContext context,
  void Function(PendingFile file) onRecovered,
) async {
  final cubit = context.read<RecoveryCubit>();
  final file = await showRecoverySheet(context, cubit);
  if (file == null) return;
  cubit.consumed();
  onRecovered(file);
}

/// Compact banner for the Studio home: «Yuborilmagan yozuv bor — 3:12,
/// kecha 18:40». Hidden when nothing is waiting.
class RecoveryBanner extends StatelessWidget {
  const RecoveryBanner({required this.onRecovered, super.key});

  final void Function(PendingFile file) onRecovered;

  @override
  Widget build(BuildContext context) {
    final items = context.select<RecoveryCubit, List<RecoverableRecording>>(
      (c) => c.state.items,
    );
    if (items.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Material(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openRecovery(context, onRecovered),
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.warn, width: 3)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.restore_rounded,
                  size: 20,
                  color: AppColors.warn,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    recoverySummary(l10n, items, DateTime.now()),
                    style: AppText.body.copyWith(color: AppColors.cotton),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.mutedDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Card for the recorder page: a title, a sentence, and the way to the
/// list.
class RecoveryCard extends StatelessWidget {
  const RecoveryCard({required this.onRecovered, super.key});

  final void Function(PendingFile file) onRecovered;

  @override
  Widget build(BuildContext context) {
    final items = context.select<RecoveryCubit, List<RecoverableRecording>>(
      (c) => c.state.items,
    );
    if (items.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.restore_rounded, color: AppColors.warn),
              const SizedBox(width: 10),
              Expanded(
                child: Text(l10n.recoveryCardTitle, style: AppText.heading),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            recoverySummary(l10n, items, DateTime.now()),
            style: AppText.body.copyWith(color: AppColors.cotton),
          ),
          const SizedBox(height: 4),
          Text(l10n.recoveryCardBody, style: AppText.caption),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: () => openRecovery(context, onRecovered),
              child: Text(l10n.recoveryOpen),
            ),
          ),
        ],
      ),
    );
  }
}

/// The list: each recording with «Yuborish» and «Oʻchirish»; deleting
/// asks inside the row, never in a dialog on top.
class RecoverySheet extends StatefulWidget {
  const RecoverySheet({super.key});

  @override
  State<RecoverySheet> createState() => _RecoverySheetState();
}

class _RecoverySheetState extends State<RecoverySheet> {
  /// The row asking «Oʻchirilsinmi?».
  String? _confirming;
  bool _popped = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<RecoveryCubit, RecoveryState>(
      listenWhen: (prev, next) =>
          prev.recovered != next.recovered || prev.items != next.items,
      listener: (context, state) {
        final file = state.recovered;
        if (file != null) {
          // Only once, though the post-frame check above may also run.
          if (!_popped) {
            _popped = true;
            Navigator.of(context).pop(file);
          }
        } else if (state.items.isEmpty) {
          // A recover empties the list one emit before it sets
          // `recovered`; look again after the frame, not now.
          final cubit = context.read<RecoveryCubit>();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            final now = cubit.state;
            if (now.items.isEmpty && now.recovered == null) {
              Navigator.of(this.context).maybePop();
            }
          });
        }
      },
      builder: (context, state) {
        final now = DateTime.now();
        return AppSheet(
          title: l10n.recoverySheetTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.failure != null) ...[
                Text(
                  state.failure!.message(l10n),
                  style: AppText.caption.copyWith(color: AppColors.bad),
                ),
                const SizedBox(height: 8),
              ],
              for (final item in state.items)
                _RecoveryRow(
                  item: item,
                  now: now,
                  busy: state.busyPath == item.path,
                  locked: state.busyPath != null,
                  confirming: _confirming == item.path,
                  onConfirm: (ask) =>
                      setState(() => _confirming = ask ? item.path : null),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RecoveryRow extends StatelessWidget {
  const _RecoveryRow({
    required this.item,
    required this.now,
    required this.busy,
    required this.locked,
    required this.confirming,
    required this.onConfirm,
  });

  final RecoverableRecording item;
  final DateTime now;
  final bool busy;
  final bool locked;
  final bool confirming;
  final ValueChanged<bool> onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<RecoveryCubit>();
    final d = item.duration;
    final interrupted = item.state == RecordingCompletion.interrupted;
    final kind = item.kind == RecordingKind.screen
        ? l10n.recoveryKindScreen
        : l10n.recoveryKindMic;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                d == null ? l10n.recoveryUnknownLength : shortDuration(d),
                style: AppText.mono.copyWith(
                  fontSize: 16,
                  color: AppColors.cotton,
                ),
              ),
              Text(
                recoveryWhen(l10n, item.createdAt, now),
                style: AppText.caption,
              ),
              if (interrupted) _Chip(text: l10n.recoveryInterrupted),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            [
              kind,
              l10n.sizeMb(Formatters.megabytes(item.sizeBytes)),
            ].join(' · '),
            style: AppText.caption,
          ),
          if (interrupted) ...[
            const SizedBox(height: 2),
            Text(l10n.recoveryInterruptedHint, style: AppText.caption),
          ],
          const SizedBox(height: 10),
          if (busy)
            const Align(
              alignment: Alignment.centerLeft,
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else if (confirming) ...[
            Text(l10n.recoveryDeleteAsk, style: AppText.body),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: locked
                      ? null
                      : () {
                          onConfirm(false);
                          unawaited(cubit.discard(item));
                        },
                  style: TextButton.styleFrom(foregroundColor: AppColors.bad),
                  child: Text(l10n.recoveryDeleteYes),
                ),
                TextButton(
                  onPressed: () => onConfirm(false),
                  child: Text(l10n.recoveryDeleteNo),
                ),
              ],
            ),
          ] else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: locked
                      ? null
                      : () => cubit.recover(
                          item,
                          title: l10n.recordingName(
                            Formatters.date(item.createdAt),
                          ),
                        ),
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
                  child: Text(l10n.recoverySend),
                ),
                TextButton(
                  onPressed: locked ? null : () => onConfirm(true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.bad,
                    minimumSize: const Size(0, 40),
                  ),
                  child: Text(l10n.recoveryDelete),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.warn.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: AppText.label.copyWith(color: AppColors.warn)),
    );
  }
}
