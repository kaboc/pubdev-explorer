import 'dart:io';

import 'package:drift/drift.dart' show LazyDatabase;
import 'package:drift/native.dart' show NativeDatabase;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:pubdev_explorer/common/constants.dart';

LazyDatabase openConnection({bool inMemory = false}) {
  return LazyDatabase(() async {
    if (inMemory) {
      return NativeDatabase.memory();
    }

    // Another way is to use getDatabasesPath() of sqflite.
    // On Android, it is probably better as it returns the
    // default database path.
    final dirPath = await _getAppSupportDirPath();
    final file = File(path.join(dirPath, kDatabaseName));

    // App Inspection on Android Studio/IntelliJ Idea does
    // not support database opened with NativeDatabase.
    // https://github.com/simolus3/drift/discussions/1818
    return NativeDatabase(file);
  });
}

Future<String> _getAppSupportDirPath() async {
  final dir = await getApplicationSupportDirectory();
  return dir.path;
}
