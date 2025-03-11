import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  final SharedPreferences? _prefs;
  ThemeMode _themeMode;

  ThemeProvider([SharedPreferences? prefs])
      : _prefs = prefs,
        _themeMode = ThemeMode.system {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadThemeMode() async {
    if (_prefs != null) {
      final value = _prefs!.getString(_themeKey);
      if (value != null) {
        _themeMode = ThemeMode.values.firstWhere(
              (e) => e.toString() == value,
          orElse: () => ThemeMode.system,
        );
        notifyListeners();
      }
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    if (_prefs != null) {
      await _prefs!.setString(_themeKey, mode.toString());
    }
  }
}