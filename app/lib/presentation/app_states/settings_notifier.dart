import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';

SettingsRepository get _repository => settingsRepositoryPot();

class SettingsNotifier extends ValueNotifier<Settings> {
  SettingsNotifier() : super(const Settings()) {
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      value = await _repository.fetch();
    } on Exception catch (e, s) {
      Logger.error(e, s);
    }
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    try {
      value = await _repository.update(
        settings: value.copyWith(themeModeIndex: mode.index),
      );
    } on Exception catch (e, s) {
      Logger.error(e, s);
    }
  }
}

extension IndexToThemeMode on Settings {
  ThemeMode get themeMode {
    return themeModeIndex < ThemeMode.values.length
        ? ThemeMode.values[themeModeIndex]
        : ThemeMode.system;
  }
}
