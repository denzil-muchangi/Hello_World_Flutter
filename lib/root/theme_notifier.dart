import 'package:flutter/material.dart';
import 'package:hello_world/root/theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}