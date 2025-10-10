// lib/features/workout_planner/repositories/workout_hive_repository.dart

import 'package:fitt_app/features/workout_planner/models/workout_model.dart';
import 'package:fitt_app/storage/abstract_hive_repository.dart';
import 'package:fitt_app/storage/hive_boxes.dart';

class WorkoutHiveRepository extends HiveRepository<Workout> {
  WorkoutHiveRepository() : super(hiveBoxName: HiveBoxNames.workoutsBox);

  Future<Workout?> getWorkoutById(String id) async {
    return await getValue(id);
  }

  Future<void> saveWorkout(Workout workout) async {
    await putValue(workout.id, workout);
  }

  Future<void> saveAllWorkouts(List<Workout> workouts) async {
    await addAll(workouts);
  }

  Future<List<Workout>> getAllWorkouts() async {
    return await getAllValues();
  }

  Future<void> deleteWorkoutById(String id) async {
    await deleteValue(id);
  }

  Future<void> deleteAllWorkouts() async {
    await clearAll();
  }
}