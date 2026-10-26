import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';

abstract interface class ILibraryFacade {
  /// Files of [workspaceId], newest first, in the API's order.
  Future<Either<Failure, List<LibraryItem>>> getItems({
    required String workspaceId,
  });
}
