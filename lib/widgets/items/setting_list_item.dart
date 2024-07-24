import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingListItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
      ),
      title: Text(
        title.tr,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      shape: const Border(bottom: BorderSide(color: greyColor)),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
