import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';

/// Notes are the caller's own: the server lists, shows and changes only
/// notes the caller wrote, in any role (a VIEWER too).
abstract interface class INotesFacade {
  /// The caller's notes in [workspaceId], most recently changed first.
  /// [cursor] is the previous page's `nextCursor`.
  Future<Either<Failure, NotesPage>> list({
    required String workspaceId,
    String? cursor,
  });

  Future<Either<Failure, Note>> get(String id);

  /// 409 when [revision] is stale (changed in another window).
  Future<Either<Failure, Note>> rename({
    required String id,
    required String title,
    required int revision,
  });

  Future<Either<Failure, Unit>> delete(String id);
}
