import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/auth/forgot_password/new_password/new_password_controller.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPasswordController>(
        init: NewPasswordController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const LogoHeader(),
                  Container(
                    margin: const EdgeInsets.all(14),
                    child: Text(
                      "Buat password baru anda".tr,
                      style: appTitleTextStyle.copyWith(color: greyColor),
                    ),
                  ),
                  Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: controller.newPW,
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Password baru'.tr,
                          ),
                          CustomTextFormField(
                            controller: controller.confirmPW,
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Konfirmasi password baru'.tr,
                          ),
                          CustomFilledButton(
                            color: blueJNE,
                            title: 'Konfirmasi'.tr,
                            radius: 50,
                            onPressed: () => Get.to(SucceesScreen(
                              message: "Password berhasil diperbaharui".tr,
                              buttonTitle: "Masuk".tr,
                              nextAction: () => Get.offAll(const LoginScreen()),
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
