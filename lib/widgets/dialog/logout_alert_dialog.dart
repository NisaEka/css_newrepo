import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutAlertDialog extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback? onBack;

  const LogoutAlertDialog({
    super.key,
    required this.onLogout,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : bgDarkColor,
      title: Text('Anda akan keluar'.tr,
          style: TextStyle(
              color: AppConst.isLightTheme(context)
                  ? greyDarkColor2
                  : greyLightColor2)),
      content: Text(
        'Anda yakin Keluar ?'.tr,
        style: TextStyle(
            color: AppConst.isLightTheme(context) ? greyDarkColor1 : greyColor),
      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onBack ?? () => Get.back(),
            child: Text(
              'Tidak'.tr,
              style: TextStyle(
                  color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
            )),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: onLogout,
          child: Text(
            'Keluar'.tr,
            style: TextStyle(
                color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
          ),
        ),
      ],
    );
  }
}
