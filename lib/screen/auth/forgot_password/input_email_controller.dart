import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class InputEmailController extends BaseController {
  bool isChange = Get.arguments['isChange'];
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? locale;

  Future<void> initData() async {
    locale = await storage.readString(StorageCore.localeApp);
    ValidationBuilder.setLocale(locale!);
    update();
  }

  Future<void> sendEmail() async {
    isLoading = true;
    update();
    try {
      await auth.postEmailForgotPassword(email.text).then(
            (value) => value.code == 201
                ? Get.to(
                    const ForgotPasswordOTPScreen(),
                    arguments: {
                      'email': email.text,
                    },
                  )
                : value.code == 404
                    ? AppSnackBar.error('User Not Found')
                    : value.code == 400
                        ? AppSnackBar.error(value.error?.first.message?.tr)
                        : AppSnackBar.error(value.message?.tr),
          );
    } catch (e) {
      e.printError();
    }
    isLoading = false;
    update();
  }
}
