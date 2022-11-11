import 'package:drift/drift.dart';

import 'package:pubdev_explorer_domain/src/domain/settings/_settings.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/database.dart';

extension SettingsToCompanion on Settings {
  SettingsTableCompanion get asCompanion {
    return SettingsTableCompanion.insert(
      id: const Value(1),
      themeModeIndex: Value(themeModeIndex),
    );
  }
}

extension DataToSettings on SettingsTableData {
  Settings get asSettings {
    return Settings(
      themeModeIndex: themeModeIndex,
    );
  }
}
