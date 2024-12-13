import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel data;

  const NotificationDetailScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBar(
        title: data.title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.network(
              data.img ?? '',
              width: Get.width,
            ),
            const SizedBox(height: 20),
            Text(
              data.text ?? '',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
