import 'package:css_mobile/screen/auth/signup/signup_controller.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/email_textformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
import 'package:css_mobile/widgets/forms/phone_textformfield.dart';
import 'package:css_mobile/widgets/forms/referal_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/versionsection.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:form_validator/form_validator.dart';

import '../../../../const/textstyle.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (c) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // const LogoHeader(),
                Form(
                  key: c.state.formKey,
                  onChanged: () async {
                    c.initData();
                    c.update();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 30),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'Buat akun anda'.tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        const SizedBox(height: 25),
                        CustomTextFormField(
                          controller: c.state.fullName,
                          prefixIcon: const Icon(Icons.person_2_rounded),
                          hintText: 'Nama Lengkap'.tr,
                          isRequired: true,
                          validator: ValidationBuilder().name().build(),
                        ),
                        CustomTextFormField(
                          controller: c.state.brandName,
                          prefixIcon: const Icon(Icons.store_rounded),
                          hintText: 'Nama Brand / Bisnis'.tr,
                          isRequired: true,
                          validator: ValidationBuilder().name().build(),
                        ),
                        PhoneTextFormField(controller: c.state.phone),
                        EmailTextformfield(controller: c.state.email),
                        ReferalDropdown(
                          label: "Kode Referal".tr,
                          onChanged: (value) => c.onSelectReferal(value),
                          onClear: () => c.unSelectReferal(),
                          value: c.state.selectedReferral,
                        ),
                        OriginDropdown(
                          onChanged: (value) => c.selectOrigin(value),
                          readOnly: c.state.isDefaultOrigin,
                          value: c.state.selectedOrigin,
                          selectedItem: c.state.origin.text,
                          prefixIcon: const Icon(Icons.trip_origin_rounded),
                        ),
                        c.state.isSelectCounter
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sudah menggunakan JNE'.tr,
                                      style: subTitleTextStyle.copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? blueJNE
                                              : whiteColor)),
                                  Switch(
                                    value: c.state.useJNE,
                                    activeColor: AppConst.isLightTheme(context)
                                        ? blueJNE
                                        : Colors.lightBlueAccent,
                                    inactiveThumbColor:
                                        AppConst.isLightTheme(context)
                                            ? blueJNE
                                            : Colors.lightBlueAccent,
                                    onChanged: (value) {
                                      c.state.useJNE = value;
                                      c.update();
                                    },
                                  )
                                ],
                              )
                            : const SizedBox(),
                        c.state.useJNE && c.state.isSelectCounter
                            ? CustomDropDownFormField(
                                isRequired: c.state.useJNE,
                                items: c.state.agentList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.custName ?? ''),
                                      ),
                                    )
                                    .toList(),
                                hintText: c.state.isLoadAgent
                                    ? 'Loading...'
                                    : 'Agen / Sales Counter'.tr,
                                onChanged: (value) {
                                  c.state.selectedAgent = value;
                                  c.update();
                                },
                                value: c.state.selectedAgent,
                                selectedItem:
                                    c.state.selectedAgent?.custName ?? '',
                              )
                            : const SizedBox(),
                        CustomFilledButton(
                          color: c.state.formKey.currentState?.validate() ==
                                      true &&
                                  c.state.selectedOrigin != null
                              ? primaryColor(context)
                              : greyColor,
                          title: 'Daftar'.tr,
                          suffixIcon: Icons.app_registration_rounded,
                          radius: 10,
                          onPressed: () {
                            if (c.state.formKey.currentState?.validate() ==
                                    true &&
                                c.state.selectedOrigin != null) {
                              c.mailValidation();
                            }
                          },
                        ),
                        const VersionApp()
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
