import 'package:fitt_app/features/authentication/domain/service/auth_service.dart';
import 'package:fitt_app/infrastructure/configuration_api/configuration_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'app_start_event.dart';
part 'app_start_state.dart';

class AppStartBloc extends Bloc<AppStartEvent, AppStartState> {
  final AuthService _authService = GetIt.instance<AuthService>();
  final ConfigurationService _configurationService = GetIt.instance<ConfigurationService>();
  AppStartBloc() : super(AppStartInitial()) {
    on<AppStartEvent>((event, emit) async {
      await _configurationService.checkVersion();
      await _authService.checkLoginStatus();
    });
  }
}
