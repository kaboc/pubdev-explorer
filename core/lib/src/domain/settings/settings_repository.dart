import 'package:async_phase/async_phase.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/settings/models/settings.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/daos/settings_dao.dart';

class SettingsRepository {
  const SettingsRepository();

  SettingsDao get _dao => localDatabasePot().settingsDao;

  Future<AsyncPhase<Settings>> fetch() async {
    return AsyncPhase.from(
      () => _dao.fetchSettings(),
      onError: (_, e, s) => Logger.error(e, s),
    );
  }

  Future<AsyncPhase<Settings>> update({required Settings settings}) async {
    return AsyncPhase.from(
      () async {
        await _dao.addOrUpdateSettings(settings: settings);
        return settings;
      },
      onError: (_, e, s) => Logger.error(e, s),
    );
  }
}
