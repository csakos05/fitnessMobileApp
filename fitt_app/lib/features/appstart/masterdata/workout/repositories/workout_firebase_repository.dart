// lib/features/workout_planner/repositories/workout_firebase_repository.dart

import 'package:fitt_app/features/workout_planner/models/workout_model.dart';
import 'package:fitt_app/infrastructure/firestore/base_firestore_repository.dart';
import 'package:fitt_app/infrastructure/firestore/firestore_collections.dart';

class WorkoutFirebaseRepository extends BaseFirestoreRepository<Workout> {
  WorkoutFirebaseRepository()
      : super(
          FirestoreCollections.workouts,
          Workout.fromJson,
          (workout) => workout.toJson(),
        );

  Future<void> createWorkout(Workout workout) async {
    await create(workout.id, workout);
  }

  Future<Workout?> getWorkout(String id) async {
    return await read(id);
  }

  Future<List<Workout>> getAllWorkouts() async {
    return await readAll();
  }
}