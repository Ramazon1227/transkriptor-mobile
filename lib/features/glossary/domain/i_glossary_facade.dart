import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/glossary/domain/entities/glossary.dart';

abstract interface class IGlossaryFacade {
  /// The workspace's «Atamalar» lists (`GET /glossaries`), in the API's
  /// order. A workspace without lists is an empty list, not an error.
  Future<Either<Failure, List<Glossary>>> glossaries({
    required String workspaceId,
  });
}
