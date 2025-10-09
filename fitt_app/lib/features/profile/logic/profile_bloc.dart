import 'package:equatable/equatable.dart';
import 'package:fitt_app/features/authentication/domain/service/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../authentication/domain/interactor/profile_interactor.dart';
import '../../authentication/domain/model/user_profile_model.dart';

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

    on<LogoutEvent>((event, emit) async {
      final AuthService authService = GetIt.instance<AuthService>();
      authService.signOut();
    });
  }
}
