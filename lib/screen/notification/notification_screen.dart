import 'package:css_mobile/screen/notification/notification_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/items/notification_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Notifikasi".tr,
            ),
            body: RefreshIndicator(
              onRefresh: () => controller.initData(),
              child: controller.isLoading
                  ? const LoadingDialog()
                  : _bodyContent(controller, context),
            ),
          );
        });
  }

  Widget _bodyContent(NotificationController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: c.unreadNotifList
              .map(
                (e) => e.id == null
                    ? const SizedBox()
                    : NotificationListItem(
                        data: e,
                        isRead: true,
                        onTap: () => c.readMessage(e),
                      ),
              )
              .toList(),
        ),
        SliverList.list(
          children: c.notificationList
              .map(
                (e) => e.id == null
                    ? const SizedBox()
                    : NotificationListItem(
                        data: e,
                        isRead: false,
                        onTap: () => c.readMessage(e),
                      ),
              )
              .toList(),
        ),
        // c.notificationList.isNotEmpty
        //     ? SliverList.list(
        //         children: c.notificationList
        //             .map(
        //               (e) => NotificationListItem(
        //                 data: e,
        //                 // onTap: () => c.readMessage(e.id ?? ''),
        //               ),
        //             )
        //             .toList(),
        //       )
        //     : SliverList.list(
        //         children: [
        //           DataEmpty(
        //             text: "Belum ada notifikasi tersedia".tr,
        //           ),
        //         ],
        //       ),
      ],
    );
  }
}
