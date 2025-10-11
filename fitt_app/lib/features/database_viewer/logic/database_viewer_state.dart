part of 'database_viewer_bloc.dart';

sealed class DatabaseViewerState {}

final class Initial extends DatabaseViewerState {}

final class Loading extends DatabaseViewerState {}

final class Loaded extends DatabaseViewerState {

  Loaded();
}

final class Error extends DatabaseViewerState {
  final String message;

  Error({required this.message});
}

final class NoData extends DatabaseViewerState {}

final class CreatingMockData extends DatabaseViewerState {}

final class MockDataCreated extends DatabaseViewerState {}

final class MusclesLoaded extends DatabaseViewerState {
  final List<Muscle> muscles;

  MusclesLoaded({required this.muscles});
}

final class EquipmentsLoaded extends DatabaseViewerState {
  final List<Equipment> equipments;

  EquipmentsLoaded({required this.equipments});
}

final class ExercisesLoaded extends DatabaseViewerState {
  final List<Exercise> exercises;

  ExercisesLoaded({required this.exercises});
}

final class WorkoutPlansLoaded extends DatabaseViewerState {
  final List<WorkoutPlan> workoutPlans;

  WorkoutPlansLoaded({required this.workoutPlans});
}

final class WorkoutsLoaded extends DatabaseViewerState {
  final List<Workout> workouts;

  WorkoutsLoaded({required this.workouts});
}

