import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/interactor/profile_interactor.dart';
import '../../../domain/model/user_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileInteractor _profileInteractor = ProfileInteractor();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileCreate>((event, emit) async {
      emit(ProfileLoading());

      emit(ProfileCreatedSuccess(nickname: event.nickname, age: event.age));
    });

    on<ProfileRequestEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = _profileInteractor.getProfile();
        final profile = await user;
        emit(ProfileLoadSuccess(profile: profile));
      } catch (e) {
        emit(ProfileLoadFailure(error: e.toString()));
      }
    });
  }
}
