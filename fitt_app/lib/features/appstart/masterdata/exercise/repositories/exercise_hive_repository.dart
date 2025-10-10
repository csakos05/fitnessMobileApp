import 'package:fitt_app/features/workout_planner/models/workout_model.dart';
import 'package:fitt_app/storage/hive_boxes.dart';

import '../../../../../storage/abstract_hive_repository.dart';

class ExerciseHiveRepository extends HiveRepository<Exercise> {
  ExerciseHiveRepository() : super(hiveBoxName: HiveBoxNames.exercisesBox);

  Future<Exercise?> getExerciseById(String id) async {
    return await getValue(id);
  }

  Future<void> saveExercise(Exercise exercise) async {
    await putValue(exercise.id, exercise);
  }

  Future<void> saveAllExercises(List<Exercise> exercises) async {
    await addAll(exercises);
  }

  Future<void> deleteExerciseById(String id) async {
    await deleteValue(id);
  }

  Future<List<Exercise>> getAllExercises() async {
    return await getAllValues();
  }

  Future<void> deleteAllExercises() async {
    await clearAll();
  }
}