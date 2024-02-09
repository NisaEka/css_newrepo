import 'package:css_mobile/binding/global_binding.dart';
import 'package:css_mobile/config/env.dart';
import 'package:css_mobile/css.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() async {
  FlavorConfig(
    name: "DEV",
    location: BannerLocation.topEnd,
    variables: devEnvironment,
  );

  WidgetsFlutterBinding.ensureInitialized();
  GlobalBinding().dependencies();

  runApp(const CSS());
}
