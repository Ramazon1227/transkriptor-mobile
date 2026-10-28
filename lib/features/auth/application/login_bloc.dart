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
    on<LoginGoogleRequested>(_onGoogle, transformer: droppable());
    on<LoginStarted>(_onStarted);
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

    if (state.status == LoginStatus.loading) return;
    emit(
      state.copyWith(
        status: LoginStatus.loading,
        emailMissing: false,
        passwordMissing: false,
        failure: null,
        viaGoogle: false,
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

  Future<void> _onStarted(LoginStarted event, Emitter<LoginState> emit) async {
    final result = await _facade.googleClientId();
    // No answer is the same as "off": the email form still works.
    result.fold((_) {}, (id) => emit(state.copyWith(googleClientId: id)));
  }

  Future<void> _onGoogle(
    LoginGoogleRequested event,
    Emitter<LoginState> emit,
  ) async {
    final clientId = state.googleClientId;
    if (clientId == null || state.status == LoginStatus.loading) return;
    emit(
      state.copyWith(
        status: LoginStatus.loading,
        emailMissing: false,
        passwordMissing: false,
        failure: null,
        viaGoogle: true,
      ),
    );
    final result = await _facade.signInWithGoogle(clientId: clientId);
    result.fold(
      // Closing the picker is not an error worth a red line.
      (failure) => emit(
        failure is CancelledFailure
            ? state.copyWith(status: LoginStatus.initial)
            : state.copyWith(status: LoginStatus.failure, failure: failure),
      ),
      (account) =>
          emit(state.copyWith(status: LoginStatus.success, account: account)),
    );
  }
}
