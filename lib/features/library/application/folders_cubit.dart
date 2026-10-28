import 'dart:async';

import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';

part 'folders_cubit.freezed.dart';

enum FoldersStatus { initial, loading, success, empty, failure }

/// Create, rename or delete; one at a time.
enum FolderActionStatus { idle, busy, failure }

@freezed
abstract class FoldersState with _$FoldersState {
  const factory FoldersState({
    @Default(FoldersStatus.initial) FoldersStatus status,
    @Default(<Folder>[]) List<Folder> folders,
    Failure? failure,
    @Default(FolderActionStatus.idle) FolderActionStatus actionStatus,
    Failure? actionFailure,
  }) = _FoldersState;
}

/// The files screen's folder bar. Independent of the file list: a failed
/// folder load keeps the files, and the other way round.
@injectable
class FoldersCubit extends Cubit<FoldersState> {
  FoldersCubit(this._facade, this._changes) : super(const FoldersState()) {
    // A file moved or deleted changes the counts.
    _sub = _changes.stream.listen((_) => unawaited(_reload()));
  }

  final ILibraryFacade _facade;
  final LibraryChanges _changes;
  late final StreamSubscription<void> _sub;
  String? _workspaceId;

  /// Bumped on every list request; an older answer is dropped.
  int _generation = 0;

  @override
  Future<void> close() async {
    await _sub.cancel();
    await super.close();
  }

  /// [workspaceId] comes from the signed-in account.
  Future<void> load(String workspaceId) {
    _workspaceId = workspaceId;
    emit(state.copyWith(status: FoldersStatus.loading, failure: null));
    return _reload();
  }

  /// Pull to refresh: a folder made, renamed or deleted on another device.
  Future<void> refresh() => _reload();

  Future<void> create(String name) =>
      _act((ws) => _facade.createFolder(workspaceId: ws, name: name));

  Future<void> rename(String folderId, String name) => _act(
    (ws) =>
        _facade.renameFolder(workspaceId: ws, folderId: folderId, name: name),
  );

  Future<void> delete(String folderId) =>
      _act((ws) => _facade.deleteFolder(workspaceId: ws, folderId: folderId));

  /// After a failure is shown, the next dialog starts clean.
  void clearActionFailure() => emit(
    state.copyWith(actionStatus: FolderActionStatus.idle, actionFailure: null),
  );

  Future<void> _act(
    Future<Either<Failure, Object>> Function(String workspaceId) call,
  ) async {
    final ws = _workspaceId;
    if (ws == null || state.actionStatus == FolderActionStatus.busy) return;
    emit(
      state.copyWith(
        actionStatus: FolderActionStatus.busy,
        actionFailure: null,
      ),
    );
    final result = await call(ws);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          actionStatus: FolderActionStatus.failure,
          actionFailure: failure,
        ),
      ),
      (_) {
        emit(state.copyWith(actionStatus: FolderActionStatus.idle));
        // The list, the counts and — after a delete — the files' folder
        // all change on the server; everyone listening reloads.
        _changes.notify();
      },
    );
  }

  Future<void> _reload() async {
    final ws = _workspaceId;
    if (ws == null) return;
    final generation = ++_generation;
    final result = await _facade.getFolders(workspaceId: ws);
    if (isClosed || generation != _generation) return;
    result.fold(
      // A failed refresh keeps the folders on screen.
      (failure) => emit(
        state.copyWith(
          status: state.folders.isEmpty ? FoldersStatus.failure : state.status,
          failure: failure,
        ),
      ),
      (folders) => emit(
        state.copyWith(
          status: folders.isEmpty ? FoldersStatus.empty : FoldersStatus.success,
          folders: folders,
          failure: null,
        ),
      ),
    );
  }
}
