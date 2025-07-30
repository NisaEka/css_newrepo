import 'dart:async';

import 'package:css_mobile/api/firebase_api.dart';
import 'package:css_mobile/binding/global_binding.dart';
import 'package:css_mobile/config/env.dart';
import 'package:css_mobile/config/firebase_config.dart';
import 'package:css_mobile/css.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

void main() async {
  FlavorConfig(variables: prodEnvironment);

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      CssFirebaseConfig.init();
      final network = NetworkCore();
      await network.init();

      Get.put(network);

      GlobalBinding().dependencies();
      runApp(const CSS());
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
