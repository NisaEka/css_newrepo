import 'package:css_mobile/api/firebase_api.dart';
import 'package:css_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class CssFirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: CssFirebaseOptions.currentPlatform,
    );
    await FirebaseApi.initNotification();
  }
}
