import 'dart:convert';
import 'dart:io';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/model/notification/unread_message_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:css_mobile/util/navigation/notification_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  saveUnreadMessage(message);
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingOpenAppHandler(RemoteMessage message) async {
  saveUnreadMessage(message);
}

Future<void> saveUnreadMessage(RemoteMessage data) async {
  List<Messages> listUnread = [];
  List<NotificationModel> listUnreadMessage = [];
  var u = GetNotificationModel.fromJson(await StorageCore().readData(StorageCore.unreadMessage));
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
    ),
  );
  listUnread.add(Messages(
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
  ));
  // await StorageCore().saveData(StorageCore.unreadMessage, UnreadMessageModel(messages: listUnread));
  await StorageCore().saveData(StorageCore.unreadMessage, GetNotificationModel(payload: listUnreadMessage)).then(
        (value) => print("pesan tersimpan"),
      );
  // var u = await StorageCore().readData(StorageCore.unreadMessage);
  // u.printInfo(info: "unread");
}

String? payload;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (payload != null) {
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
      description: 'This channel is used for important notification for GAIS app.',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux ? null : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      payload = notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // notificationCategories: darwinNotificationCategories,
    );

    InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        if (notificationResponse.payload != null) {
          Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
          // _handleTapOnNotification(data);
        }
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print("fcmTokens ${await messaging.getToken()}");
    StorageCore().writeString(StorageCore.fcmToken, await messaging.getToken()).then((value) => print("fcm Token saved"),);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      if (message.notification != null) {
        AndroidNotification? android = message.notification?.android;
        saveUnreadMessage(message);
        print(message.sentTime);
        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
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
              ));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleTapOnNotification);

    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => saveUnreadMessage(value ?? const RemoteMessage()),
        );
  }

  static void _handleTapOnNotification(RemoteMessage data) {
    Get.to(const NotificationScreen());
  }
}
