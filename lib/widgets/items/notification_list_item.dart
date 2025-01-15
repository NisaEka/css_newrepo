import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationModel data;
  final bool isRead;
  final bool isLoading;
  final VoidCallback? onTap;

  const NotificationListItem({
    super.key,
    required this.data,
    this.isRead = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          color: isLoading
              ? greyColor
              : AppConst.isLightTheme(context)
                  ? greyLightColor2
                  : greyDarkColor1,
          height: isLoading ? 100 : null,
          child: ListTile(
            dense: false,
            trailing: isRead || data.isRead == true
                ? const Icon(
                    Icons.circle,
                    color: infoColor,
                  )
                : null,
            leading: data.title?.split(' ').first != "Laporanku"
                ? Icon(
                    Icons.info,
                    color: isRead ? infoColor : (primaryColor(context)),
                  )
                : Image.asset(
                    ImageConstant.hubungiAkuIcon,
                    height: 30,
                  ),
            selected: isRead || data.isRead == true,
            selectedColor: infoColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    data.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    data.createDate?.toLongDateTimeFormat().toString() ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            subtitle: SizedBox(
              height: 20,
              child: Text(
                data.text ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: primaryColor(context)),
            subtitleTextStyle: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
