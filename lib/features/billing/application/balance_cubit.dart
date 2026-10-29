import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';

part 'balance_cubit.freezed.dart';

enum BalanceStatus { initial, loading, success, failure }

@freezed
abstract class BalanceState with _$BalanceState {
  const factory BalanceState({
    @Default(BalanceStatus.initial) BalanceStatus status,
    String? workspaceId,
    Balance? balance,
    Failure? failure,
  }) = _BalanceState;
}

/// One workspace's balance and plan, for the settings screen.
@injectable
class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit(this._facade) : super(const BalanceState());

  final IBillingFacade _facade;

  /// Loads [workspaceId]. A late answer for an older workspace is
  /// dropped; the same workspace keeps its last balance while reloading.
  Future<void> load(String workspaceId) async {
    final same = state.workspaceId == workspaceId;
    emit(
      BalanceState(
        status: BalanceStatus.loading,
        workspaceId: workspaceId,
        balance: same ? state.balance : null,
      ),
    );
    final result = await _facade.balance(workspaceId);
    if (isClosed || state.workspaceId != workspaceId) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: BalanceStatus.failure, failure: failure)),
      (balance) =>
          emit(state.copyWith(status: BalanceStatus.success, balance: balance)),
    );
  }
}
