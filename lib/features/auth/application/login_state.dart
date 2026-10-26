part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    @Default(false) bool emailMissing,
    @Default(false) bool passwordMissing,
    Account? account,
    Failure? failure,
  }) = _LoginState;
}
