import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUmumListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const DataUmumListItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: blueJNE,
      ),
      title: Text(title.tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
      shape: const Border(bottom: BorderSide(color: greyColor)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
