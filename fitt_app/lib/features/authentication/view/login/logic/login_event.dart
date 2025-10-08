part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPasswordRequested extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginWithGoogleRequested extends LoginEvent {
  const LoginWithGoogleRequested();
}