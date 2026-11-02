import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/upload/application/upload_queue_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/speaker_count_picker.dart';

/// Several picked files: one list, one speaker count, one button. One file
/// goes to `SendPage`, which also offers a name and "save only".
class SendManyPage extends StatelessWidget {
  const SendManyPage({required this.files, super.key});

  final List<PendingFile> files;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UploadQueueCubit>()..open(files),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.sendTitle)),
        body: ContentWidth(
          child: WorkspaceGate(
            builder: (context, workspaceId) =>
                _SendManyForm(workspaceId: workspaceId),
          ),
        ),
      ),
    );
  }
}

class _SendManyForm extends StatefulWidget {
  const _SendManyForm({required this.workspaceId});

  final String workspaceId;

  @override
  State<_SendManyForm> createState() => _SendManyFormState();
}

class _SendManyFormState extends State<_SendManyForm> {
  int? _speakers;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<UploadQueueCubit>();
    return BlocConsumer<UploadQueueCubit, UploadQueueState>(
      // Every file taken off the list: nothing is left to send.
      listenWhen: (prev, next) => prev.items.isNotEmpty && next.items.isEmpty,
      listener: (context, state) => context.pop(),
      builder: (context, state) {
        final running = state.running;
        final seconds = context.select<AccountCubit, int?>(
          (c) => c.state.account?.currentWorkspace?.balanceSeconds,
        );
        // Leaving mid-upload would let paid jobs start with nobody watching.
        return PopScope(
          canPop: !running,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.sendManyFiles(state.items.length),
                      style: AppText.mono.copyWith(fontSize: 13),
                    ),
                  ),
                  if (!state.allStarted)
                    TextButton(
                      onPressed: running ? null : cubit.addMore,
                      child: Text(l10n.sendManyAdd),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              for (final item in state.items)
                _FileRow(
                  key: ValueKey(item.file.path),
                  item: item,
                  running: running,
                  onRemove: () => cubit.remove(item.file.path),
                  onRetry: () => cubit.retry(
                    item.file.path,
                    workspaceId: widget.workspaceId,
                    numSpeakers: _speakers,
                  ),
                ),
              if (state.pickFailure != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.pickFailure!.message(l10n),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 22),
              SpeakerCountPicker(
                value: _speakers,
                enabled: !running,
                onChanged: (v) => setState(() => _speakers = v),
              ),
              const SizedBox(height: 22),
              if (seconds != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(l10n.balanceLabel, style: AppText.muted),
                    ),
                    Text(
                      l10n.minutesShort(Formatters.minutesLeft(seconds)),
                      style: AppText.mono.copyWith(
                        fontSize: 13,
                        color: AppColors.cotton,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
              Text(
                l10n.sendManyNote,
                style: AppText.muted.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 28),
              if (state.waitingCount > 0)
                FilledButton(
                  onPressed: running
                      ? null
                      : () => cubit.start(
                          workspaceId: widget.workspaceId,
                          numSpeakers: _speakers,
                        ),
                  child: Text(l10n.sendManyStart(state.waitingCount)),
                ),
              if (state.waitingCount == 0 && !running) ...[
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => context.go(Routes.files),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.cotton,
                    minimumSize: const Size.fromHeight(52),
                  ),
                  child: Text(l10n.sendGoToFiles),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _FileRow extends StatelessWidget {
  const _FileRow({
    required this.item,
    required this.running,
    required this.onRemove,
    required this.onRetry,
    super.key,
  });

  final QueueItem item;
  final bool running;
  final VoidCallback onRemove;
  final VoidCallback onRetry;

  String _statusText(AppLocalizations l10n) => switch (item.status) {
    QueueItemStatus.waiting => running ? l10n.sendManyQueued : '',
    QueueItemStatus.uploading => l10n.sendUploading(
      (item.progress * 100).round(),
    ),
    QueueItemStatus.starting => l10n.sendManyStarting,
    QueueItemStatus.started => l10n.sendManyStarted,
    QueueItemStatus.stored => l10n.sendManyNotStarted,
    QueueItemStatus.failed => '',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final failure = item.failure;
    final status = _statusText(l10n);
    final removable =
        item.status != QueueItemStatus.uploading &&
        item.status != QueueItemStatus.starting &&
        item.status != QueueItemStatus.started;
    final canRetry =
        item.status == QueueItemStatus.failed ||
        item.status == QueueItemStatus.stored;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.file.fileName,
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
                        l10n.sizeMb(Formatters.megabytes(item.file.sizeBytes)),
                        if (status.isNotEmpty) status,
                      ].join(' · '),
                      style: AppText.muted.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (removable)
                IconButton(
                  onPressed: onRemove,
                  tooltip: l10n.sendManyRemove,
                  icon: const Icon(Icons.close_rounded, size: 20),
                ),
            ],
          ),
          if (item.status == QueueItemStatus.uploading) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: item.progress,
                  minHeight: 6,
                  backgroundColor: AppColors.sf2,
                ),
              ),
            ),
          ],
          if (failure != null) ...[
            const SizedBox(height: 6),
            Text(
              failure.message(l10n),
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 13,
              ),
            ),
          ],
          if (canRetry)
            TextButton(
              onPressed: running ? null : onRetry,
              child: Text(l10n.retry),
            ),
        ],
      ),
    );
  }
}
