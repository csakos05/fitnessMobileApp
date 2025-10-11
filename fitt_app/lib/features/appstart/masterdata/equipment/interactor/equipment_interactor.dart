import 'package:fitt_app/features/appstart/masterdata/equipment/repositories/equipment_firebase_repository.dart';
import 'package:fitt_app/features/appstart/masterdata/equipment/repositories/equipment_hive_repository.dart';
import 'package:fitt_app/features/appstart/masterdata/models/workout_model.dart';

class EquipmentInteractor {
  final EquipmentFirebaseRepository remoteRepository =
      EquipmentFirebaseRepository();
  final EquipmentHiveRepository localRepository = EquipmentHiveRepository();

  Future<List<Equipment>> getAllEquipments() async {
    final localEquipments = await localRepository.getAllEquipments();
    if (localEquipments.isNotEmpty) {
      return localEquipments;
    }
    final remoteEquipments = await remoteRepository.getAllEquipments();
    await localRepository.saveAllEquipments(remoteEquipments);
    return remoteEquipments;
  }

  Future<Equipment?> getEquipmentById(String id) async {
    var equipment = await localRepository.getEquipmentById(id);
    if (equipment != null) {
      return equipment;
    }
   equipment = await remoteRepository.getEquipment(id);
    if (equipment != null) {
      await localRepository.saveEquipment(equipment);
    }
    return equipment;
  }

  Future<void> createEquipment(Equipment equipment) async {
    await remoteRepository.createEquipment(equipment);
  }
}