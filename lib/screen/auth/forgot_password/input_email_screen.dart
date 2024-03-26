import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/input_email_controller.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class InputEmailScreen extends StatelessWidget {
  const InputEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputEmailController>(
        init: InputEmailController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                ListView(
                  children: [
                    const LogoHeader(),
                    Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            Center(
                              child: Text(
                                controller.isChange ? 'Ubah Kata Sandi'.tr : 'Lupa kata sandi?'.tr,
                                style: appTitleTextStyle.copyWith(color: Colors.black),
                              ),
                            ),
                            Text(
                              controller.isChange ? "change_password".tr : "forgot_password".tr,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 25),
                            CustomTextFormField(
                              controller: controller.email,
                              hintText: "Email".tr,
                              isRequired: true,
                              validator: ValidationBuilder().email().minLength(10).build(),
                              inputFormatters: const [],
                            ),
                            const SizedBox(height: 30),
                            CustomFilledButton(
                              color: blueJNE,
                              title: "Berikutnya".tr,
                              onPressed: () => controller.formKey.currentState?.validate() == true ? controller.sendEmail() : null,
                            ),
                            CustomFilledButton(
                              color: blueJNE,
                              isTransparent: true,
                              title: "Batal".tr,
                              onPressed: () => Get.back(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                controller.isLoading ? const LoadingDialog() : Container()
              ],
            ),
          );
        });
  }
}
