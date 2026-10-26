import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/domain/password_rules.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._facade) : super(const RegisterState()) {
    // A second tap while the first request runs is ignored.
    on<RegisterSubmitted>(_onSubmitted, transformer: droppable());
  }

  final IAuthFacade _facade;

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final email = event.email.trim();
    final emailInvalid = !_looksLikeEmail(email);
    final passwordProblem = PasswordRules.check(event.password);
    if (emailInvalid || passwordProblem != null) {
      emit(
        RegisterState(
          emailInvalid: emailInvalid,
          passwordProblem: passwordProblem,
        ),
      );
      return;
    }

    emit(const RegisterState(status: RegisterStatus.loading));

    final result = await _facade.register(
      email: email,
      password: event.password,
      fullName: event.fullName.trim(),
    );

    result.fold(
      (failure) =>
          emit(RegisterState(status: RegisterStatus.failure, failure: failure)),
      (account) =>
          emit(RegisterState(status: RegisterStatus.success, account: account)),
    );
  }

  /// A shape check only; the server has the final word.
  static bool _looksLikeEmail(String s) {
    final at = s.indexOf('@');
    return at > 0 && at == s.lastIndexOf('@') && s.indexOf('.', at) > at + 1;
  }
}
