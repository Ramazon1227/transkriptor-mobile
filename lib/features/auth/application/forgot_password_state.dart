part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus { initial, loading, success, failure }

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(ForgotPasswordStatus.initial) ForgotPasswordStatus status,
    @Default(false) bool emailInvalid,

    /// The address the request went to, shown on the "check your mail"
    /// screen. Success does not mean an account exists for it.
    String? sentTo,
    Failure? failure,
  }) = _ForgotPasswordState;
}
