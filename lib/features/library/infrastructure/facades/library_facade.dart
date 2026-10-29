import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
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
    String? folderId,
    MediaSource? source,
  }) async {
    final result = await _repository.getItems(
      workspaceId: workspaceId,
      folderId: folderId,
      source: switch (source) {
        null || MediaSource.unknown => null,
        MediaSource.upload => 'UPLOAD',
        MediaSource.recording => 'RECORDING',
        MediaSource.url => 'URL',
        MediaSource.api => 'API',
      },
    );
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<Folder>>> getFolders({
    required String workspaceId,
  }) async {
    final result = await _repository.getFolders(workspaceId: workspaceId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, Folder>> createFolder({
    required String workspaceId,
    required String name,
  }) async {
    final result = await _repository.createFolder(
      workspaceId: workspaceId,
      name: name,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Folder>> renameFolder({
    required String workspaceId,
    required String folderId,
    required String name,
  }) async {
    final result = await _repository.renameFolder(
      workspaceId: workspaceId,
      folderId: folderId,
      name: name,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> deleteFolder({
    required String workspaceId,
    required String folderId,
  }) => _repository.deleteFolder(workspaceId: workspaceId, folderId: folderId);

  @override
  Future<Either<Failure, LibraryItem>> moveToFolder({
    required String mediaId,
    required String? folderId,
  }) async {
    final result = await _repository.updateMedia(
      mediaId: mediaId,
      patch: {'folder_id': folderId},
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, LibraryItem>> rename({
    required String mediaId,
    required String name,
  }) async {
    final result = await _repository.updateMedia(
      mediaId: mediaId,
      patch: {'display_name': name},
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> deleteMedia(String mediaId) =>
      _repository.deleteMedia(mediaId);

  @override
  Future<Either<Failure, LibraryItem>> setTags({
    required String mediaId,
    required List<String> tags,
  }) async {
    final result = await _repository.updateMedia(
      mediaId: mediaId,
      patch: {'tags': tags},
    );
    return result.map((m) => m.toEntity());
  }
}
