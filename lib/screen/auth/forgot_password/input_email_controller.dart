import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputEmailController extends BaseController {
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> sendEmail() async {
    try {
      await auth.postEmailForgotPassword(email.text).then(
            (value) => value.code == 201
                ? Get.to(
                    const ForgotPasswordOTPScreen(),
                    arguments: {
                      'email': email.text,
                    },
                  )
                : Get.showSnackbar(
                    GetSnackBar(
                      icon: const Icon(
                        Icons.warning,
                        color: whiteColor,
                      ),
                      message: 'Bad Request'.tr,
                      isDismissible: true,
                      duration: const Duration(seconds: 3),
                      backgroundColor: errorColor,
                    ),
                  ),
          );
    } catch (e) {
      e.printError();
    }
  }
}
