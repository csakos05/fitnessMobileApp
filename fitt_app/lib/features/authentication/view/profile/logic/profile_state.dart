part of 'profile_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class ProfileInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class ProfileLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class ProfileCreatedSuccess extends AuthState {
  final String nickname;
  final int age;

  const ProfileCreatedSuccess({required this.nickname, required this.age});

  @override
  List<Object> get props => [nickname, age];
}