// lib/features/workout_planner/repositories/workout_plan_firebase_repository.dart

import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import 'package:fitt_app/infrastructure/firestore/base_firestore_repository.dart';
import 'package:fitt_app/infrastructure/firestore/firestore_collections.dart';

class WorkoutPlanFirebaseRepository extends BaseFirestoreRepository<WorkoutPlan> {
  WorkoutPlanFirebaseRepository()
      : super(
          FirestoreCollections.workoutPlans,
          WorkoutPlan.fromJson,
          (plan) => plan.toJson(),
        );

  Future<void> createWorkoutPlan(WorkoutPlan plan) async {
    await create(plan.id, plan);
  }

  Future<WorkoutPlan?> getWorkoutPlan(String id) async {
    return await read(id);
  }

  Future<List<WorkoutPlan>> getAllWorkoutPlans() async {
    return await readAll();
  }
}