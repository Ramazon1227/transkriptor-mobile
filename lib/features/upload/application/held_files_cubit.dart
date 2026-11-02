import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

part 'held_files_cubit.freezed.dart';

@freezed
abstract class HeldFilesState with _$HeldFilesState {
  const factory HeldFilesState({
    @Default(<HeldFile>[]) List<HeldFile> items,

    /// The file being deleted; nothing else is deleted meanwhile.
    String? deletingId,
    Failure? failure,
  }) = _HeldFilesState;
}

/// The list a 409 PENDING_LIMIT named: deleting one frees a place.
@injectable
class HeldFilesCubit extends Cubit<HeldFilesState> {
  HeldFilesCubit(this._facade) : super(const HeldFilesState());

  final IUploadFacade _facade;

  void open(List<HeldFile> held) => emit(HeldFilesState(items: held));

  Future<void> delete(String id) async {
    if (state.deletingId != null) return;
    emit(state.copyWith(deletingId: id, failure: null));
    final result = await _facade.deleteHeld(id);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(deletingId: null, failure: failure)),
      (_) => emit(
        state.copyWith(
          deletingId: null,
          items: state.items.where((h) => h.id != id).toList(),
        ),
      ),
    );
  }
}
