part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted({
    required this.fullName,
    required this.email,
    required this.password,
  });

  /// May be empty; the backend allows an account without a name.
  final String fullName;
  final String email;
  final String password;
}
