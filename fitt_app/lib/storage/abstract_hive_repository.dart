import 'package:hive_ce/hive.dart';

//generate hiveadapter with command:
// dart run build_runner build --delete-conflicting-outputs

abstract class HiveRepository<T> {
  final String hiveBoxName;

  HiveRepository({required this.hiveBoxName});

  Future<bool> openBox() async {
    if (!Hive.isBoxOpen(hiveBoxName)) {
      await Hive.openBox(hiveBoxName);
      return true;
    }
    return Hive.isBoxOpen(hiveBoxName);
  }

  Future<Box> getBox() async {
    if (await openBox()) {
      return Hive.box(hiveBoxName);
    } else {
      throw Exception('Box $hiveBoxName is not open. Call openBox() first.');
    }
  }

  Future<T?> getValue(dynamic key) async {
    final box = await getBox();
    return box.get(key) as T?;
  }

  Future<void> putValue(dynamic key, T value) async {
    final box = await getBox();
    await box.put(key, value);
  }

  Future<void> putAll(Map<dynamic, T> entries) async {
    final box = await getBox();
    await box.putAll(entries);
  }

  Future<void> addAll (List<T> list) async {
    final box = await getBox();
    await box.addAll(list);
  }

  Future<List<T>> getAllValues() async {
    final box = await getBox();
    return box.values.cast<T>().toList();
  }

  Future<void> deleteValue(dynamic key) async {
    final box = await getBox();
    await box.delete(key);
  }

  Future<void> clearAll() async {
    final box = await getBox();
    await box.clear();
  }
}