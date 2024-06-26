import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationModel data;
  final bool isRead;
  final bool isLoading;

  const NotificationListItem({
    super.key,
    required this.data,
    this.isRead = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: isLoading
            ? greyColor
            : AppConst.isLightTheme(context)
                ? greyLightColor2
                : greyDarkColor1,
        height: isLoading ? 100 : null,
        child: ListTile(
          dense: true,
          horizontalTitleGap: 2,
          title: Text(data.category?.split('-').first ?? ''),
          subtitle: Text(data.text ?? ''),
          titleTextStyle: listTitleTextStyle.copyWith(
            color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
          ),
        ),
      ),
    );
  }
}
