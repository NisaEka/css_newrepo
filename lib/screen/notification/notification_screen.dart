import 'package:css_mobile/screen/notification/notification_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
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
              child: Stack(
                children: [
                  _bodyContent(controller, context),
                  controller.isLoading
                      ? const LoadingDialog()
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }

  Widget _bodyContent(NotificationController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
            children: c.notificationList
                .map(
                  (e) => e,
                )
                .toList()),
      ],
    );
  }
}
