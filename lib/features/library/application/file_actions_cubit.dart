import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';

part 'file_actions_cubit.freezed.dart';

enum FileActionStatus { idle, busy, done, failure }

@freezed
abstract class FileActionsState with _$FileActionsState {
  const factory FileActionsState({
    @Default(FileActionStatus.idle) FileActionStatus status,

    /// The row as the server returned it after the change.
    LibraryItem? item,
    Failure? failure,
  }) = _FileActionsState;
}

/// One file's sheet: move it to a folder or replace its tags. Not
/// optimistic — the sheet closes on the server's answer, and the lists
/// reload from [LibraryChanges].
@injectable
class FileActionsCubit extends Cubit<FileActionsState> {
  FileActionsCubit(this._facade, this._changes)
    : super(const FileActionsState());

  final ILibraryFacade _facade;
  final LibraryChanges _changes;

  /// [folderId] null moves the file out of every folder.
  Future<void> move(LibraryItem item, String? folderId) async {
    if (item.folderId == folderId) {
      emit(FileActionsState(status: FileActionStatus.done, item: item));
      return;
    }
    await _run(
      () => _facade.moveToFolder(mediaId: item.mediaId, folderId: folderId),
    );
  }

  /// [tags] are already normalised by `TagRules`.
  Future<void> setTags(LibraryItem item, List<String> tags) =>
      _run(() => _facade.setTags(mediaId: item.mediaId, tags: tags));

  Future<void> _run(
    Future<Either<Failure, LibraryItem>> Function() call,
  ) async {
    if (state.status == FileActionStatus.busy) return;
    emit(const FileActionsState(status: FileActionStatus.busy));
    final result = await call();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        FileActionsState(status: FileActionStatus.failure, failure: failure),
      ),
      (item) {
        emit(FileActionsState(status: FileActionStatus.done, item: item));
        _changes.notify();
      },
    );
  }
}
