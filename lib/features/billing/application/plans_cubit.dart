import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';

part 'plans_cubit.freezed.dart';

enum PlansStatus { initial, loading, success, empty, failure }

@freezed
abstract class PlansState with _$PlansState {
  const factory PlansState({
    @Default(PlansStatus.initial) PlansStatus status,
    @Default(<Plan>[]) List<Plan> plans,
    Failure? failure,
  }) = _PlansState;
}

@injectable
class PlansCubit extends Cubit<PlansState> {
  PlansCubit(this._facade) : super(const PlansState());

  final IBillingFacade _facade;

  Future<void> load() async {
    emit(state.copyWith(status: PlansStatus.loading, failure: null));
    final result = await _facade.plans();
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: PlansStatus.failure, failure: failure)),
      (plans) => emit(
        PlansState(
          status: plans.isEmpty ? PlansStatus.empty : PlansStatus.success,
          plans: plans,
        ),
      ),
    );
  }
}
