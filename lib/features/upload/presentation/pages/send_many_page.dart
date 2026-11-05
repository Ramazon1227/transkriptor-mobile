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
import 'package:transkriptor_uz/core/widgets/confirm_sheet.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/application/upload_queue_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/advanced_settings_page.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/advanced_settings_tile.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/held_files_sheet.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/service_picker.dart';

/// Several picked files: one list, one set of «Qoʻshimcha sozlamalar», one
/// button; speaker hints are each file's own. One file
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
  /// «Qoʻshimcha sozlamalar» (A-0): for this list only.
  late AdvancedOptions _options = AdvancedOptions.initial(
    workspaceId: widget.workspaceId,
  );
  JobService _service = JobService.transcription;

  /// Leaving was confirmed: the emptied list must not pop a second time.
  bool _leaving = false;

  Future<void> _openAdvanced(UploadQueueState state) async {
    final saved = await AdvancedSettingsPage.open(
      context,
      value: _options,
      workspaces:
          context.read<AccountCubit>().state.account?.workspaces ?? const [],
      // Hints only for files whose job has not started.
      sources: [
        for (final item in state.items)
          if (item.status != QueueItemStatus.started &&
              item.status != QueueItemStatus.starting)
            HintSource(
              key: item.file.path,
              name: item.file.fileName,
              path: item.file.path,
            ),
      ],
      destinationLocked: state.destinationLocked,
    );
    if (saved != null && mounted) setState(() => _options = saved);
  }

  Future<void> _start(UploadQueueCubit cubit) => cubit.start(
    workspaceId: _options.workspaceId,
    folderId: _options.folderId,
    numSpeakers: _options.numSpeakers,
    service: _service,
    options: _options.jobOptionsFor(),
    hints: _options.hints,
  );

  Future<void> _retry(UploadQueueCubit cubit, String path) => cubit.retry(
    path,
    workspaceId: _options.workspaceId,
    folderId: _options.folderId,
    numSpeakers: _options.numSpeakers,
    service: _service,
    options: _options.jobOptionsFor(),
    hints: _options.hints,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<UploadQueueCubit>();
    return BlocConsumer<UploadQueueCubit, UploadQueueState>(
      // Every file taken off the list: nothing is left to send.
      listenWhen: (prev, next) => prev.items.isNotEmpty && next.items.isEmpty,
      listener: (context, state) {
        if (!_leaving) context.pop();
      },
      builder: (context, state) {
        final running = state.running;
        // The destination's balance (A-2).
        final seconds = context.select<AccountCubit, int?>(
          (c) => destinationBalance(c.state.account, _options.workspaceId),
        );
        // Leaving mid-upload asks first, then cancels what is still
        // uploading: paid jobs must not start with nobody watching.
        return PopScope(
          canPop: !state.uploading,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            final leave = await showConfirmSheet(
              context,
              title: l10n.sendLeaveTitle,
              message: l10n.sendLeaveMessage,
              confirmLabel: l10n.sendLeaveConfirm,
            );
            if (!leave || !context.mounted) return;
            _leaving = true;
            cubit.cancelAll();
            context.pop();
          },
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
                  onRetry: () => _retry(cubit, item.file.path),
                ),
              if (state.pickFailure != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.pickFailure!.message(l10n),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 22),
              ServicePicker(
                value: _service,
                enabled: !running,
                onChanged: (v) => setState(() => _service = v),
              ),
              const SizedBox(height: 22),
              if (!state.allStarted) ...[
                AdvancedSettingsTile(
                  value: _options,
                  currentWorkspaceId: widget.workspaceId,
                  onTap: running ? null : () => _openAdvanced(state),
                ),
                const SizedBox(height: 22),
              ],
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
                  onPressed: running ? null : () => _start(cubit),
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
    final uploading = item.status == QueueItemStatus.uploading;
    final removable =
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
                  tooltip: uploading
                      ? l10n.sendCancelUpload
                      : l10n.sendManyRemove,
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
            HeldFilesButton(failure: failure),
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
