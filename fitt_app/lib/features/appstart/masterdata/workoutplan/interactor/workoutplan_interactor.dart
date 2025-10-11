// lib/features/workout_planner/interactor/workout_plan_interactor.dart

import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';

import '../repositories/workoutplan_firebase_repository.dart';
import '../repositories/workoutplan_hive_repository.dart';

class WorkoutPlanInteractor {
  final WorkoutPlanFirebaseRepository _remoteRepository = WorkoutPlanFirebaseRepository();
  final WorkoutPlanHiveRepository _localRepository = WorkoutPlanHiveRepository();

  /// Fetches all workout plans.
  ///
  /// It first attempts to retrieve plans from the local cache. If the cache is
  /// empty, it fetches them from the remote repository, saves them to the cache,
  /// and then returns the list.
  Future<List<WorkoutPlan>> getAllWorkoutPlans() async {
    final localPlans = await _localRepository.getAllWorkoutPlans();
    if (localPlans.isNotEmpty) {
      return localPlans;
    }
    final remotePlans = await _remoteRepository.getAllWorkoutPlans();
    if (remotePlans.isNotEmpty) {
      await _localRepository.saveAllWorkoutPlans(remotePlans);
    }
    return remotePlans;
  }

  /// Fetches a single workout plan by its ID.
  ///
  /// It first checks the local cache. If the plan is not found, it fetches
  /// it from the remote repository, caches it locally, and then returns it.
  Future<WorkoutPlan?> getWorkoutPlanById(String id) async {
    var plan = await _localRepository.getWorkoutPlanById(id);
    if (plan != null) {
      return plan;
    }
    plan = await _remoteRepository.getWorkoutPlan(id);
    if (plan != null) {
      await _localRepository.saveWorkoutPlan(plan);
    }
    return plan;
  }

  /// Creates a new workout plan in the remote repository and caches it locally.
  Future<void> createWorkoutPlan(WorkoutPlan plan) async {
    await _remoteRepository.createWorkoutPlan(plan);
    await _localRepository.saveWorkoutPlan(plan);
  }

  /// Deletes a workout plan from both the remote repository and the local cache.
  Future<void> deleteWorkoutPlan(String id) async {
    await _remoteRepository.delete(id);
    await _localRepository.deleteWorkoutPlanById(id);
  }
}
