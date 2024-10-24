import 'package:css_mobile/binding/global_binding.dart';
import 'package:css_mobile/config/firebase_config.dart';
import 'package:css_mobile/css.dart';
import 'package:flutter/material.dart';

void main() async{
  // FlavorConfig(
  //     name: "DEV",
  //     location: BannerLocation.topEnd,
  //     variables: devEnvironment
  // );

  WidgetsFlutterBinding.ensureInitialized();
  GlobalBinding().dependencies();
  CssFirebaseConfig.init();

  runApp(const CSS());
}



