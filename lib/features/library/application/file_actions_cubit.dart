import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';

part 'file_actions_cubit.freezed.dart';

enum FileActionStatus { idle, busy, done, failure }

@freezed
abstract class FileActionsState with _$FileActionsState {
  const factory FileActionsState({
    @Default(FileActionStatus.idle) FileActionStatus status,

    /// The row as the server returned it after the change; null after a
    /// delete or a retranscription.
    LibraryItem? item,

    /// The new job after «Qayta transkripsiya»; the sheet opens its page.
    String? jobId,
    Failure? failure,
  }) = _FileActionsState;
}

/// One file's sheet: rename, move, tags, retranscribe, delete. Not
/// optimistic — the sheet closes on the server's answer, and the lists
/// reload from [LibraryChanges].
@injectable
class FileActionsCubit extends Cubit<FileActionsState> {
  FileActionsCubit(this._facade, this._jobs, this._changes)
    : super(const FileActionsState());

  final ILibraryFacade _facade;
  final IJobFacade _jobs;
  final LibraryChanges _changes;

  /// [name] is already normalised by `FileRules`; the same name sends
  /// nothing.
  Future<void> rename(LibraryItem item, String name) async {
    if (item.name == name) {
      emit(FileActionsState(status: FileActionStatus.done, item: item));
      return;
    }
    await _run(() => _facade.rename(mediaId: item.mediaId, name: name));
  }

  Future<void> delete(LibraryItem item) => _run(
    () async => (await _facade.deleteMedia(item.mediaId)).map((_) => null),
  );

  /// A new job for the same file, as the web's retry does: a fresh
  /// idempotency key (the repository makes one per call) and the speaker
  /// count of the previous job. When that job cannot be read the server
  /// decides the count, rather than the retry failing for it.
  Future<void> retranscribe(LibraryItem item) => _run(() async {
    int? speakers;
    final previous = item.jobId;
    if (previous != null) {
      final job = await _jobs.getJob(previous);
      speakers = job.fold((_) => null, (j) => j.numSpeakers);
    }
    final result = await _jobs.createJob(
      mediaId: item.mediaId,
      numSpeakers: speakers,
    );
    return result.map((job) => job.id);
  });

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

  /// [call] answers with the changed row, a new job id, or null.
  Future<void> _run(Future<Either<Failure, Object?>> Function() call) async {
    if (state.status == FileActionStatus.busy) return;
    emit(const FileActionsState(status: FileActionStatus.busy));
    final result = await call();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        FileActionsState(status: FileActionStatus.failure, failure: failure),
      ),
      (value) {
        emit(
          FileActionsState(
            status: FileActionStatus.done,
            item: value is LibraryItem ? value : null,
            jobId: value is String ? value : null,
          ),
        );
        _changes.notify();
      },
    );
  }
}
