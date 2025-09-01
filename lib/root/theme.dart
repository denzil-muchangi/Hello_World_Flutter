import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Modern Light Theme
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black87,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: Colors.grey.shade50,
  ),
);

// Modern Dark Theme
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: Colors.grey.shade900,
  ),
);

// Custom Theme Data Class
class CustomThemeData {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color errorColor;
  final Brightness brightness;

  const CustomThemeData({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
    required this.backgroundColor,
    required this.errorColor,
    required this.brightness,
  });

  // Convert to ThemeData
  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: brightness == Brightness.light ? Colors.white : Colors.black,
        onSecondary: brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        onSurface: brightness == Brightness.light
            ? Colors.black87
            : Colors.white,
        onError: Colors.white,
        brightness: brightness,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: brightness == Brightness.light
            ? Colors.black87
            : Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: brightness == Brightness.light
            ? Colors.grey.shade50
            : Colors.grey.shade900,
      ),
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'primaryColor': primaryColor.toARGB32(),
      'secondaryColor': secondaryColor.toARGB32(),
      'surfaceColor': surfaceColor.toARGB32(),
      'backgroundColor': backgroundColor.toARGB32(),
      'errorColor': errorColor.toARGB32(),
      'brightness': brightness == Brightness.light ? 'light' : 'dark',
    };
  }

  // Create from JSON
  factory CustomThemeData.fromJson(Map<String, dynamic> json) {
    return CustomThemeData(
      name: json['name'],
      primaryColor: Color(json['primaryColor']),
      secondaryColor: Color(json['secondaryColor']),
      surfaceColor: Color(json['surfaceColor']),
      backgroundColor: Color(json['backgroundColor']),
      errorColor: Color(json['errorColor']),
      brightness: json['brightness'] == 'light'
          ? Brightness.light
          : Brightness.dark,
    );
  }
}

// Predefined custom themes
final List<CustomThemeData> predefinedCustomThemes = [
  const CustomThemeData(
    name: 'Ocean Blue',
    primaryColor: Color(0xFF006994),
    secondaryColor: Color(0xFF00B4D8),
    surfaceColor: Color(0xFF90E0EF),
    backgroundColor: Color(0xFFCAF0F8),
    errorColor: Color(0xFFDC2626),
    brightness: Brightness.light,
  ),
  const CustomThemeData(
    name: 'Forest Green',
    primaryColor: Color(0xFF2D5016),
    secondaryColor: Color(0xFF4CAF50),
    surfaceColor: Color(0xFF81C784),
    backgroundColor: Color(0xFFE8F5E8),
    errorColor: Color(0xFFDC2626),
    brightness: Brightness.light,
  ),
  const CustomThemeData(
    name: 'Sunset Orange',
    primaryColor: Color(0xFFE65100),
    secondaryColor: Color(0xFFFF9800),
    surfaceColor: Color(0xFFFFCC80),
    backgroundColor: Color(0xFFFFF3E0),
    errorColor: Color(0xFFDC2626),
    brightness: Brightness.light,
  ),
  const CustomThemeData(
    name: 'Purple Dream',
    primaryColor: Color(0xFF6A1B9A),
    secondaryColor: Color(0xFF9C27B0),
    surfaceColor: Color(0xFFBA68C8),
    backgroundColor: Color(0xFFF3E5F5),
    errorColor: Color(0xFFDC2626),
    brightness: Brightness.light,
  ),
  const CustomThemeData(
    name: 'Midnight Dark',
    primaryColor: Color(0xFF1A237E),
    secondaryColor: Color(0xFF3949AB),
    surfaceColor: Color(0xFF7986CB),
    backgroundColor: Color(0xFF303F9F),
    errorColor: Color(0xFFEF5350),
    brightness: Brightness.dark,
  ),
];

// Theme persistence utilities
class ThemeStorage {
  static const String _customThemesKey = 'custom_themes';
  static const String _currentThemeKey = 'current_theme';

  static Future<void> saveCustomThemes(List<CustomThemeData> themes) async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = themes.map((theme) => theme.toJson()).toList();
    await prefs.setString(_customThemesKey, jsonEncode(themesJson));
  }

  static Future<List<CustomThemeData>> loadCustomThemes() async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = prefs.getString(_customThemesKey);
    if (themesJson != null) {
      final themesList = jsonDecode(themesJson) as List;
      return themesList
          .map((theme) => CustomThemeData.fromJson(theme))
          .toList();
    }
    return [];
  }

  static Future<void> saveCurrentTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentThemeKey, themeName);
  }

  static Future<String?> loadCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentThemeKey);
  }
}
