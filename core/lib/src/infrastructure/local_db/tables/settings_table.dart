import 'package:drift/drift.dart';

class SettingsTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();

  IntColumn get themeModeIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
