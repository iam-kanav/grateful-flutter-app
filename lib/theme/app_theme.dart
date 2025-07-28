import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart'; // This file is correct and doesn't need changes

class AppTheme {

  static TextTheme get _baseTextTheme {
    return TextTheme(
      displayLarge: TextStyle(fontFamily: 'Lora', fontSize: 57, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontFamily: 'Lora', fontSize: 45, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontFamily: 'Lora', fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontFamily: 'Lora', fontSize: 32, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(fontFamily: 'Lora', fontSize: 28, fontWeight: FontWeight.w400),
      headlineSmall: TextStyle(fontFamily: 'Lora', fontSize: 24, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontFamily: 'Inter', fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w500),
    );
  }


  static ThemeData get lightTheme {

    final ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: kLightPrimary,
      onPrimary: kLightOnPrimary,
      primaryContainer: kLightPrimaryContainer,

      onPrimaryContainer: kLightOnBackground,
      secondary: kLightSecondary,
      onSecondary: kLightOnSecondary,
      secondaryContainer: kLightSecondaryContainer,
      onSecondaryContainer: kLightOnBackground,
      error: kLightError,
      onError: kLightOnError,
      background: kLightBackground,
      onBackground: kLightOnBackground,
      surface: kLightSurface,
      onSurface: kLightOnSurface,
      outline: kLightOutline,
    );

    return ThemeData(
      useMaterial3: true, // Opt-in to Material 3 design
      colorScheme: lightColorScheme,
      textTheme: _baseTextTheme.apply(
        bodyColor: lightColorScheme.onSurface,
        displayColor: lightColorScheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        elevation: 0, // A flatter M3 style
        titleTextStyle: TextStyle(
          fontFamily: 'Lora',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: lightColorScheme.onSurface,
        ),
        iconTheme: IconThemeData(color: lightColorScheme.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightColorScheme.surface,
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.onSurface.withOpacity(0.6),
        elevation: 2.0,
        type: BottomNavigationBarType.fixed,
      ),

      cardTheme: CardThemeData(
        color: lightColorScheme.surface,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: lightColorScheme.outline.withOpacity(0.5)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: lightColorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),


    );
  }


  static ThemeData get darkTheme {

    final ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: kDarkPrimary,
      onPrimary: kDarkOnPrimary,
      primaryContainer: kDarkPrimaryContainer,
      onPrimaryContainer: kDarkOnBackground,
      secondary: kDarkSecondary,
      onSecondary: kDarkOnSecondary,
      secondaryContainer: kDarkSecondaryContainer,
      onSecondaryContainer: kDarkOnBackground,
      error: kDarkError,
      onError: kDarkOnError,
      background: kDarkBackground,
      onBackground: kDarkOnBackground,
      surface: kDarkSurface,
      onSurface: kDarkOnSurface,
      outline: kDarkOutline,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: _baseTextTheme.apply(
        bodyColor: darkColorScheme.onSurface,
        displayColor: darkColorScheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Lora',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onSurface,
        ),
        iconTheme: IconThemeData(color: darkColorScheme.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkColorScheme.surface,
        selectedItemColor: darkColorScheme.primary,
        unselectedItemColor: darkColorScheme.onSurface.withOpacity(0.6),
        elevation: 2.0,
        type: BottomNavigationBarType.fixed,
      ),

      cardTheme: CardThemeData(
        color: darkColorScheme.surface,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: darkColorScheme.outline.withOpacity(0.5)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: darkColorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}


class ThemeNotifier with ChangeNotifier {
  final String key = "theme";
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(key) ?? ThemeMode.system.index;
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, _themeMode.index);
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveToPrefs();
    notifyListeners();
  }
}