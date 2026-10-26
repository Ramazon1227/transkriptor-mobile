import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/job/application/job_cubit.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/presentation/widgets/job_status_chip.dart';

class JobPage extends StatelessWidget {
  const JobPage({required this.jobId, super.key});

  final String jobId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<JobCubit>()..watch(jobId),
      child: const _JobView(),
    );
  }
}

class _JobView extends StatelessWidget {
  const _JobView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        final job = state.job;
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (job != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: JobStatusChip(
                      status: job.status,
                      progress: job.progress,
                    ),
                  ),
                ),
            ],
          ),
          body: switch ((state.status, job)) {
            (JobViewStatus.failure, null) => AppErrorView(
              failure: state.failure!,
              onRetry: context.read<JobCubit>().refresh,
            ),
            (_, null) => const AppLoadingView(),
            (_, final Job job) => _JobBody(job: job, state: state),
          },
        );
      },
    );
  }
}

class _JobBody extends StatelessWidget {
  const _JobBody({required this.job, required this.state});

  final Job job;
  final JobState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<JobCubit>();
    final error = Theme.of(context).colorScheme.error;
    final transcriptId = job.transcriptId;
    final pollFailure = state.status == JobViewStatus.failure
        ? state.failure
        : null;
    final actionFailure = state.status != JobViewStatus.failure
        ? state.failure
        : null;

    final children = <Widget>[
      ...switch (job.status) {
        JobStatus.queued || JobStatus.running || JobStatus.unknown => [
          Text(
            '${job.progress}%',
            style: AppText.mono.copyWith(
              fontSize: 48,
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              // A queued job has no progress yet: an indeterminate bar.
              value: job.status == JobStatus.queued ? null : job.progress / 100,
              minHeight: 6,
              backgroundColor: AppColors.sf2,
            ),
          ),
          if (job.status == JobStatus.queued) ...[
            const SizedBox(height: 12),
            Text(l10n.jobQueuedHint, style: AppText.muted),
          ],
          const SizedBox(height: 24),
          _Note(text: l10n.jobKeepsRunning),
        ],
        JobStatus.succeeded => [Text(l10n.jobDoneTitle, style: AppText.title)],
        JobStatus.failed => [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.jobFailedTitle,
                  style: TextStyle(color: error, fontWeight: FontWeight.w600),
                ),
                if (job.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  // The server writes this one for people, in Uzbek.
                  Text(job.errorMessage!),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          _Note(text: l10n.jobFailedRefund, mint: true),
        ],
        JobStatus.cancelled => [
          Text(l10n.jobCancelledTitle, style: AppText.title),
          const SizedBox(height: 12),
          _Note(text: l10n.jobFailedRefund, mint: true),
        ],
      },
      if (pollFailure != null) ...[
        const SizedBox(height: 16),
        Text(pollFailure.message(l10n), style: TextStyle(color: error)),
        TextButton(onPressed: cubit.refresh, child: Text(l10n.retry)),
      ],
      if (actionFailure != null) ...[
        const SizedBox(height: 16),
        Text(actionFailure.message(l10n), style: TextStyle(color: error)),
      ],
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: ListView(children: children)),
            ..._actions(context, l10n, cubit, transcriptId),
          ],
        ),
      ),
    );
  }

  List<Widget> _actions(
    BuildContext context,
    AppLocalizations l10n,
    JobCubit cubit,
    String? transcriptId,
  ) {
    final busy = state.busy;
    return switch (job.status) {
      JobStatus.succeeded when transcriptId != null => [
        FilledButton(
          onPressed: () =>
              context.pushReplacement(Routes.transcriptOf(transcriptId)),
          child: Text(l10n.jobOpenTranscript),
        ),
      ],
      JobStatus.failed || JobStatus.cancelled => [
        FilledButton.icon(
          onPressed: busy || job.mediaId.isEmpty ? null : cubit.retry,
          icon: const Icon(Icons.refresh_rounded),
          label: Text(l10n.retry),
        ),
      ],
      JobStatus.queued || JobStatus.running => [
        OutlinedButton(
          onPressed: busy ? null : cubit.cancel,
          child: Text(l10n.jobCancel),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.jobCancelNote,
          textAlign: TextAlign.center,
          style: AppText.muted.copyWith(fontSize: 12),
        ),
      ],
      _ => const [],
    };
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.text, this.mint = false});

  final String text;

  /// A machine fact (refund done): marked with the mint dot.
  final bool mint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mint) ...[
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(Icons.check_rounded, size: 18, color: AppColors.mint),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(child: Text(text, style: AppText.muted)),
        ],
      ),
    );
  }
}
