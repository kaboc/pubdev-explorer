import 'package:drift/drift.dart' show LazyDatabase;
import 'package:drift/web.dart' show WebDatabase;

LazyDatabase openConnection({bool inMemory = false}) {
  return LazyDatabase(() => WebDatabase('app'));
}
