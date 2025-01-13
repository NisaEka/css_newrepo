import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_controller.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryController extends BaseController {
  String? email = Get.arguments['email'];
  bool? isChange = Get.arguments['isChange'];

  final formKey = GlobalKey<FormState>();

  int? recovery;
  bool isLoading = false;

  String getMail() {
    var nameUser = email?.split("@");
    var emailCharacter = email?.replaceRange(
        2, nameUser?[0].length, "*" * (nameUser?[0].length ?? 0 - 3));
    return emailCharacter ?? '';
  }

  Future<void> initData() async {
    try {
      await profil.getBasicProfil().then((value) {
        email = value.data?.user?.emailRecovery ?? '';
        update();
      });
    } catch (e) {
      AppLogger.e('error get email recovery $e');
    }
  }

  Future<void> sendEmail() async {
    isLoading = true;
    update();
    try {
      await auth.postEmailForgotPassword(email ?? '').then(
            (value) => value.code == 200
                ? Get.delete<ForgotPasswordOTPController>().then(
                    (value) => Get.to(
                      () => const ForgotPasswordOTPScreen(),
                      arguments: {
                        'email': email,
                      },
                    ),
                  )
                : value.code == 404
                    ? AppSnackBar.error('User Not Found')
                    : value.code == 400
                        ? AppSnackBar.error(value.error?.first.message?.tr)
                        : AppSnackBar.error(value.message?.tr),
          );
    } catch (e) {
      AppLogger.e('error sendEmail $e');
    }
    isLoading = false;
    update();
  }
}
