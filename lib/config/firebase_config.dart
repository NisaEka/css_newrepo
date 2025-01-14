import 'package:css_mobile/api/firebase_api.dart';
import 'package:css_mobile/firebase_options.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:permission_handler/permission_handler.dart';

class CssFirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: CssFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      AppLogger.d("complete");
    });
    await FirebaseApi.initNotification();
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}
