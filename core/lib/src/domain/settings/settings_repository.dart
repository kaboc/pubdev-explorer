import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/settings/models/settings.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/daos/settings_dao.dart';

class SettingsRepository {
  const SettingsRepository();

  SettingsDao get _dao => localDatabasePot().settingsDao;

  Future<Settings> fetch() async {
    try {
      return _dao.fetchSettings();
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<Settings> update({required Settings settings}) async {
    try {
      await _dao.addOrUpdateSettings(settings: settings);
      return settings;
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }
}
