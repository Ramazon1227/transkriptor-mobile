import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';

/// Why a folder or file change did not go through. The files screen has
/// two answers of its own; everything else is the app-wide sentence.
String libraryFailureText(AppLocalizations l10n, Failure failure) =>
    switch (failure) {
      // A VIEWER can read the files but not change them.
      ServerFailure(statusCode: 403) => l10n.filesForbidden,
      ServerFailure(statusCode: 409) => l10n.folderExists,
      // A move into a folder deleted on another device.
      ServerFailure(statusCode: 422) => l10n.folderGone,
      _ => failure.message(l10n),
    };
