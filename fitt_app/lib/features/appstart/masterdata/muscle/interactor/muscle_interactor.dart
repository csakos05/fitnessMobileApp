import 'package:fitt_app/features/appstart/masterdata/muscle/repositories/muscle_firebase_repository.dart';
import 'package:fitt_app/features/appstart/masterdata/muscle/repositories/muscle_hive_repository.dart';

import '../../models/workout_model.dart';

class MuscleInteractor {
  final MuscleFirebaseRepository remoteRepository = MuscleFirebaseRepository();
  final MuscleHiveRepository localRepository = MuscleHiveRepository();

  Future<List<Muscle>> getAllMuscles() async {
    final localMuscles = await localRepository.getAllMuscles();
    if (localMuscles.isNotEmpty) {
      return localMuscles;
    }
    final remoteMuscles = await remoteRepository.getAllMuscles();
    await localRepository.saveAllMuscles(remoteMuscles);
    return remoteMuscles;
  }
  Future<Muscle?> getMuscleById(String id) async {
    // Először a gyorsítótárban keresünk
    var muscle = await localRepository.getMuscleById(id);
    if (muscle != null) {
      return muscle;
    }
    // Ha ott nincs meg, akkor a távoli forrásból kérjük le
    muscle = await remoteRepository.getMuscle(id);
    if (muscle != null) {
      // És elmentjük a gyorsítótárba a későbbi gyorsabb elérésért
      await localRepository.saveMuscle(muscle);
    }
    return muscle;
  }

  Future<void> createMuscle(Muscle muscle) async {
    await remoteRepository.createMuscle(muscle);
  }
}