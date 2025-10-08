import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      // Simulate a delay for authentication process
      await Future.delayed(const Duration(seconds: 2));
      // After "authentication", emit Authenticated state
      emit(Authenticated(nickname: event.nickname, age: event.age));
    });
  }
}
