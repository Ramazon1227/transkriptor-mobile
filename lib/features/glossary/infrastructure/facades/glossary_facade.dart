import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/glossary/domain/entities/glossary.dart';
import 'package:transkriptor_uz/features/glossary/domain/i_glossary_facade.dart';
import 'package:transkriptor_uz/features/glossary/infrastructure/repositories/glossary_repository.dart';

@LazySingleton(as: IGlossaryFacade)
class GlossaryFacade implements IGlossaryFacade {
  GlossaryFacade(this._repository);

  final GlossaryRepository _repository;

  @override
  Future<Either<Failure, List<Glossary>>> glossaries({
    required String workspaceId,
  }) async {
    final result = await _repository.glossaries(workspaceId: workspaceId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }
}
