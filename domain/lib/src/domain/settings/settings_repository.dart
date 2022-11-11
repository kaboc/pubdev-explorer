import 'package:pubdev_explorer_domain/src/common/_common.dart';
import 'package:pubdev_explorer_domain/src/domain/settings/models/settings.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/daos/settings_dao.dart';

class SettingsRepository {
  SettingsDao get _dao => localDatabasePot().settingsDao;

  Future<Settings> fetch() async {
    return _dao.fetchSettings();
  }

  Future<Settings> update({required Settings settings}) async {
    await _dao.addOrUpdateSettings(settings: settings);
    return settings;
  }
}
