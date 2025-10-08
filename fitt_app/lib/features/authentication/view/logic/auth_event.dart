part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class ProfileCreate extends AuthEvent {
  final String nickname;
  final int age;

  const ProfileCreate({required this.nickname, required this.age});

  @override
  List<Object> get props => [nickname, age];
}