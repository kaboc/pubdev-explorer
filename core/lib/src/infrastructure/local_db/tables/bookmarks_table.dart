import 'package:drift/drift.dart';

class BookmarksTable extends Table {
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {name};
}
