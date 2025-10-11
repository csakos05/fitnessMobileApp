// lib/features/workout_planner/repositories/workout_plan_hive_repository.dart

import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import 'package:fitt_app/storage/abstract_hive_repository.dart';
import 'package:fitt_app/storage/hive_boxes.dart';

class WorkoutPlanHiveRepository extends HiveRepository<WorkoutPlan> {
  WorkoutPlanHiveRepository() : super(hiveBoxName: HiveBoxNames.workoutPlansBox);

  Future<WorkoutPlan?> getWorkoutPlanById(String id) async {
    return await getValue(id);
  }

  Future<void> saveWorkoutPlan(WorkoutPlan plan) async {
    await putValue(plan.id, plan);
  }

  Future<void> saveAllWorkoutPlans(List<WorkoutPlan> plans) async {
    await addAll(plans);
  }

  Future<List<WorkoutPlan>> getAllWorkoutPlans() async {
    return await getAllValues();
  }

  Future<void> deleteWorkoutPlanById(String id) async {
    await deleteValue(id);
  }

  Future<void> deleteAllWorkoutPlans() async {
    await clearAll();
  }
}