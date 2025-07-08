import 'dart:async';
import 'package:css_mobile/binding/global_binding.dart';
import 'package:css_mobile/config/env.dart';
import 'package:css_mobile/config/firebase_config.dart';
import 'package:css_mobile/css.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

void main() async {
  FlavorConfig(
    name: "DEV",
    location: BannerLocation.topEnd,
    variables: devEnvironment,
  );

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      debugPrint("🔥 Flutter binding done");

      await CssFirebaseConfig.init();
      debugPrint("🔥 Firebase config done");

      final network = NetworkCore();
      debugPrint("⏳ Initializing NetworkCore...");
      await network.init();
      debugPrint("✅ NetworkCore initialized");
      Get.put(network);
      debugPrint("📦 NetworkCore injected");

      GlobalBinding().dependencies();
      debugPrint("🔗 GlobalBinding done");
      runApp(const CSS());
      debugPrint("🚀 App started");
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
