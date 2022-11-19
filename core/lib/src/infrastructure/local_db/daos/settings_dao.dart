import 'package:drift/drift.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/settings/_settings.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/converters/settings.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/tables/settings_table.dart';

part '../../../generated/infrastructure/local_db/daos/settings_dao.g.dart';

@DriftAccessor(tables: [SettingsTable])
class SettingsDao extends DatabaseAccessor<Database> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  $SettingsTableTable get _table => db.settingsTable;

  Future<Settings> fetchSettings() async {
    final stmt = select(_table)..where((t) => t.id.equals(1));
    final settings = await stmt.getSingleOrNull();
    return settings?.asSettings ?? const Settings();
  }

  Future<void> addOrUpdateSettings({required Settings settings}) async {
    await into(_table).insertOnConflictUpdate(settings.asCompanion);
  }
}
