import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitt_app/features/authentication/domain/service/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService = AuthService();

  LoginBloc()
      :
        super(LoginInitial()) {
    on<LoginWithEmailAndPasswordRequested>(_onLoginWithEmailAndPasswordRequested);
    on<LoginWithGoogleRequested>(_onLoginWithGoogleRequested);
  }

  Future<void> _onLoginWithEmailAndPasswordRequested(
    LoginWithEmailAndPasswordRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await _authService.signInWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onLoginWithGoogleRequested(
    LoginWithGoogleRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        emit(LoginSuccess());
      } else {
        // User cancelled the flow
        emit(LoginInitial());
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}