// DEMO SOURCE — replaced by `POST /media/url` once the backend has it.
// It makes no request at all: it must never reach an STT or job endpoint
// (a job there is a live GPU call). It only answers "not available yet",
// and the page shows the demo banner.

import 'package:dartz/dartz.dart' show Either, Right;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/url_import_result.dart';

@lazySingleton
class DemoUrlImportRepository {
  Future<Either<Failure, UrlImportResult>> importUrl({
    required String url,
    required String workspaceId,
  }) async => const Right(UrlImportResult.notAvailable());
}
