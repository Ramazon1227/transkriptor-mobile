import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';

part 'note_cubit.freezed.dart';

enum NoteStatus { initial, loading, success, failure }

/// Rename or delete; one at a time. [done] closes the open sheet.
enum NoteActionStatus { idle, busy, done, failure }

@freezed
abstract class NoteState with _$NoteState {
  const factory NoteState({
    @Default(NoteStatus.initial) NoteStatus status,
    String? noteId,
    Note? note,
    Failure? failure,
    @Default(NoteActionStatus.idle) NoteActionStatus actionStatus,
    Failure? actionFailure,

    /// Renamed or deleted here: the list behind reloads on the way back.
    @Default(false) bool changed,

    /// Deleted: the page closes.
    @Default(false) bool deleted,
  }) = _NoteState;
}

/// One note, read-only, with rename and delete.
@injectable
class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this._facade) : super(const NoteState());

  final INotesFacade _facade;

  Future<void> load(String id) async {
    emit(state.copyWith(status: NoteStatus.loading, noteId: id, failure: null));
    final result = await _facade.get(id);
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: NoteStatus.failure, failure: failure)),
      (note) => emit(state.copyWith(status: NoteStatus.success, note: note)),
    );
  }

  /// [title] is already normalised by `NoteRules`; the same title sends
  /// nothing.
  Future<void> rename(String title) async {
    final note = state.note;
    if (note == null) return;
    if (note.title == title) {
      emit(state.copyWith(actionStatus: NoteActionStatus.done));
      return;
    }
    await _act(
      () => _facade.rename(id: note.id, title: title, revision: note.revision),
      (renamed) => state.copyWith(note: renamed as Note),
    );
  }

  Future<void> delete() async {
    final note = state.note;
    if (note == null) return;
    await _act(
      () => _facade.delete(note.id),
      (_) => state.copyWith(deleted: true),
    );
  }

  /// A sheet that opens starts without the previous failure.
  void resetAction() => emit(
    state.copyWith(actionStatus: NoteActionStatus.idle, actionFailure: null),
  );

  Future<void> _act(
    Future<Either<Failure, Object>> Function() call,
    NoteState Function(Object value) onDone,
  ) async {
    if (state.actionStatus == NoteActionStatus.busy) return;
    emit(
      state.copyWith(actionStatus: NoteActionStatus.busy, actionFailure: null),
    );
    final result = await call();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          actionStatus: NoteActionStatus.failure,
          actionFailure: failure,
        ),
      ),
      (value) => emit(
        onDone(
          value,
        ).copyWith(actionStatus: NoteActionStatus.done, changed: true),
      ),
    );
  }
}
