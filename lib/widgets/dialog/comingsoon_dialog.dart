import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: Text('Akan Segera Hadir'.tr),
      content: Text(
        'coming_soon'.tr,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Tutup'.tr),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
