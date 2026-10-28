part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

/// The page opened: ask the backend whether Google sign-in is on.
final class LoginStarted extends LoginEvent {
  const LoginStarted();
}

/// «Google bilan kirish».
final class LoginGoogleRequested extends LoginEvent {
  const LoginGoogleRequested();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted({required this.email, required this.password});

  final String email;
  final String password;
}
