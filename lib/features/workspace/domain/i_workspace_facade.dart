import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';

abstract interface class IWorkspaceFacade {
  /// Every workspace the caller belongs to, each with their role
  /// (`GET /workspaces`), in the server's order.
  Future<Either<Failure, List<Workspace>>> listWorkspaces();

  /// The workspace id stored by the last switch; null when none was
  /// stored or the storage could not be read.
  Future<String?> selectedWorkspaceId();

  /// Remembers [id] for the next start.
  Future<Either<Failure, Unit>> saveSelectedWorkspaceId(String id);

  /// Forgets the choice (sign-out), so the next account starts in its
  /// personal workspace. Never fails.
  Future<void> clearSelectedWorkspace();
}
