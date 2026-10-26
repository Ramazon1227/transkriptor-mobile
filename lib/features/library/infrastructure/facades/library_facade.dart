import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/infrastructure/repositories/library_repository.dart';

@LazySingleton(as: ILibraryFacade)
class LibraryFacade implements ILibraryFacade {
  LibraryFacade(this._repository);

  final LibraryRepository _repository;

  @override
  Future<Either<Failure, List<LibraryItem>>> getItems({
    required String workspaceId,
  }) async {
    final result = await _repository.getItems(workspaceId: workspaceId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }
}
