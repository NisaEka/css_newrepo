import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends BaseController {
  String token = Get.arguments['token'];
  bool? isChange = Get.arguments['isChange'];

  final formKey = GlobalKey<FormState>();
  final newPW = TextEditingController();
  final confirmPW = TextEditingController();

  bool isObscurePassword = true;
  bool isObscurePasswordConfirm = true;
  bool isLoading = false;
  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );
  Widget showConfirmIcon = const Icon(
    Icons.remove_red_eye,
  );

  Future<void> changePassword() async {
    isLoading = true;
    update();
    try {
      await auth
          .postPasswordChage(
              InputNewPasswordModel(password: newPW.text, token: token))
          .then((value) => value.code == 201
              ? Get.to(
                  () => SuccessScreen(
                    message: "Password berhasil diperbaharui".tr,
                    thirdButtonTitle: isChange ?? false
                        ? "Kembali ke Beranda".tr
                        : "Masuk".tr,
                    onThirdAction: () => Get.delete<LoginController>().then(
                      (value) => Get.offAll(isChange ?? false
                          ? () => const DashboardScreen()
                          : () => const LoginScreen()),
                    ),
                  ),
                )
              : AppSnackBar.error(value.message[0].toString()));
    } catch (e, i) {
      AppLogger.e('error change password $e, $i');
    }

    isLoading = false;
    update();
  }

  showPassword() {
    isObscurePassword ? isObscurePassword = false : isObscurePassword = true;
    isObscurePassword != false
        ? showIcon = const Icon(
            Icons.visibility,
          )
        : showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  showConfirmPassword() {
    isObscurePasswordConfirm
        ? isObscurePasswordConfirm = false
        : isObscurePasswordConfirm = true;
    isObscurePasswordConfirm != false
        ? showConfirmIcon = const Icon(
            Icons.visibility,
          )
        : showConfirmIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }
}
