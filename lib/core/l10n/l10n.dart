import 'package:flutter/widgets.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';

export 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension FailureMessage on Failure {
  /// The sentence a person sees. The server's own text is not shown: it is
  /// written for developers and may carry internal detail.
  String message(AppLocalizations l10n) => switch (this) {
    NetworkFailure() => l10n.errorNetwork,
    TimeoutFailure() => l10n.errorTimeout,
    UnauthorizedFailure() => l10n.errorUnauthorized,
    ServerFailure(statusCode: 402) => l10n.errorNoBalance,
    ServerFailure(statusCode: 413) => l10n.errorTooLarge,
    ServerFailure(statusCode: 429) => l10n.errorTooManyRequests,
    ServerFailure() => l10n.errorServer,
    ParsingFailure() => l10n.errorParsing,
    PermissionDeniedFailure() => l10n.errorMicPermission,
    StorageFailure() => l10n.errorStorage,
    CaptureFailure(reason: CaptureError.unsupported) =>
      l10n.errorCaptureUnsupported,
    CaptureFailure(reason: CaptureError.consentDenied) =>
      l10n.errorCaptureConsent,
    CaptureFailure(reason: CaptureError.busy) => l10n.errorCaptureBusy,
    CaptureFailure(reason: CaptureError.captureFailed) =>
      l10n.errorCaptureFailed,
    CancelledFailure() || UnknownFailure() => l10n.errorUnknown,
  };
}
