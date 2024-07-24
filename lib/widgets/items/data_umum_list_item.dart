import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUmumListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isLoading;
  final String? tooltip;

  const DataUmumListItem({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.icon,
    this.isLoading = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: isLoading
          ? Container(
              width: Get.width,
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: greyLightColor3,
            )
          : Tooltip(
              message: tooltip ?? '',
              child: ListTile(
                leading: Tooltip(
                  message: tooltip ?? '',
                  child: Icon(
                    icon,
                    size: 24,
                    color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                  ),
                ),
                title: Text(
                  title.tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: subtitle.isNotEmpty
                    ? Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : null,
                shape: const Border(bottom: BorderSide(color: greyColor)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
    );
  }
}
