import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
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
    color: greyDarkColor1,
  );
  Widget showConfirmIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );

  Future<void> changePassword() async {
    isLoading = true;
    update();
    try {
      await auth.postPasswordChage(InputNewPasswordModel(password: newPW.text, token: token)).then((value) => value.code == 200
          ? Get.to(
              SuccessScreen(
                message: "Password berhasil diperbaharui".tr,
                buttonTitle: isChange ?? false ? "Kembali ke Beranda".tr : "Masuk".tr,
                nextAction: () => Get.delete<LoginController>().then(
                  (value) => Get.offAll(isChange ?? false ? const DashboardScreen() : const LoginScreen()),
                ),
              ),
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
            ));
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}
