import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';

class NotificationController extends BaseController {
  // final message = Get.arguments['message'] as RemoteMessage;
  bool isLoading = false;
  List<NotificationModel> notificationList = [];
  List<NotificationModel> unreadNotifList = [];
  List<NotificationModel> temp = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    update();
    unreadNotifList = [];
    notificationList = [];
    try {
      // await notification.getNotificationsList().then((value) {
      //   notificationList.addAll(value.payload ?? []);
      //   update();
      // });

      var unread = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.unreadMessage));
      unreadNotifList.addAll(unread.payload ?? []);
      unreadNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));

      var read = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.readMessage));
      notificationList.addAll(read.payload ?? []);
      notificationList.sort((a, b) => b.createDate!.compareTo(a.createDate!));

      // notificationList.addAll(unread.payload ?? []);
      update();
    } catch (e, i) {
      AppLogger.e('error getNotification $e, $i');
    }

    for (var local in unreadNotifList) {
      if (notificationList
          .where((e) => e.createDate == local.createDate)
          .isNotEmpty) {
        temp.add(notificationList
            .where((e) => e.createDate == local.createDate)
            .first);
        notificationList.removeWhere((e) => e.createDate == local.createDate);
      }
      update();
    }
    isLoading = false;
    update();
  }

  readMessage(NotificationModel value, int index) {
    // NotificationModel t = value.copyWith(isRead: false);
    unreadNotifList.removeAt(index);
    // unreadNotifList.add(t);
    notificationList.add(value);
    // unreadNotifList.removeWhere((e) => e.id == value.id || (value.id?.isEmpty ?? false));
    // unreadNotifList
    //     .where((e) => e.id == value.id || (value.id?.isEmpty ?? false))
    //     .first
    //     .setisRead(false);
    update();

    storage.saveData(
      StorageCore.unreadMessage,
      GetNotificationModel(payload: unreadNotifList),
    );
    storage.saveData(
      StorageCore.readMessage,
      GetNotificationModel(payload: notificationList),
    );
    notificationList.addAll(temp);
    unreadNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));

    notificationList.sort((a, b) => b.createDate!.compareTo(a.createDate!));
  }
}
