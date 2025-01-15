import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/obrolan/obrolan_laporanku_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_doc/agg_by_doc_screen.dart';
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

    try {
      // unread meesage
      var unread = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.unreadMessage));
      unreadNotifList.clear();
      unreadNotifList.addAll(unread.payload ?? []);
      unreadNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));

      // add item to notificationList
      for (var e in unreadNotifList) {
        if (notificationList.indexWhere((item) => item.data.id == e.id) == -1) {
          notificationList.add(
            NotificationListItem(
              data: e,
              isRead: true,
              onTap: () => readMessage(e),
            ),
          );
        }
      }

      // read meessage
      var read = GetNotificationModel.fromJson(
          await storage.readData(StorageCore.readMessage));
      readNotifList
        ..clear()
        ..addAll(read.payload ?? []);
      readNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));

      for (var e in readNotifList) {
        if (notificationList.indexWhere((item) => item.data.id == e.id) == -1) {
          notificationList.add(
            NotificationListItem(
              data: e,
              isRead: false,
              onTap: () => readMessage(e),
            ),
          );
        }
      }

      // Sort notificationList
      notificationList
          .sort((a, b) => b.data.createDate!.compareTo(a.data.createDate!));
    } catch (e, i) {
      AppLogger.e('error getNotification $e, $i');
    }

    isLoading = false;
    update();
  }

  Future<void> readMessage(NotificationModel value) async {
    String idMessage = value.text?.split(' : ').last.split('.').first ?? '';
    if (value.title == "CSS MOBILE - Laporanku") {
      isLoading = true;
      update();
      try {
        await laporanku
            .getTickets(QueryModel(
              where: [
                {"id": idMessage},
              ],
            ))
            .then(
              (ticket) => Get.to(
                () => const ObrolanLaporankuScreen(),
                arguments: {
                  'id': idMessage,
                  'ticket': ticket.data?.first,
                },
              )?.then((_) => updateNotificationStatus(value)),
            );
      } catch (e) {
        AppLogger.e('error get ticket message : $e');
      }
    } else if (value.title == "CSS MOBILE - AGREGASI PEMBAYARAN") {
      String aggDoc =
          value.text?.split(' : ').elementAt(1).split('.').first ?? '';

      Get.to(
        const AggByDocScreen(),
        arguments: {"aggregationID": aggDoc},
      )?.then((_) => updateNotificationStatus(value));
    } else {
      Get.to(() => NotificationDetailScreen(data: value))?.then(
        (_) => updateNotificationStatus(value),
      );
    }

    isLoading = false;
    update();
  }

  void updateNotificationStatus(NotificationModel value) {
    bool wasUnread = unreadNotifList.any((unread) => unread.id == value.id);
    unreadNotifList.removeWhere((unread) => unread.id == value.id);

    if (wasUnread &&
        readNotifList.indexWhere((read) => read.id == value.id) == -1) {
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

    notificationList = [
      ...unreadNotifList.map((e) => NotificationListItem(
            data: e,
            isRead: true,
            onTap: () => readMessage(e),
          )),
      ...readNotifList.map((e) => NotificationListItem(
            data: e,
            isRead: false,
            onTap: () => readMessage(e),
          )),
    ];

    readNotifList.sort((a, b) => b.createDate!.compareTo(a.createDate!));
    notificationList
        .sort((a, b) => b.data.createDate!.compareTo(a.data.createDate!));
    update();
  }
}
