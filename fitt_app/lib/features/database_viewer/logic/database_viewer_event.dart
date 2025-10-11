part of 'database_viewer_bloc.dart';

sealed class DatabaseViewerEvent {}

class CreateMockExercisesEvent extends DatabaseViewerEvent {

  CreateMockExercisesEvent();
}

class InitializeEvent extends DatabaseViewerEvent {
  InitializeEvent();
}

class LoadExercisesEvent extends DatabaseViewerEvent {
  LoadExercisesEvent();
}

class LoadMusclesEvent extends DatabaseViewerEvent {
  LoadMusclesEvent();
}
class LoadEquipmentsEvent extends DatabaseViewerEvent {
  LoadEquipmentsEvent();
}
class LoadWorkoutPlansEvent extends DatabaseViewerEvent {
  LoadWorkoutPlansEvent();
}
class LoadWorkoutsEvent extends DatabaseViewerEvent {
  LoadWorkoutsEvent();
}
