import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/pengaturan/pin/pin_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class VerifyPinDialog extends StatelessWidget {
  const VerifyPinDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinController>(
        init: PinController(),
        builder: (c) {
          return AlertDialog(
            backgroundColor:
                AppConst.isLightTheme(context) ? whiteColor : bgDarkColor,
            title: Text('Masukkan PIN'.tr),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            content: Form(
              key: c.state.formKey,
              onChanged: () {
                c.state.formKey.currentState?.validate();
                c.update();
              },
              autovalidateMode: AutovalidateMode.always,
              child: SizedBox(
                height: Get.height * 0.1,
                child: CustomTextFormField(
                  controller: c.state.inputPin,
                  prefixIcon: const Icon(Icons.pin),
                  hintText: 'PIN'.tr,
                  validator: ValidationBuilder().pin().build(),
                  isObscure: c.state.isObscurePin,
                  multiLine: false,
                  inputFormatters: const [],
                  inputType: TextInputType.number,
                  suffixIcon: IconButton(
                    icon: c.state.showIcon,
                    onPressed: () => c.showPin(),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text(
                  'Batal'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConst.isLightTheme(context)
                          ? greyDarkColor2
                          : greyLightColor2),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (c.state.formKey.currentState?.validate() == true) {
                      c.verifyPin();
                    }
                  },
                  child: Text(
                    'Verifikasi'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor(context)),
                  )),
            ],
          );
        });
  }
}
