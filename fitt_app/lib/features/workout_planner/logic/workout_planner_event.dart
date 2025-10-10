part of 'workout_planner_bloc.dart';

sealed class WorkoutPlannerEvent {}

class CreateMockExercisesEvent extends WorkoutPlannerEvent {

  CreateMockExercisesEvent();
}

class InitializeEvent extends WorkoutPlannerEvent {
  InitializeEvent();
}

class LoadExercisesEvent extends WorkoutPlannerEvent {
  LoadExercisesEvent();
}

class LoadMusclesEvent extends WorkoutPlannerEvent {
  LoadMusclesEvent();
}
class LoadEquipmentsEvent extends WorkoutPlannerEvent {
  LoadEquipmentsEvent();
}
class LoadWorkoutPlansEvent extends WorkoutPlannerEvent {
  LoadWorkoutPlansEvent();
}
class LoadWorkoutsEvent extends WorkoutPlannerEvent {
  LoadWorkoutsEvent();
}
