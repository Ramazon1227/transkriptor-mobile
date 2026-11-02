import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

part 'pick_file_cubit.freezed.dart';

enum PickFileStatus { initial, picking, picked, failure }

@freezed
abstract class PickFileState with _$PickFileState {
  const factory PickFileState({
    @Default(PickFileStatus.initial) PickFileStatus status,
    @Default(<PendingFile>[]) List<PendingFile> files,
    Failure? failure,
  }) = _PickFileState;
}

/// Opens the system picker; the page navigates when files come back.
@injectable
class PickFileCubit extends Cubit<PickFileState> {
  PickFileCubit(this._facade) : super(const PickFileState());

  final IUploadFacade _facade;

  Future<void> pick() async {
    if (state.status == PickFileStatus.picking) return;
    emit(const PickFileState(status: PickFileStatus.picking));
    final result = await _facade.pickFiles();
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(PickFileState(status: PickFileStatus.failure, failure: failure)),
      (files) => emit(
        files.isEmpty
            ? const PickFileState()
            : PickFileState(status: PickFileStatus.picked, files: files),
      ),
    );
  }

  /// After navigating, so coming back does not navigate again.
  void consumed() => emit(const PickFileState());
}
