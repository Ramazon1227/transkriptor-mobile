import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/workspace/domain/i_workspace_facade.dart';

part 'workspace_list_cubit.freezed.dart';

enum WorkspaceListStatus { initial, loading, success, empty, failure }

@freezed
abstract class WorkspaceListState with _$WorkspaceListState {
  const factory WorkspaceListState({
    @Default(WorkspaceListStatus.initial) WorkspaceListStatus status,
    @Default(<Workspace>[]) List<Workspace> items,
    Failure? failure,
  }) = _WorkspaceListState;
}

/// The switcher's list, fetched fresh each time it opens: a workspace
/// created or joined on the web shows up without a restart.
@injectable
class WorkspaceListCubit extends Cubit<WorkspaceListState> {
  WorkspaceListCubit(this._facade) : super(const WorkspaceListState());

  final IWorkspaceFacade _facade;

  Future<void> load() async {
    emit(state.copyWith(status: WorkspaceListStatus.loading, failure: null));
    final result = await _facade.listWorkspaces();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: WorkspaceListStatus.failure, failure: failure),
      ),
      (items) => emit(
        WorkspaceListState(
          status: items.isEmpty
              ? WorkspaceListStatus.empty
              : WorkspaceListStatus.success,
          items: items,
        ),
      ),
    );
  }
}
