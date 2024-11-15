import 'dart:async';

import 'package:css_mobile/binding/global_binding.dart';
import 'package:css_mobile/config/env.dart';
import 'package:css_mobile/config/firebase_config.dart';
import 'package:css_mobile/css.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() async {
  await runZonedGuarded(
    () async {
      FlavorConfig(
        name: "DEV",
        location: BannerLocation.topEnd,
        variables: devEnvironment,
      );

      WidgetsFlutterBinding.ensureInitialized();
      GlobalBinding().dependencies();
      CssFirebaseConfig.init();
      runApp(const CSS());
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
