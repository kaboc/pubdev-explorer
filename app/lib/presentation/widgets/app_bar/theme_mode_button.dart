import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

SettingsNotifier get _notifier => settingsNotifierPot();

class ThemeModeButton extends StatelessWidget with Grab {
  const ThemeModeButton();

  @override
  Widget build(BuildContext context) {
    final currentMode = _notifier.grabAt(context, (s) => s.themeMode);

    return PopupMenuButton<ThemeMode>(
      tooltip: 'Theme mode',
      icon: Icon(
        currentMode.icon,
        color: currentMode.color,
      ),
      splashRadius: 28.0,
      onSelected: _notifier.updateThemeMode,
      itemBuilder: (context) => [
        for (final mode in ThemeMode.values)
          PopupMenuItem<ThemeMode>(
            value: mode,
            textStyle: context.bodyMedium.copyWith(
              fontWeight: mode == currentMode ? FontWeight.bold : null,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 18.0,
                  child: mode == currentMode
                      ? Icon(
                          Icons.check,
                          size: 18.0,
                          color: context.bodyMedium.color,
                        )
                      : null,
                ),
                const SizedBox(width: 10.0),
                Text(mode.label),
              ],
            ),
          ),
      ],
    );
  }
}

extension on ThemeMode {
  String get label {
    return switch (this) {
      ThemeMode.system => 'System default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }

  IconData get icon {
    return switch (this) {
      ThemeMode.system => Icons.dark_mode,
      ThemeMode.light => Icons.light_mode,
      ThemeMode.dark => Icons.dark_mode,
    };
  }

  Color? get color {
    return switch (this) {
      ThemeMode.system => null,
      ThemeMode.light => Colors.yellow,
      ThemeMode.dark => Colors.amber,
    };
  }
}
