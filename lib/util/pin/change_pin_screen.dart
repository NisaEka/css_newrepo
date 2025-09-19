// lib/screens/change_pin_screen.dart
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/pin/change_pin_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ChangePinScreen extends StatelessWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePinController>(
      init: ChangePinController(),
      builder: (c) => Scaffold(
        appBar: AppBar(title: Text('Ubah PIN'.tr)),
        body: Form(
          key: c.state.formKey,
          onChanged: () {
            c.state.formKey.currentState?.validate();
            c.update();
          },
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: c.state.oldPin,
                  prefixIcon: const Icon(Icons.pin),
                  hintText: 'PIN lama'.tr,
                  validator: ValidationBuilder().pin().build(),
                  isObscure: c.state.isObscureOldPin,
                  multiLine: false,
                  inputFormatters: const [],
                  inputType: TextInputType.number,
                  suffixIcon: IconButton(
                    icon: c.state.showIcon,
                    onPressed: () => c.showPin(),
                  ),
                ),
                CustomTextFormField(
                  controller: c.state.newPin,
                  prefixIcon: const Icon(Icons.pin),
                  hintText: 'PIN baru'.tr,
                  validator: ValidationBuilder().pin().build(),
                  isObscure: c.state.isObscureNewPin,
                  multiLine: false,
                  inputFormatters: const [],
                  inputType: TextInputType.number,
                  suffixIcon: IconButton(
                    icon: c.state.showNewIcon,
                    onPressed: () => c.showNewPin(),
                  ),
                ),
                CustomTextFormField(
                  controller: c.state.confPin,
                  prefixIcon: const Icon(Icons.pin),
                  hintText: 'Ulangi PIN'.tr,
                  inputFormatters: const [],
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value != c.state.newPin.text) {
                      return "PIN tidak sama".tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    c.state.formKey.currentState?.validate().printInfo();
                    c.update();
                  },
                  isObscure: c.state.isObscurePinConfirm,
                  multiLine: false,
                  suffixIcon: IconButton(
                    icon: c.state.showConfirmIcon,
                    onPressed: () => c.showConfirmPin(),
                  ),
                ),
                const SizedBox(height: 12),
                CustomFilledButton(
                  color: primaryColor(context),
                  title: 'Simpan'.tr,
                  onPressed: () {
                    if (c.state.formKey.currentState?.validate() == true) {
                      c.submit();
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
