import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/url_import_result.dart';
import 'package:transkriptor_uz/features/capture/domain/i_url_import_facade.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/demo/demo_url_import_repository.dart';

@LazySingleton(as: IUrlImportFacade)
class UrlImportFacade implements IUrlImportFacade {
  UrlImportFacade(this._repository);

  final DemoUrlImportRepository _repository;

  @override
  Future<Either<Failure, UrlImportResult>> importUrl({
    required String url,
    required String workspaceId,
  }) => _repository.importUrl(url: url.trim(), workspaceId: workspaceId);
}
