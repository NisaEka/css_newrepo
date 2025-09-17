import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/pin/pin_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinController>(
      init: PinController(),
      builder: (c) => Scaffold(
        appBar: AppBar(title: Text('Setel PIN'.tr)),
        body: Form(
          key: c.formKey,
          onChanged: () {
            c.formKey.currentState?.validate();
            c.update();
          },
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: c.pin,
                  prefixIcon: const Icon(Icons.pin),
                  hintText: 'PIN'.tr,
                  validator: ValidationBuilder().pin().build(),
                  isObscure: c.isObscurePin,
                  multiLine: false,
                  inputFormatters: const [],
                  inputType: TextInputType.number,
                  suffixIcon: IconButton(
                    icon: c.showIcon,
                    onPressed: () => c.showPin(),
                  ),
                ),
                CustomTextFormField(
                  controller: c.confirmPIN,
                  prefixIcon: const Icon(Icons.pin),
                  hintText: 'Ulangi PIN'.tr,
                  inputFormatters: const [],
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value != c.pin.text) {
                      return "PIN tidak sama".tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    c.formKey.currentState?.validate().printInfo();
                    c.update();
                  },
                  isObscure: c.isObscurePinConfirm,
                  multiLine: false,
                  suffixIcon: IconButton(
                    icon: c.showConfirmIcon,
                    onPressed: () => c.showConfirmPin(),
                  ),
                ),
                CustomFilledButton(
                  color: primaryColor(context),
                  title: 'Simpan'.tr,
                  onPressed: () {
                    if (c.formKey.currentState?.validate() == true) {
                      c.savePin();
                    }
                  },
                  width: Get.width * 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
