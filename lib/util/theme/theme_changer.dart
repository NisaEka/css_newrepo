import 'package:css_mobile/base/theme_controller.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeDataStyle = CustomTheme.light;

  ThemeData get themeDataStyle => _themeDataStyle;

  set themeDataStyle(ThemeData themeData) {
    _themeDataStyle = themeData;
    notifyListeners();
  }

  void changeTheme() {
    if (_themeDataStyle == CustomTheme.light) {
      themeDataStyle = CustomTheme.dark;
    } else {
      themeDataStyle = CustomTheme.light;
    }
  }
}
