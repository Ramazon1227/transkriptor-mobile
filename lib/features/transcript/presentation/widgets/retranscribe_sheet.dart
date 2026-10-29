import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/transcript/application/retranscribe_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Asks before spending balance, inside the sheet. Closes with the new
/// job's id once the server took it.
class RetranscribeSheet extends StatelessWidget {
  const RetranscribeSheet({required this.transcript, super.key});

  final Transcript transcript;

  static Future<String?> show(BuildContext context, Transcript transcript) =>
      showAppSheet<String>(
        context,
        builder: (_) => RetranscribeSheet(transcript: transcript),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RetranscribeCubit>(),
      child: _RetranscribeView(transcript: transcript),
    );
  }
}

String _failureText(AppLocalizations l10n, Failure failure) =>
    switch (failure) {
      ServerFailure(statusCode: 403) => l10n.transcriptEditForbidden,
      ServerFailure(statusCode: 409) => l10n.retranscribeActive,
      ServerFailure(statusCode: 410) => l10n.retranscribeGone,
      _ => failure.message(l10n),
    };

class _RetranscribeView extends StatelessWidget {
  const _RetranscribeView({required this.transcript});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final duration = transcript.duration;
    return BlocConsumer<RetranscribeCubit, RetranscribeState>(
      listenWhen: (p, n) =>
          p.status != n.status && n.status == RetranscribeStatus.started,
      listener: (context, state) => Navigator.of(context).pop(state.jobId),
      builder: (context, state) {
        final busy = state.status == RetranscribeStatus.busy;
        final failure = state.failure;
        return PopScope(
          canPop: !busy,
          child: AppSheet(
            title: l10n.editorRetranscribe,
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: busy ? null : () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  key: const Key('retranscribe_confirm'),
                  onPressed: busy
                      ? null
                      : () => context.read<RetranscribeCubit>().start(
                          transcript.mediaId,
                        ),
                  child: busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.retranscribeConfirm),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.retranscribeBody, style: AppText.body),
                if (duration != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.retranscribeMinutes(
                      Formatters.minutesNeeded(duration),
                    ),
                    style: AppText.caption,
                  ),
                ],
                if (failure != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _failureText(l10n, failure),
                    style: const TextStyle(color: AppColors.bad),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
