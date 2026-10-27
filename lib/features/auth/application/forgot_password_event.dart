part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

final class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  const ForgotPasswordSubmitted({required this.email});

  final String email;
}

/// "Send again": back to the form, which still holds the email.
final class ForgotPasswordRestarted extends ForgotPasswordEvent {
  const ForgotPasswordRestarted();
}
