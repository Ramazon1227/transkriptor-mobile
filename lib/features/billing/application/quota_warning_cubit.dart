import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/billing/domain/i_quota_warning_facade.dart';
import 'package:transkriptor_uz/features/billing/domain/quota.dart';

part 'quota_warning_cubit.freezed.dart';

@freezed
abstract class QuotaWarningState with _$QuotaWarningState {
  const factory QuotaWarningState({
    String? workspaceId,
    Balance? balance,
    @Default(QuotaLevel.none) QuotaLevel level,

    /// The closable 95 % warning is on screen.
    @Default(false) bool banner,
  }) = _QuotaWarningState;
}

/// The minute warning (B-18): a mark next to the balance at 80 % of the
/// plan's minutes used, a closable warning at 95 % — once per period on
/// this phone. A failed balance call shows nothing: it is a hint, not a
/// gate (the server still refuses an upload the balance cannot cover).
@injectable
class QuotaWarningCubit extends Cubit<QuotaWarningState> {
  QuotaWarningCubit(this._billing, this._closed)
    : super(const QuotaWarningState());

  final IBillingFacade _billing;
  final IQuotaWarningFacade _closed;

  Future<void> load(String workspaceId) async {
    if (state.workspaceId != workspaceId) {
      emit(QuotaWarningState(workspaceId: workspaceId));
    }
    final result = await _billing.balance(workspaceId);
    if (isClosed || state.workspaceId != workspaceId) return;
    final balance = result.fold((_) => null, (b) => b);
    if (balance == null) return;
    final level = Quota.level(
      balance.balanceSeconds,
      balance.plan?.monthlySeconds ?? 0,
    );
    var closed = await _closed.closedPeriod(workspaceId);
    if (level == QuotaLevel.none && closed != null) {
      await _closed.forget(workspaceId);
      closed = null;
    }
    if (isClosed || state.workspaceId != workspaceId) return;
    emit(
      state.copyWith(
        balance: balance,
        level: level,
        banner: level == QuotaLevel.critical && closed != Quota.period(balance),
      ),
    );
  }

  Future<void> dismiss() async {
    final workspaceId = state.workspaceId;
    final balance = state.balance;
    if (workspaceId == null || balance == null) return;
    emit(state.copyWith(banner: false));
    await _closed.close(workspaceId, Quota.period(balance));
  }
}
