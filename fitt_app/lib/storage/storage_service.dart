import 'dart:io';
import 'package:fitt_app/storage/hive_registrar.g.dart';
import 'package:hive_ce/hive.dart';

class StorageService {
  Future<void> initialize() async {
    // Use the app's temporary directory which is available without extra packages
    final directory = Directory.systemTemp.createTempSync('hive_data');

    // Initialize Hive with the temporary directory path
    Hive
      ..init(directory.path)
      ..registerAdapters();
  }
}