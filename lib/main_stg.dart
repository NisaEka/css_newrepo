import 'dart:async';

import 'package:css_mobile/binding/global_binding.dart';
import 'package:css_mobile/config/env.dart';
import 'package:css_mobile/css.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'config/firebase_config.dart';

Future<void> main() async {
  FlavorConfig(
      name: "local",
      location: BannerLocation.topEnd,
      variables: stgEnvironment,
      color: Colors.red);

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      CssFirebaseConfig.init();
      GlobalBinding().dependencies();
      runApp(const CSS());
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
