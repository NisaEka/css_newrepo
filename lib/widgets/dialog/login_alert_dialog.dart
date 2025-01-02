import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAlertDialog extends StatelessWidget {
  const LoginAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAlertDialog(
      title: 'Akses Terbatas'.tr,
      subtitle: 'access_denied'.tr,
      confirmButtonTitle: 'Masuk'.tr,
      backButtonTitle: 'Daftar'.tr,
      onConfirm: () {
        Get.off(() => const LoginScreen());
      },
      onBack: () {
        Get.off(() => const SignUpScreen());
      },
    );
  }
}
