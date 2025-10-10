part of 'workout_planner_bloc.dart';

sealed class WorkoutPlannerState {}

final class WorkoutPlannerInitial extends WorkoutPlannerState {}

final class WorkoutPlannerLoading extends WorkoutPlannerState {}

final class WorkoutPlannerLoaded extends WorkoutPlannerState {

  WorkoutPlannerLoaded();
}

final class WorkoutPlannerError extends WorkoutPlannerState {
  final String message;

  WorkoutPlannerError({required this.message});
}

final class WorkoutPlannerNoData extends WorkoutPlannerState {}

final class WorkoutPlannerCreatingMockData extends WorkoutPlannerState {}

final class WorkoutPlannerMockDataCreated extends WorkoutPlannerState {}

final class MusclesLoaded extends WorkoutPlannerState {
  final List<Muscle> muscles;

  MusclesLoaded({required this.muscles});
}

final class EquipmentsLoaded extends WorkoutPlannerState {
  final List<Equipment> equipments;

  EquipmentsLoaded({required this.equipments});
}

final class ExercisesLoaded extends WorkoutPlannerState {
  final List<Exercise> exercises;

  ExercisesLoaded({required this.exercises});
}

final class WorkoutPlansLoaded extends WorkoutPlannerState {
  final List<WorkoutPlan> workoutPlans;

  WorkoutPlansLoaded({required this.workoutPlans});
}

final class WorkoutsLoaded extends WorkoutPlannerState {
  final List<Workout> workouts;

  WorkoutsLoaded({required this.workouts});
}

