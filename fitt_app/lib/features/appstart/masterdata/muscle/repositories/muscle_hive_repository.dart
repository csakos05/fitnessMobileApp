import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import 'package:fitt_app/storage/hive_boxes.dart';

import '../../../../../storage/abstract_hive_repository.dart';

class MuscleHiveRepository extends HiveRepository<Muscle> {
  MuscleHiveRepository() : super(hiveBoxName: HiveBoxNames.musclesBox);

  Future<Muscle?> getMuscleById(String id) async {
    return await getValue(id);
  }

  Future<void> saveMuscle(Muscle muscle) async {
    await putValue(muscle.id, muscle);
  }

  Future<void> saveAllMuscles(List<Muscle> muscles) async {
    await addAll(muscles);
  }

  Future<void> deleteMuscleById(String id) async {
    await deleteValue(id);
  }

  Future<List<Muscle>> getAllMuscles() async {
    return await getAllValues();
  }

  Future<void> deleteAllMuscles() async {
    await clearAll();
  }
}
