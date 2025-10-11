import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import 'package:fitt_app/infrastructure/firestore/base_firestore_repository.dart';
import 'package:fitt_app/infrastructure/firestore/firestore_collections.dart';

class ExerciseFirebaseRepository extends BaseFirestoreRepository<Exercise> {
  ExerciseFirebaseRepository()
      : super(
    FirestoreCollections.exercises, // The name of the Firestore collection
    Exercise.fromJson,
        (muscle) => muscle.toJson(),
  );

  Future<void> createExercise(Exercise exercise) async {
    await create(exercise.id, exercise);
  }

  Future<Exercise?> getExercise(String id) async {
    return await read(id);
  }

  Future<List<Exercise>> getAllExercises() async {
    return await readAll();
  }
}