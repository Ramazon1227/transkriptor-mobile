import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

part 'recovery_cubit.freezed.dart';

enum RecoveryStatus { initial, loading, success, empty, failure }

@freezed
abstract class RecoveryState with _$RecoveryState {
  const factory RecoveryState({
    @Default(RecoveryStatus.initial) RecoveryStatus status,
    @Default(<RecoverableRecording>[]) List<RecoverableRecording> items,

    /// The item being recovered or deleted; its row shows progress.
    String? busyPath,

    /// Set once a recovery succeeded; the page sends it to the send page
    /// and calls [RecoveryCubit.consumed].
    PendingFile? recovered,

    /// Of the last load, recover or discard. Items stay on screen.
    Failure? failure,
  }) = _RecoveryState;
}

/// Unsent recordings from earlier sessions (see `RecordingsStore`).
@injectable
class RecoveryCubit extends Cubit<RecoveryState> {
  RecoveryCubit(this._facade) : super(const RecoveryState());

  final IRecorderFacade _facade;

  Future<void> load() async {
    emit(state.copyWith(status: RecoveryStatus.loading, failure: null));
    final result = await _facade.recoverable();
    if (isClosed) return;
    result.fold(
      (f) => emit(state.copyWith(status: RecoveryStatus.failure, failure: f)),
      (items) => emit(
        state.copyWith(
          status: items.isEmpty ? RecoveryStatus.empty : RecoveryStatus.success,
          items: items,
        ),
      ),
    );
  }

  Future<void> discard(RecoverableRecording item) async {
    if (state.busyPath != null) return;
    emit(state.copyWith(busyPath: item.path, failure: null));
    final result = await _facade.discardRecoverable(item);
    if (isClosed) return;
    result.fold(
      (f) => emit(state.copyWith(busyPath: null, failure: f)),
      (_) => _removed(item.path),
    );
  }

  /// [title] is the localised file name the send page starts with.
  Future<void> recover(
    RecoverableRecording item, {
    required String title,
  }) async {
    if (state.busyPath != null) return;
    emit(state.copyWith(busyPath: item.path, failure: null));
    final result = await _facade.recover(item, title: title);
    if (isClosed) return;
    result.fold((f) => emit(state.copyWith(busyPath: null, failure: f)), (
      file,
    ) {
      _removed(item.path);
      emit(state.copyWith(recovered: file));
    });
  }

  /// The page has taken [RecoveryState.recovered].
  void consumed() => emit(state.copyWith(recovered: null));

  void _removed(String path) {
    final items = state.items.where((i) => i.path != path).toList();
    emit(
      state.copyWith(
        busyPath: null,
        items: items,
        status: items.isEmpty ? RecoveryStatus.empty : RecoveryStatus.success,
      ),
    );
  }
}
