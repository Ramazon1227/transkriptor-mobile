part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(RegisterStatus.initial) RegisterStatus status,
    @Default(false) bool emailInvalid,

    /// Null when the password passes the backend's rules.
    PasswordProblem? passwordProblem,
    Account? account,
    Failure? failure,
  }) = _RegisterState;
}
