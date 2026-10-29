import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/url_import_result.dart';

/// Hands a direct audio/video file URL to the server. YouTube, Drive and
/// Dropbox links never come here: they go through the upload link flow.
abstract interface class IUrlImportFacade {
  Future<Either<Failure, UrlImportResult>> importUrl({
    required String url,
    required String workspaceId,
  });
}
