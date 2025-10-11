import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';
import 'package:fitt_app/storage/abstract_hive_repository.dart';
import 'package:fitt_app/storage/hive_boxes.dart';

class EquipmentHiveRepository extends HiveRepository<Equipment> {
  EquipmentHiveRepository() : super(hiveBoxName: HiveBoxNames.equipmentsBox);

  Future<Equipment?> getEquipmentById(String id) async {
    return await getValue(id);
  }

  Future<void> saveEquipment(Equipment equipment) async {
    await putValue(equipment.id, equipment);
  }

  Future<void> saveAllEquipments(List<Equipment> equipments) async {
    await addAll(equipments);
  }

  Future<void> deleteEquipmentById(String id) async {
    await deleteValue(id);
  }

  Future<List<Equipment>> getAllEquipments() async {
    return await getAllValues();
  }

  Future<void> deleteAllEquipments() async {
    await clearAll();
  }
}