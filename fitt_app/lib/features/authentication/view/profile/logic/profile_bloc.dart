import 'package:equatable/equatable.dart';
import 'package:fitt_app/features/authentication/domain/interactor/profile_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/user_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<AuthEvent, AuthState> {
  final ProfileInteractor _profileInteractor = ProfileInteractor();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileCreate>((event, emit) async {
      emit(ProfileLoading());
      await _profileInteractor.createProfile(
        userProfile: UserProfileModel(userId: 'event.nickname', createdAt: DateTime.now(), userEmail: event.nickname)
      );
      emit(ProfileCreatedSuccess(nickname: event.nickname, age: event.age));
    });
  }
}
