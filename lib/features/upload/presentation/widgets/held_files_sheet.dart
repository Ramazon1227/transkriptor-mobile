import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/confirm_sheet.dart';
import 'package:transkriptor_uz/features/upload/application/held_files_cubit.dart';

/// Shown under a refused upload: opens the list of files holding the limit.
/// Nothing for any other failure.
class HeldFilesButton extends StatelessWidget {
  const HeldFilesButton({required this.failure, super.key});

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    final failure = this.failure;
    if (failure is! PendingLimitFailure || failure.held.isEmpty) {
      return const SizedBox.shrink();
    }
    return TextButton(
      key: const Key('held_files_show'),
      onPressed: () => showAppSheet<void>(
        context,
        builder: (_) => BlocProvider(
          create: (_) => getIt<HeldFilesCubit>()..open(failure.held),
          child: const _HeldFilesSheet(),
        ),
      ),
      child: Text(context.l10n.heldFilesShow),
    );
  }
}

class _HeldFilesSheet extends StatelessWidget {
  const _HeldFilesSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HeldFilesCubit, HeldFilesState>(
      builder: (context, state) => AppSheet(
        title: l10n.heldFilesShow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.heldFilesHint, style: AppText.muted),
            const SizedBox(height: 12),
            for (final held in state.items)
              _HeldRow(held: held, deleting: state.deletingId != null),
            if (state.failure != null)
              Text(
                state.failure!.message(l10n),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }
}

class _HeldRow extends StatelessWidget {
  const _HeldRow({required this.held, required this.deleting});

  final HeldFile held;
  final bool deleting;

  String _state(AppLocalizations l10n) => switch (held.state) {
    HeldFileState.unconfirmed => l10n.heldFileUnconfirmed,
    HeldFileState.waiting => l10n.heldFileWaiting,
    HeldFileState.failed => l10n.heldFileFailed,
    HeldFileState.cancelled => l10n.heldFileCancelled,
  };

  Future<void> _delete(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<HeldFilesCubit>();
    final sure = await showConfirmSheet(
      context,
      title: l10n.heldFileDeleteTitle,
      message: l10n.heldFileDeleteBody(held.name),
      confirmLabel: l10n.heldFileDelete,
    );
    if (sure) await cubit.delete(held.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final expires = held.expiresAt;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  held.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.mono.copyWith(
                    fontSize: 13,
                    color: AppColors.cotton,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    if (held.sizeBytes > 0)
                      l10n.sizeMb(Formatters.megabytes(held.sizeBytes)),
                    _state(l10n),
                    if (expires != null)
                      l10n.heldFileExpires(Formatters.date(expires)),
                    if (!held.deletable) l10n.heldFileBusy,
                  ].join(' · '),
                  style: AppText.muted.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          if (held.deletable)
            IconButton(
              key: Key('held_delete_${held.id}'),
              tooltip: l10n.heldFileDelete,
              onPressed: deleting ? null : () => _delete(context),
              icon: const Icon(Icons.delete_outline_rounded, size: 20),
            ),
        ],
      ),
    );
  }
}
