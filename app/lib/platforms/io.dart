import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

LazyDatabase openConnection({bool inMemory = false}) {
  return LazyDatabase(() async {
    if (inMemory) {
      return NativeDatabase.memory();
    }

    final dirPath = await _getAppSupportDirPath();
    final file = File(path.join(dirPath, 'app.sqlite'));
    return NativeDatabase(file);
  });
}

Future<String> _getAppSupportDirPath() async {
  final dir = await getApplicationSupportDirectory();
  return dir.path;
}
