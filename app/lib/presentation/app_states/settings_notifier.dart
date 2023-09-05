import 'dart:async';
import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';

SettingsRepository get _repository => settingsRepositoryPot();

class SettingsNotifier extends ValueNotifier<Settings> {
  SettingsNotifier() : super(const Settings()) {
    _fetch();
  }

  final Completer<void> _completer = Completer();

  Future<void> ensureReady() async {
    return _completer.future;
  }

  Future<void> _fetch() async {
    value = await _repository.fetch();
    _completer.complete();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    value = await _repository.update(
      settings: value.copyWith(themeModeIndex: mode.index),
    );
  }
}

extension IndexToThemeMode on Settings {
  ThemeMode get themeMode {
    return ThemeMode.values.elementAtOrNull(themeModeIndex) ?? ThemeMode.system;
  }
}
