import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingListItem extends StatelessWidget {
  final String title;
  final IconData leading;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingListItem({
    super.key,
    required this.title,
    required this.leading,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leading,
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
      trailing: trailing,
    );
  }
}
