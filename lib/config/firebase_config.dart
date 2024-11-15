import 'package:css_mobile/api/firebase_api.dart';
import 'package:css_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CssFirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: CssFirebaseOptions.currentPlatform,
    );
    await FirebaseApi.initNotification();

    if (kDebugMode) {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true);
    }
  }
}
