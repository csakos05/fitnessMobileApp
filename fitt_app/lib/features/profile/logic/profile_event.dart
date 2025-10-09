part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileCreate extends ProfileEvent {
  final String nickname;
  final int age;

  const ProfileCreate({required this.nickname, required this.age});

  @override
  List<Object> get props => [nickname, age];
}

class ProfileRequestEvent extends ProfileEvent {
  const ProfileRequestEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateEvent extends ProfileEvent {
  final UserProfileModel profile;

  const ProfileUpdateEvent({required this.profile});

  @override
  List<Object> get props => [profile];
}