import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_controller.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryController extends BaseController {
  String? email = Get.arguments['email'];
  bool? isChange = Get.arguments['isChange'];

  final formKey = GlobalKey<FormState>();

  int? recovery;
  bool isLoading = false;

  // String? email;

  @override
  void onInit() {
    super.onInit();
    // Future.wait([initData()]);
  }

  String getMail() {
    var nameUser = email?.split("@");
    var emailCharacter = email?.replaceRange(2, nameUser?[0].length, "*" * (nameUser?[0].length ?? 0 - 3));
    return emailCharacter ?? '';
  }

  Future<void> initData() async {
    try {
      await profil.getBasicProfil().then((value) {
        email = value.data?.user?.emailRecovery ?? '';
        update();
      });
    } catch (e) {
      e.printError();
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
                      const ForgotPasswordOTPScreen(),
                      arguments: {
                        'email': email,
                      },
                    ),
                  )
                : value.code == 404
                    ? Get.showSnackbar(
                        GetSnackBar(
                          icon: const Icon(
                            Icons.warning,
                            color: whiteColor,
                          ),
                          message: 'User Not Found'.tr,
                          isDismissible: true,
                          duration: const Duration(seconds: 3),
                          backgroundColor: errorColor,
                        ),
                      )
                    : value.code == 400
                        ? Get.showSnackbar(
                            GetSnackBar(
                              icon: const Icon(
                                Icons.warning,
                                color: whiteColor,
                              ),
                              message: value.error?.first.message?.tr,
                              isDismissible: true,
                              duration: const Duration(seconds: 3),
                              backgroundColor: errorColor,
                            ),
                          )
                        : Get.showSnackbar(
                            GetSnackBar(
                              icon: const Icon(
                                Icons.warning,
                                color: whiteColor,
                              ),
                              message: value.message?.tr,
                              isDismissible: true,
                              duration: const Duration(seconds: 3),
                              backgroundColor: errorColor,
                            ),
                          ),
          );
    } catch (e) {
      e.printError();
    }
    isLoading = false;
    update();
  }
}
