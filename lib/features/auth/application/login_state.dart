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

    /// The backend's Google web client id; null hides the Google button
    /// (off on the server, or the check failed).
    String? googleClientId,

    /// The last attempt was Google's, so a 401 is not a wrong password.
    @Default(false) bool viaGoogle,
  }) = _LoginState;
}
