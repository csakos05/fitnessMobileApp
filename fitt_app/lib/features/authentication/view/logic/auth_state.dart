part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthState {
  final String nickname;
  final int age;

  const Authenticated({required this.nickname, required this.age});

  @override
  List<Object> get props => [nickname, age];
}