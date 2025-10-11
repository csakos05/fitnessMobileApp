import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import 'package:fitt_app/infrastructure/firestore/firestore_collections.dart';

import '../../../../../infrastructure/firestore/base_firestore_repository.dart';


class MuscleFirebaseRepository extends BaseFirestoreRepository<Muscle> {
  MuscleFirebaseRepository()
      : super(
    FirestoreCollections.muscles, // The name of the Firestore collection
    Muscle.fromJson,
        (muscle) => muscle.toJson(),
  );

  Future<void> createMuscle(Muscle muscle) async {
    await create(muscle.id, muscle);
  }

  Future<Muscle?> getMuscle(String id) async {
    return await read(id);
  }

  Future<List<Muscle>> getAllMuscles() async {
    return await readAll();
  }
}