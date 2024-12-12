import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/input_email_controller.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class InputEmailScreen extends StatelessWidget {
  const InputEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputEmailController>(
        init: InputEmailController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const LogoHeader(),
                      Form(
                        key: controller.formKey,
                        onChanged: () => controller.initData(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              Center(
                                child: Text(
                                  controller.isChange
                                      ? 'Ubah Kata Sandi'.tr
                                      : 'Lupa kata sandi?'.tr,
                                  style: appTitleTextStyle.copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : whiteColor),
                                ),
                              ),
                              Text(
                                controller.isChange
                                    ? "change_password".tr
                                    : "forgot_password".tr,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                controller: controller.email,
                                hintText: "Email".tr,
                                suffixIcon: const Icon(Icons.mail_rounded),
                                isRequired: true,
                                validator: ValidationBuilder(
                                        localeName: controller.locale)
                                    .email()
                                    .minLength(10)
                                    .maxLength(50)
                                    .build(),
                                inputFormatters: [
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return newValue.copyWith(
                                        text: newValue.text.toLowerCase());
                                  })
                                ],
                                onSubmit: (value) => controller
                                            .formKey.currentState
                                            ?.validate() ==
                                        true
                                    ? controller.sendEmail()
                                    : null,
                              ),
                              const SizedBox(height: 30),
                              CustomFilledButton(
                                color: controller.formKey.currentState
                                            ?.validate() ==
                                        true
                                    ? blueJNE
                                    : greyColor,
                                title: "Berikutnya".tr,
                                suffixIcon: Icons.arrow_circle_right_rounded,
                                onPressed: () => controller.formKey.currentState
                                            ?.validate() ==
                                        true
                                    ? controller.sendEmail()
                                    : null,
                              ),
                              CustomFilledButton(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? blueJNE
                                    : Colors.white,
                                suffixIcon: Icons.cancel_rounded,
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
                ),
              ),
              controller.isLoading ? const LoadingDialog() : Container()
            ],
          );
        });
  }
}
