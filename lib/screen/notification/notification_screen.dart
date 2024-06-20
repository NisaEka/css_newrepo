import 'package:css_mobile/screen/notification/notification_controller.dart';
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
          appBar: AppBar(
            title: Text("Notifikasi".tr),
          ),
          body: _bodyContent(controller, context),
        );
      }
    );
  }

  Widget _bodyContent(NotificationController c, BuildContext context){
    return Column(
      children: [
        Text(c.message.notification?.title.toString() ?? ''),
        Text(c.message.notification?.body.toString() ?? ''),
        Text(c.message.data.toString() ?? ''),
      ],
    );
  }
}
