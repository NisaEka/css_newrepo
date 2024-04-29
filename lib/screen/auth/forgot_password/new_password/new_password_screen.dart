import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/auth/forgot_password/new_password/new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
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
              child: Stack(
                children: [
                  Column(
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
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: () {
                          controller.formKey.currentState?.validate();
                          controller.update();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: controller.newPW,
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Password baru'.tr,
                                validator: ValidationBuilder().password().build(),
                                isObscure: controller.isObscurePassword,
                                multiLine: false,
                                suffixIcon: IconButton(
                                  icon: controller.showIcon,
                                  onPressed: () {
                                    controller.isObscurePassword ? controller.isObscurePassword = false : controller.isObscurePassword = true;
                                    controller.isObscurePassword != false
                                        ? controller.showIcon = const Icon(
                                            Icons.visibility,
                                            // color: greyDarkColor1,
                                          )
                                        : controller.showIcon = const Icon(
                                            Icons.visibility_off,
                                            // color: Colors.black,
                                          );
                                    controller.update();
                                  },
                                ),
                              ),
                              CustomTextFormField(
                                controller: controller.confirmPW,
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Konfirmasi password baru'.tr,
                                validator: (value) {
                                  if (value != controller.newPW.text) {
                                    return "Password tidak sama".tr;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.formKey.currentState?.validate().printInfo();
                                  controller.update();
                                },
                                isObscure: controller.isObscurePasswordConfirm,
                                multiLine: false,
                                suffixIcon: IconButton(
                                  icon: controller.showConfirmIcon,
                                  onPressed: () {
                                    controller.isObscurePasswordConfirm
                                        ? controller.isObscurePasswordConfirm = false
                                        : controller.isObscurePasswordConfirm = true;
                                    controller.isObscurePasswordConfirm != false
                                        ? controller.showConfirmIcon = const Icon(
                                            Icons.visibility,
                                            // color: greyDarkColor1,
                                          )
                                        : controller.showConfirmIcon = const Icon(
                                            Icons.visibility_off,
                                            // color: Colors.black,
                                          );
                                    controller.update();
                                  },
                                ),
                              ),
                              CustomFilledButton(
                                color: controller.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                                title: 'Selanjutnya'.tr,
                                radius: 50,
                                onPressed: () => controller.formKey.currentState?.validate() == true ? controller.changePassword() : null,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  controller.isLoading ? const LoadingDialog() : const SizedBox()
                ],
              ),
            ),
          );
        });
  }
}
