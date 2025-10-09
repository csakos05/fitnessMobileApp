
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fitt_app/features/authentication/domain/interactor/profile_interactor.dart';
import 'package:fitt_app/infrastructure/configuration_api/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/domain/service/auth_service.dart';
import 'infrastructure/configuration_api/config_notifier.dart';

void registerTypesToIoCBeforeRunApp() {
final services = GetIt.instance;

services.registerSingleton<ConfigNotifier>(ConfigNotifier());
services.registerSingleton<ConfigurationService>(ConfigurationService(
  configNotifier: services.get<ConfigNotifier>(),
  remoteConfig: FirebaseRemoteConfig.instance,
));
services.registerSingleton<ProfileInteractor>(ProfileInteractor());
services.registerSingleton<AuthService>(AuthService());
}

Future<void> registerTypesToIoCAfterRunApp({required Locale locale}) async {
  // final services = GetIt.instance;

  // final ApiConfig apiConfig = services.get<ApiConfig>();
  // final HttpService httpService = services.get<HttpService>();

}

void registerBlocsAfterRunApp() {
  // final services = GetIt.instance;
}

Future<void> registerBlocsBeforeRunApp() async {}


