import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/email_rules.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

part 'forgot_password_bloc.freezed.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this._facade) : super(const ForgotPasswordState()) {
    // A second tap while the first request runs is ignored.
    on<ForgotPasswordSubmitted>(_onSubmitted, transformer: droppable());
    on<ForgotPasswordRestarted>((_, emit) => emit(const ForgotPasswordState()));
  }

  final IAuthFacade _facade;

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = event.email.trim();
    if (!EmailRules.looksLikeEmail(email)) {
      emit(const ForgotPasswordState(emailInvalid: true));
      return;
    }

    emit(const ForgotPasswordState(status: ForgotPasswordStatus.loading));

    final result = await _facade.requestPasswordReset(email: email);

    result.fold(
      (failure) => emit(
        ForgotPasswordState(
          status: ForgotPasswordStatus.failure,
          failure: failure,
        ),
      ),
      (_) => emit(
        ForgotPasswordState(
          status: ForgotPasswordStatus.success,
          sentTo: email,
        ),
      ),
    );
  }
}
