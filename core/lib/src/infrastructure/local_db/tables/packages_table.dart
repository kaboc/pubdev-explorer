import 'package:drift/drift.dart';

class PackagesTable extends Table {
  TextColumn get name => text()();

  TextColumn get description => text()();

  TextColumn get latest => text()();

  DateTimeColumn get latestAt => dateTime().nullable()();

  TextColumn get preRelease => text().nullable()();

  DateTimeColumn get preReleaseAt => dateTime().nullable()();

  TextColumn get sdks => text()();

  TextColumn get platforms => text()();

  TextColumn get publisher => text()();

  IntColumn get points => integer()();

  IntColumn get maxPoints => integer()();

  IntColumn get likes => integer()();

  RealColumn get popularity => real()();

  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {name};
}
