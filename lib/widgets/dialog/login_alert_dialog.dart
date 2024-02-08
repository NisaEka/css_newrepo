import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAlertDialog extends StatelessWidget {
  const LoginAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: const Text('Akses Terbatas'),
      content: Text(
        'Anda harus mempunyai akun CSS untuk menggunakan fitur ini'.tr,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Daftar'.tr),
          onPressed: () {
            Get.off(const SignUpScreen());
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Masuk'.tr),
          onPressed: () {
            Get.off(const LoginScreen());
          },
        ),
      ],
    );
  }
}
