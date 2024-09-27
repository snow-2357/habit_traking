import 'package:flutter/material.dart';
import 'package:habit_tracking/theme/dark_mode.dart';
import 'package:habit_tracking/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  //get theme
  ThemeData get themeData => _themeData;
  //is dark
  bool get isDarkMode => _themeData == darkMode;
  //set
  set themeData(ThemeData themedata) {
    _themeData = themedata;
    notifyListeners();
  }

  //toggle
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
  }
}
