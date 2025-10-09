part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileCreatedSuccess extends ProfileState {
  final String nickname;
  final int age;

  const ProfileCreatedSuccess({required this.nickname, required this.age});

  @override
  List<Object> get props => [nickname, age];
}

final class ProfileLoadSuccess extends ProfileState {
  final UserProfileModel profile;

  const ProfileLoadSuccess({required this.profile});

  @override
  List<Object> get props => [profile];
}

final class ProfileLoadFailure extends ProfileState {
  final String error;

  const ProfileLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ProfileUpdateSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileUpdateFailure extends ProfileState {
  final String error;

  const ProfileUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}