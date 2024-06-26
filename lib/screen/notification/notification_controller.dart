import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends BaseController {
  // final message = Get.arguments['message'] as RemoteMessage;
  bool isLoading = false;
  List<NotificationModel> notificationList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    update();
    try {
      await notification.getNotificationsList().then((value) {
        notificationList.addAll(value.payload ?? []);
        update();
      });
    } catch (e,i) {
      e.printError();
      i.printError();

    }

    isLoading = false;
    update();
  }
}
