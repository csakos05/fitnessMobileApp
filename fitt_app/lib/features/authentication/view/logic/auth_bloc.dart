import 'package:equatable/equatable.dart';
import 'package:fitt_app/features/authentication/domain/interactor/auth_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/user_profile_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthInteractor _authInteractor = AuthInteractor();

  AuthBloc() : super(AuthInitial()) {
    on<ProfileCreate>((event, emit) async {
      emit(AuthLoading());
      // Simulate a delay for authentication process
      await Future.delayed(const Duration(seconds: 2));
      // After "authentication", emit Authenticated state
      await _authInteractor.createProfile(
        userProfile: UserProfileModel(username: event.nickname, age: event.age, userId: 'useridfirsttest')
      );
      emit(ProfileCreatedSuccess(nickname: event.nickname, age: event.age));
    });
  }
}
