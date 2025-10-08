part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String nickname;
  final int age;

  const LoginRequested({required this.nickname, required this.age});

  @override
  List<Object> get props => [nickname, age];
}