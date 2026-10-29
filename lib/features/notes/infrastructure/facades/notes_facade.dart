import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';
import 'package:transkriptor_uz/features/notes/infrastructure/repositories/notes_repository.dart';

@LazySingleton(as: INotesFacade)
class NotesFacade implements INotesFacade {
  NotesFacade(this._repository);

  final NotesRepository _repository;

  @override
  Future<Either<Failure, NotesPage>> list({
    required String workspaceId,
    String? cursor,
  }) async {
    final result = await _repository.list(
      workspaceId: workspaceId,
      cursor: cursor,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Note>> get(String id) async {
    final result = await _repository.get(id);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Note>> rename({
    required String id,
    required String title,
    required int revision,
  }) async {
    final result = await _repository.rename(
      id: id,
      title: title,
      revision: revision,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) => _repository.delete(id);
}
