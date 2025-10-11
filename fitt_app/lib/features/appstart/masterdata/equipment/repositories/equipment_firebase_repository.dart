import 'package:fitt_app/infrastructure/firestore/base_firestore_repository.dart';
import 'package:fitt_app/infrastructure/firestore/firestore_collections.dart';

import '../../models/workout_model.dart';

class EquipmentFirebaseRepository extends BaseFirestoreRepository<Equipment> {
  EquipmentFirebaseRepository()
      : super(
          FirestoreCollections.equipments,
          Equipment.fromJson,
          (equipment) => equipment.toJson(),
        );

  Future<void> createEquipment(Equipment equipment) async {
    await create(equipment.id, equipment);
  }

  Future<Equipment?> getEquipment(String id) async {
    return await read(id);
  }

  Future<List<Equipment>> getAllEquipments() async {
    return await readAll();
  }
}