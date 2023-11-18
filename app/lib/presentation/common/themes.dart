// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xFF132030);
const Color _secondaryColor = Color(0xFF0175C2);
const Color _secondaryColorDark = Color(0xFF55CCFF);
const Color _tertiaryColor = Color(0xFF757575);
const Color _tertiaryColorDark = Color(0xFF858585);

class AppTheme {
  static ThemeData get light {
    final data = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiaryColor,
        background: const Color(0xFFEEEEEE),
        surfaceTint: Colors.transparent,
      ),
    ).custom;

    return data.copyWith(
      appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFFE0E0E0),
        backgroundColor: _primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFE0E0E0),
          backgroundColor: _tertiaryColor,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final data = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        secondary: _secondaryColorDark,
        tertiary: _tertiaryColorDark,
        onSurface: const Color(0xFFE0E0E0),
        background: const Color(0xFF212121),
        surface: const Color(0xFF303030),
        onSurfaceVariant: _tertiaryColorDark,
      ),
    ).custom;

    return data.copyWith(
      appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFFE0E0E0),
        backgroundColor: Color(0xFF212121),
      ),
      inputDecorationTheme: data.inputDecorationTheme.copyWith(
        hintStyle: const TextStyle(color: _tertiaryColorDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _tertiaryColor,
        ),
      ),
    );
  }
}

extension on ThemeData {
  ThemeData get custom {
    return copyWith(
      textTheme: textTheme.copyWith(
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontSize: 20.0,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          fontSize: 10.0,
        ),
      ),
      textSelectionTheme: textSelectionTheme.copyWith(
        cursorColor: _secondaryColor,
        selectionColor: _secondaryColor.withOpacity(0.4),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: cardColor,
      ),
      bannerTheme: bannerTheme.copyWith(
        backgroundColor: Colors.blueGrey,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Color get primaryColor => theme.colorScheme.primary;
  Color get secondaryColor => theme.colorScheme.secondary;
  Color get tertiaryColor => theme.colorScheme.tertiary;

  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;
  TextStyle get bodySmall => theme.textTheme.bodySmall!;
}
