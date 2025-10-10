import 'package:fitt_app/features/appstart/masterdata/exercise/repositories/exercise_firebase_repository.dart';
import 'package:fitt_app/features/appstart/masterdata/exercise/repositories/exercise_hive_repository.dart';
import 'package:fitt_app/features/workout_planner/models/workout_model.dart';

class ExerciseInteractor {
  final ExerciseFirebaseRepository _remoteRepository =
      ExerciseFirebaseRepository();
  final ExerciseHiveRepository _localRepository = ExerciseHiveRepository();

  /// Fetches all exercises.
  ///
  /// It first attempts to retrieve exercises from the local cache. If the cache is
  /// empty, it fetches them from the remote repository, saves them to the cache,
  /// and then returns the list.
  Future<List<Exercise>> getAllExercises() async {
    final localExercises = await _localRepository.getAllExercises();
    if (localExercises.isNotEmpty) {
      return localExercises;
    }
    final remoteExercises = await _remoteRepository.getAllExercises();
    if (remoteExercises.isNotEmpty) {
      await _localRepository.saveAllExercises(remoteExercises);
    }
    return remoteExercises;
  }

  /// Fetches a single exercise by its ID.
  ///
  /// It first checks the local cache. If the exercise is not found, it fetches
  /// it from the remote repository, caches it locally, and then returns it.
  Future<Exercise?> getExerciseById(String id) async {
    var exercise = await _localRepository.getExerciseById(id);
    if (exercise != null) {
      return exercise;
    }
    exercise = await _remoteRepository.getExercise(id);
    if (exercise != null) {
      await _localRepository.saveExercise(exercise);
    }
    return exercise;
  }

  /// Creates a new exercise in the remote repository and caches it locally.
  Future<void> createExercise(Exercise exercise) async {
    await _remoteRepository.createExercise(exercise);
    await _localRepository.saveExercise(exercise);
  }

  /// Deletes an exercise from both the remote repository and the local cache.
  Future<void> deleteExercise(String id) async {
    await _remoteRepository.delete(id);
    await _localRepository.deleteExerciseById(id);
  }
}