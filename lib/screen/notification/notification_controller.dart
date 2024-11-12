import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

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
      await notification.getNotificationsList().then((value) {
        notificationList.addAll(value.payload ?? []);
        update();
      });

      var unread = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.unreadMessage));
      unreadNotifList.addAll(unread.payload ?? []);
      // notificationList.addAll(unread.payload ?? []);
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
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

  readMessage(String id) {
    unreadNotifList.removeWhere((e) => e.id == id || id.isEmpty);
    // notificationList.removeWhere((e) => e.id == id || id.isEmpty);
    update();
    storage.saveData(StorageCore.unreadMessage,
        GetNotificationModel(payload: unreadNotifList));
    notificationList.addAll(temp);
  }
}
