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
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/speaker_count_picker.dart';

class SendPage extends StatelessWidget {
  const SendPage({required this.file, super.key});

  final PendingFile file;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UploadBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.sendTitle)),
        body: WorkspaceGate(
          builder: (context, workspaceId) =>
              _SendForm(file: file, workspaceId: workspaceId),
        ),
      ),
    );
  }
}

class _SendForm extends StatefulWidget {
  const _SendForm({required this.file, required this.workspaceId});

  final PendingFile file;
  final String workspaceId;

  @override
  State<_SendForm> createState() => _SendFormState();
}

class _SendFormState extends State<_SendForm> {
  late final TextEditingController _title = TextEditingController(
    text: widget.file.baseName,
  );
  int? _speakers;

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  void _send({required bool start}) {
    FocusScope.of(context).unfocus();
    context.read<UploadBloc>().add(
      UploadFileSubmitted(
        file: widget.file,
        workspaceId: widget.workspaceId,
        title: _title.text,
        startTranscription: start,
        numSpeakers: _speakers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<UploadBloc, UploadState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        if (state.status != UploadStatus.success) return;
        final job = state.job;
        if (job != null) {
          context.pushReplacement(Routes.jobOf(job.id));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.sendSaved)));
          context.go(Routes.files);
        }
      },
      builder: (context, state) {
        final uploading = state.status == UploadStatus.uploading;
        final busy =
            uploading ||
            state.status == UploadStatus.starting ||
            state.status == UploadStatus.success;
        // Once stored, the form is done: only starting the job is left.
        final stored =
            state.status == UploadStatus.stored ||
            state.status == UploadStatus.starting;
        final locked = busy || stored;
        final mediaId = state.mediaId;
        // Leaving mid-upload would let it finish unseen and start a paid
        // job nobody is watching.
        return PopScope(
          canPop: !busy,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              _FileCard(file: widget.file),
              const SizedBox(height: 22),
              TextField(
                controller: _title,
                enabled: !locked,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: l10n.sendName),
              ),
              const SizedBox(height: 22),
              SpeakerCountPicker(
                value: _speakers,
                enabled: !busy,
                onChanged: (v) => setState(() => _speakers = v),
              ),
              const SizedBox(height: 22),
              _MinutesCard(duration: widget.file.duration),
              const SizedBox(height: 10),
              Text(
                l10n.sendUploadFree,
                style: AppText.muted.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 28),
              if (stored) ...[
                Text(l10n.sendStoredNotStarted),
                const SizedBox(height: 4),
              ],
              if (state.failure != null &&
                  (state.status == UploadStatus.failure || stored)) ...[
                Text(
                  state.failure!.message(l10n),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                const SizedBox(height: 12),
              ],
              if (uploading) ...[
                Text(
                  l10n.sendUploading((state.progress * 100).round()),
                  style: AppText.mono.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: state.progress,
                    minHeight: 6,
                    backgroundColor: AppColors.sf2,
                  ),
                ),
              ] else if (stored && mediaId != null) ...[
                FilledButton(
                  onPressed: state.status == UploadStatus.starting
                      ? null
                      : () => context.read<UploadBloc>().add(
                          UploadStartRetried(
                            mediaId: mediaId,
                            numSpeakers: _speakers,
                          ),
                        ),
                  child: Text(l10n.sendStart),
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => context.go(Routes.files),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.cotton,
                    minimumSize: const Size.fromHeight(52),
                  ),
                  child: Text(l10n.sendGoToFiles),
                ),
              ] else if (!busy) ...[
                FilledButton(
                  onPressed: () => _send(start: true),
                  child: Text(l10n.sendStart),
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => _send(start: false),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.cotton,
                    minimumSize: const Size.fromHeight(52),
                  ),
                  child: Text(l10n.sendSaveOnly),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _FileCard extends StatelessWidget {
  const _FileCard({required this.file});

  final PendingFile file;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final duration = file.duration;
    final origin = file.source == UploadSource.recording
        ? l10n.sendRecorded
        : l10n.sendPicked;
    final ext = file.extension.replaceFirst('.', '');
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.sf2,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.graphic_eq_rounded,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  duration != null
                      ? Formatters.timecode(duration)
                      : file.fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.mono.copyWith(
                    fontSize: duration != null ? 18 : 14,
                    color: AppColors.cotton,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    origin,
                    l10n.sizeMb(Formatters.megabytes(file.sizeBytes)),
                    if (ext.isNotEmpty) ext,
                  ].join(' · '),
                  style: AppText.muted.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// What the file will cost against what is left. A picked file's length
/// is measured by the server, so only the balance is shown for it.
class _MinutesCard extends StatelessWidget {
  const _MinutesCard({required this.duration});

  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final seconds = context.select<AccountCubit, int?>(
      (c) => c.state.account?.currentWorkspace?.balanceSeconds,
    );
    final d = duration;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Column(
        children: [
          if (d != null)
            _Row(
              label: l10n.sendThisFile,
              value: l10n.sendApproxMinutes(Formatters.minutesNeeded(d)),
            ),
          if (seconds != null)
            _Row(
              label: l10n.balanceLabel,
              value: l10n.minutesShort(Formatters.minutesLeft(seconds)),
            ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.muted)),
          Text(
            value,
            style: AppText.mono.copyWith(fontSize: 13, color: AppColors.cotton),
          ),
        ],
      ),
    );
  }
}
