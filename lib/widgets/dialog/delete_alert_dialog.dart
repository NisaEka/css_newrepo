import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAlertDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onBack;

  const DeleteAlertDialog({
    super.key,
    required this.onDelete,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : bgDarkColor,
      title: Text('Data akan dihapus'.tr,
          style: TextStyle(
              color: AppConst.isLightTheme(context)
                  ? greyDarkColor2
                  : greyLightColor2)),
      content: Text(
        'Anda yakin menghapus data ini ?'.tr,
        style: TextStyle(
            color: AppConst.isLightTheme(context) ? greyDarkColor1 : greyColor),
      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onBack,
            child: Text(
              'Tidak'.tr,
              style: TextStyle(
                  color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
            )),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: onDelete,
          child: Text('Hapus'.tr,
              style: TextStyle(
                  color: AppConst.isLightTheme(context) ? blueJNE : infoColor)),
        ),
      ],
    );
  }
}
