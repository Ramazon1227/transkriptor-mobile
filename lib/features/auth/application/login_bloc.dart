import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._facade) : super(const LoginState()) {
    // A second tap while the first request runs is ignored.
    on<LoginSubmitted>(_onSubmitted, transformer: droppable());
  }

  final IAuthFacade _facade;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final email = event.email.trim();
    final emailMissing = email.isEmpty;
    final passwordMissing = event.password.isEmpty;
    if (emailMissing || passwordMissing) {
      emit(
        state.copyWith(
          status: LoginStatus.initial,
          emailMissing: emailMissing,
          passwordMissing: passwordMissing,
          failure: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: LoginStatus.loading,
        emailMissing: false,
        passwordMissing: false,
        failure: null,
      ),
    );

    final result = await _facade.login(email: email, password: event.password);

    result.fold(
      (failure) =>
          emit(state.copyWith(status: LoginStatus.failure, failure: failure)),
      (account) =>
          emit(state.copyWith(status: LoginStatus.success, account: account)),
    );
  }
}
