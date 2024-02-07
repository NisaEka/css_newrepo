import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAlertDialog extends StatelessWidget {
  const LoginAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: const Text('Akses Terbatas '),
      content: const Text(
        'Anda harus login untuk menggunakan fitur ini',
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('kembali'.tr),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Login'.tr),
          onPressed: () {
            Get.off(const LoginScreen());
          },
        ),
      ],
    );
  }
}
