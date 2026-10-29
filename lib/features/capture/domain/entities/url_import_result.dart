import 'package:freezed_annotation/freezed_annotation.dart';

part 'url_import_result.freezed.dart';

/// What handing a direct file URL to the server gave.
@freezed
sealed class UrlImportResult with _$UrlImportResult {
  /// The server took it and started transcription.
  const factory UrlImportResult.started({required String jobId}) =
      UrlImportStarted;

  /// The server has no direct-URL import yet (today, always).
  const factory UrlImportResult.notAvailable() = UrlImportNotAvailable;
}
