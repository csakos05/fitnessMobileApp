import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import '../repositories/workout_firebase_repository.dart';
import '../repositories/workout_hive_repository.dart';

class WorkoutInteractor {
  final WorkoutFirebaseRepository _remoteRepository = WorkoutFirebaseRepository();
  final WorkoutHiveRepository _localRepository = WorkoutHiveRepository();

  /// Fetches all workouts.
  ///
  /// It first attempts to retrieve workouts from the local cache. If the cache is
  /// empty, it fetches them from the remote repository, saves them to the cache,
  /// and then returns the list.
  Future<List<Workout>> getAllWorkouts() async {
    final localWorkouts = await _localRepository.getAllWorkouts();
    if (localWorkouts.isNotEmpty) {
      return localWorkouts;
    }
    final remoteWorkouts = await _remoteRepository.getAllWorkouts();
    if (remoteWorkouts.isNotEmpty) {
      await _localRepository.saveAllWorkouts(remoteWorkouts);
    }
    return remoteWorkouts;
  }

  /// Fetches a single workout by its ID.
  ///
  /// It first checks the local cache. If the workout is not found, it fetches
  /// it from the remote repository, caches it locally, and then returns it.
  Future<Workout?> getWorkoutById(String id) async {
    var workout = await _localRepository.getWorkoutById(id);
    if (workout != null) {
      return workout;
    }
    workout = await _remoteRepository.getWorkout(id);
    if (workout != null) {
      await _localRepository.saveWorkout(workout);
    }
    return workout;
  }

  /// Creates a new workout in the remote repository and caches it locally.
  Future<void> createWorkout(Workout workout) async {
    await _remoteRepository.createWorkout(workout);
    // await _localRepository.saveWorkout(workout);
  }

  /// Deletes a workout from both the remote repository and the local cache.
  Future<void> deleteWorkout(String id) async {
    await _remoteRepository.delete(id);
    await _localRepository.deleteWorkoutById(id);
  }
}