import 'package:collection/collection.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_screen.dart';
import 'package:css_mobile/screen/notification/notification_detail_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/items/notification_list_item.dart';
import 'package:get/get.dart';

class NotificationController extends BaseController {
  // final message = Get.arguments['message'] as RemoteMessage;
  bool isLoading = false;
  List<NotificationModel> readNotifList = [];
  List<NotificationModel> unreadNotifList = [];
  List<NotificationModel> temp = [];
  List<NotificationListItem> notificationList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    update();
    unreadNotifList = [];
    readNotifList = [];
    notificationList = [];
    try {
      var unread = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.unreadMessage));
      unreadNotifList.addAll(unread.payload ?? []);
      unreadNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));
      unreadNotifList.forEachIndexed(
        (i, e) => notificationList.add(
          NotificationListItem(
            data: e,
            isRead: true,
            onTap: () => readMessage(e),
          ),
        ),
      );

      var read = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.readMessage));
      readNotifList.addAll(read.payload ?? []);
      readNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));
      readNotifList.forEachIndexed(
        (i, e) => notificationList.add(NotificationListItem(
          data: e,
          isRead: false,
          onTap: () => readMessage(e),
        )),
      );
      update();

      notificationList
          .sort((a, b) => b.data.createDate!.compareTo(a.data.createDate!));
    } catch (e, i) {
      AppLogger.e('error getNotification $e, $i');
    }

    isLoading = false;
    update();
  }

  readMessage(NotificationModel value) {
    if (value.title?.split(' ').first == "Laporanku") {
      Get.to(const LaporankuScreen())?.then((_) => initData());
    } else {
      Get.to(NotificationDetailScreen(data: value))?.then((_) => initData());
    }

    unreadNotifList.removeWhere(
      (unread) => unread.id == value.id,
    );
    if (readNotifList.where((read) => read.id != value.id).isNotEmpty) {
      readNotifList.add(value);
      update();
    }

    storage.saveData(
      StorageCore.unreadMessage,
      GetNotificationModel(payload: unreadNotifList),
    );
    storage.saveData(
      StorageCore.readMessage,
      GetNotificationModel(payload: readNotifList),
    );
    unreadNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));

    readNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));
  }
}
