import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class AppConst {
  static final String base = FlavorConfig.instance.variables["base"];

  static final String baseFallback = FlavorConfig.instance.variables["base_fallback"];

  static bool isLightTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
