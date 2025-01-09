import 'dart:convert';
import 'dart:io';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/model/notification/unread_message_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:css_mobile/util/logger.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AppLogger.i("Handling background message: ${message.messageId}");
  saveUnreadMessage(message);
  await Firebase.initializeApp();
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingOpenAppHandler(RemoteMessage message) async {
  AppLogger.i("Handling app open message: ${message.messageId}");
  saveUnreadMessage(message);
  await Firebase.initializeApp();
}

Future<void> saveUnreadMessage(RemoteMessage data) async {
  final DashboardController controller = Get.find();
  List<Messages> listUnread = [];
  List<NotificationModel> listUnreadMessage = [];
  var u = GetNotificationModel.fromJson(
      await StorageCore().readData(StorageCore.unreadMessage));
  if (u.payload?.isNotEmpty ?? false) {
    listUnreadMessage.addAll(u.payload ?? []);
  }
  listUnreadMessage.add(
    NotificationModel(
      id: data.messageId,
      category: data.notification?.title,
      text: data.notification?.body,
      createDate: data.sentTime.toString(),
      isRead: true,
      title: data.notification?.title,
      img: data.notification?.android?.imageUrl,
    ),
  );
  listUnread.add(
    Messages(
      senderId: data.senderId,
      category: data.category,
      collapseKey: data.collapseKey,
      contentAvailable: data.contentAvailable,
      data: data.data,
      from: data.from,
      messageId: data.messageId,
      messageType: data.messageType,
      mutableContent: data.mutableContent,
      notification: data.notification,
      sentTime: data.sentTime,
      threadId: data.threadId,
      ttl: data.ttl,
      isRead: false,
    ),
  );

  try {
    await StorageCore().saveData(
      StorageCore.unreadMessage,
      GetNotificationModel(payload: listUnreadMessage),
    );
    if (data.notification?.title == "CSS MOBILE - AGREGASI PEMBAYARAN") {
      await StorageCore()
          .writeString(StorageCore.lastAgg, data.sentTime.toString());
    }
    controller.cekMessages();
    controller.getAggregation();
    AppLogger.i("Message saved successfully");
  } catch (e, stackTrace) {
    AppLogger.e("Failed to save message", e, stackTrace);
  }
}

String? payload;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.payload != null) {
    Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
    var msg = RemoteMessage(data: data);
    FirebaseApi._handleTapOnNotification(msg);
  }
}

class FirebaseApi {
  static Future<void> initNotification() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      payload = notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // notificationCategories: darwinNotificationCategories,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        if (notificationResponse.payload != null) {
          AppLogger.i("Notification tapped: ${notificationResponse.payload}");
        }
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    AppLogger.i("FCM Token: ${await messaging.getToken()}");
    await StorageCore()
        .writeString(StorageCore.fcmToken, await messaging.getToken());

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        saveUnreadMessage(message);
        AppLogger.i("Received message at ${message.sentTime}");

        AndroidNotification? android = message.notification?.android;
        if (android != null) {
          flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            message.notification?.title,
            message.notification?.body,
            payload: jsonEncode(message.data),
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                priority: Priority.max,
              ),
            ),
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleTapOnNotification);

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        saveUnreadMessage(value);
      }
    });
  }

  static void _handleTapOnNotification(RemoteMessage data) {
    AppLogger.i("Navigating to notification screen");
    Get.to(() => const NotificationScreen());
  }
}
