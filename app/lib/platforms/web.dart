import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase openConnection({bool inMemory = false}) {
  return LazyDatabase(() => WebDatabase('app'));
}
