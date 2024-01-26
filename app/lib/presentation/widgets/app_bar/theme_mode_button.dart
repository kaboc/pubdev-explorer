import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

SettingsNotifier get _notifier => settingsNotifierPot();

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton();

  @override
  Widget build(BuildContext context) {
    final currentMode = _notifier.grabAt(context, (s) => s.themeMode);

    return MenuAnchor(
      // ignore: sort_child_properties_last
      child: Icon(
        currentMode.icon,
        color: currentMode.color,
      ),
      builder: (context, controller, child) {
        return IconButton(
          onPressed: controller.isOpen ? controller.close : controller.open,
          tooltip: 'Theme mode',
          icon: child!,
        );
      },
      menuChildren: [
        for (final mode in ThemeMode.values)
          MenuItemButton(
            onPressed: () => _notifier.updateThemeMode(mode),
            leadingIcon: SizedBox(
              width: 18.0,
              child: mode == currentMode
                  ? Icon(
                      Icons.check,
                      size: 18.0,
                      color: context.bodyMedium.color,
                    )
                  : null,
            ),
            trailingIcon: const SizedBox(width: 16.0),
            child: Text(
              mode.label,
              style: context.bodyMedium.copyWith(
                fontWeight: mode == currentMode ? FontWeight.bold : null,
              ),
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
