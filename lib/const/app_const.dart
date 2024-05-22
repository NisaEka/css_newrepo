import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class AppConst {
  static final String baseUrl = FlavorConfig.instance.variables["base_url"];
  static final String cityUrl = FlavorConfig.instance.variables['city_url'];
  static final String jneUrl = FlavorConfig.instance.variables['jne_url'];
  static final String myJneUrl = FlavorConfig.instance.variables['myJNE_url'];

  static bool isLightTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
