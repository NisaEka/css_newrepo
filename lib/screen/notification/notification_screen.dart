import 'package:css_mobile/screen/notification/notification_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
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
            body: controller.isLoading ? const LoadingDialog() : _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(NotificationController c, BuildContext context) {
    return c.notificationList.isNotEmpty
        ? ListView(
            children: c.notificationList
                .map(
                  (e) => NotificationListItem(
                    data: e,
                  ),
                )
                .toList(),
          )
        : DataEmpty(
            text: "Belum ada notifikasi tersedia".tr,
          );
  }
}
