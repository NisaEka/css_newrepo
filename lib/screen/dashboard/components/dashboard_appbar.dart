import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardAppbar extends StatelessWidget {
  const DashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Image.asset(
        ImageConstant.logoCSS,
        height: 30,
        color: whiteColor,
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(const NotificationScreen()),
          icon: const Icon(
            Icons.notifications,
            color: whiteColor,
          ),
        ),
        IconButton(
          onPressed: () => Get.off(() => const PengaturanScreen()),
          icon: const Icon(
            Icons.settings,
            color: whiteColor,
          ),
        ),
      ],
    );
  }
}
