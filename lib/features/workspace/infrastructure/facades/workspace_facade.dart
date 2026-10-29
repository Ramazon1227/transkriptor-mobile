import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/workspace/domain/i_workspace_facade.dart';
import 'package:transkriptor_uz/features/workspace/infrastructure/repositories/workspace_repository.dart';
import 'package:transkriptor_uz/features/workspace/infrastructure/storage/workspace_selection_storage.dart';

@LazySingleton(as: IWorkspaceFacade)
class WorkspaceFacade implements IWorkspaceFacade {
  WorkspaceFacade(this._repository, this._storage);

  final WorkspaceRepository _repository;
  final WorkspaceSelectionStorage _storage;

  @override
  Future<Either<Failure, List<Workspace>>> listWorkspaces() async {
    final result = await _repository.list();
    return result.map((m) => m.items.map((w) => w.toEntity()).toList());
  }

  @override
  Future<String?> selectedWorkspaceId() async {
    try {
      final id = await _storage.read();
      return id == null || id.isEmpty ? null : id;
    } on Object {
      // An unreadable keychain only means the personal workspace.
      return null;
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSelectedWorkspaceId(String id) async {
    try {
      await _storage.write(id);
      return const Right(unit);
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<void> clearSelectedWorkspace() async {
    try {
      await _storage.clear();
    } on Object {
      // A stale id is harmless: an id that is not theirs falls back.
    }
  }
}
