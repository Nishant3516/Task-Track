part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;

  const SignupRequested(this.email, this.password);
}
