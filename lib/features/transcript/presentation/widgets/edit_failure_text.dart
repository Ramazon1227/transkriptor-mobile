import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';

/// Why a save did not go through, under the field it belongs to. The
/// edit routes have three answers of their own; everything else is the
/// app-wide sentence.
class EditFailureText extends StatelessWidget {
  const EditFailureText({required this.failure, super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = switch (failure) {
      // VIEWER: the transcript is readable, so the server says 403.
      ServerFailure(statusCode: 403) => l10n.transcriptEditForbidden,
      ServerFailure(statusCode: 404) => l10n.transcriptEditGone,
      ServerFailure(statusCode: 409) => l10n.transcriptEditStale,
      ServerFailure(statusCode: 400) => l10n.transcriptEditInvalid,
      _ => failure.message(l10n),
    };
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
}
