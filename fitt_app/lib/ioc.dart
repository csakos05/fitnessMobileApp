
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fitt_app/features/appstart/masterdata/equipment/interactor/equipment_interactor.dart';
import 'package:fitt_app/features/appstart/masterdata/exercise/interactor/exercise_interactor.dart';
import 'package:fitt_app/features/appstart/masterdata/muscle/interactor/muscle_interactor.dart';
import 'package:fitt_app/features/authentication/domain/interactor/profile_interactor.dart';
import 'package:fitt_app/infrastructure/configuration_api/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/appstart/masterdata/workoutplan/interactor/workoutplan_interactor.dart';
import 'features/appstart/masterdata/workout/interactor/workout_interactor.dart';
import 'features/authentication/domain/service/auth_service.dart';
import 'features/profile/logic/profile_bloc.dart';
import 'infrastructure/configuration_api/config_notifier.dart';

void registerTypesToIoCBeforeRunApp() {
final services = GetIt.instance;

services.registerSingleton<ConfigNotifier>(ConfigNotifier());
services.registerSingleton<ConfigurationService>(ConfigurationService(
  configNotifier: services.get<ConfigNotifier>(),
  remoteConfig: FirebaseRemoteConfig.instance,
));
services.registerSingleton<ProfileInteractor>(ProfileInteractor());
services.registerSingleton<MuscleInteractor>(MuscleInteractor());
services.registerSingleton<EquipmentInteractor>(EquipmentInteractor());
services.registerSingleton<ExerciseInteractor>(ExerciseInteractor());
services.registerSingleton<WorkoutPlanInteractor>(WorkoutPlanInteractor());
services.registerSingleton<WorkoutInteractor>(WorkoutInteractor());



services.registerSingleton<AuthService>(AuthService());
}

Future<void> registerTypesToIoCAfterRunApp({required Locale locale}) async {
  // final services = GetIt.instance;

  // final ApiConfig apiConfig = services.get<ApiConfig>();
  // final HttpService httpService = services.get<HttpService>();

}

void registerBlocsAfterRunApp() {
  final services = GetIt.instance;
  services.registerSingleton<ProfileBloc>(ProfileBloc());
}

Future<void> registerBlocsBeforeRunApp() async {}


