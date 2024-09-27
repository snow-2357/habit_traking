import 'package:flutter/material.dart';
import 'package:habit_tracking/theme/dark_mode.dart';
import 'package:habit_tracking/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  // Get the current theme
  ThemeData get themeData => _themeData;

  // Check if it's dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Set the theme
  set themeData(ThemeData td) {
    _themeData = td;
    notifyListeners();
  }

  // Toggle between light and dark themes
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners(); // Notify listeners to rebuild widgets when theme changes
  }
}
