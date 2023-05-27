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
    switch (this) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  IconData get icon {
    switch (this) {
      case ThemeMode.system:
        return Icons.dark_mode;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

  Color? get color {
    switch (this) {
      case ThemeMode.system:
        return null;
      case ThemeMode.light:
        return Colors.yellow;
      case ThemeMode.dark:
        return Colors.amber;
    }
  }
}
