import 'package:drift/drift.dart' show DatabaseConnection, LazyDatabase;
import 'package:drift/wasm.dart' show WasmDatabase;

import 'package:pubdev_explorer/common/constants.dart';

LazyDatabase openConnection({bool inMemory = false}) {
  return LazyDatabase(
    () => DatabaseConnection.delayed(
      WasmDatabase.open(
        databaseName: kDatabaseName,
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.dart.js'),
      ).then((result) => result.resolvedExecutor),
    ),
  );
}
