import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/new_password/new_password_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPasswordController>(
        init: NewPasswordController(),
        builder: (c) {
          return Column(
            children: [
              const LogoHeader(),
              Container(
                margin: const EdgeInsets.all(14),
                child: Text(
                  "Buat kata sandi baru anda".tr,
                  style: appTitleTextStyle.copyWith(color: greyColor),
                ),
              ),
              Form(
                key: c.formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  c.formKey.currentState?.validate();
                  c.update();
                },
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: c.newPW,
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Kata sandi baru'.tr,
                        validator: ValidationBuilder().password().build(),
                        isObscure: c.isObscurePassword,
                        multiLine: false,
                        inputFormatters: const [],
                        suffixIcon: IconButton(
                          icon: c.showIcon,
                          onPressed: () => c.showPassword(),
                        ),
                      ),
                      CustomTextFormField(
                        controller: c.confirmPW,
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Konfirmasi Kata Sandi baru'.tr,
                        inputFormatters: const [],
                        validator: (value) {
                          if (value != c.newPW.text) {
                            return "Kata sandi tidak sama".tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          c.formKey.currentState?.validate().printInfo();
                          c.update();
                        },
                        isObscure: c.isObscurePasswordConfirm,
                        multiLine: false,
                        suffixIcon: IconButton(
                          icon: c.showConfirmIcon,
                          onPressed: () => c.showConfirmPassword(),
                        ),
                      ),
                      CustomFilledButton(
                        color: c.formKey.currentState?.validate() == true
                            ? primaryColor(context)
                            : greyColor,
                        title: 'Selanjutnya'.tr,
                        onPressed: () =>
                            c.formKey.currentState?.validate() == true
                                ? c.changePassword()
                                : null,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
