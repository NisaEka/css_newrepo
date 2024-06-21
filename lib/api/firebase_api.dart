import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("fcmToken : $fcmToken");

    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    Get.to(const NotificationScreen(), arguments: {
      "message": message,
    });
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
