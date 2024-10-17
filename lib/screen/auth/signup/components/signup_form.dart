import 'package:css_mobile/screen/auth/signup/signup_controller.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/versionsection.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';

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
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                    child: Column(
                      children: [
                        Center(child: Text('Buat akun anda'.tr, style: listTitleTextStyle)),
                        const SizedBox(height: 25),
                        CustomTextFormField(
                          controller: c.state.namaLengkap,
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Nama Lengkap'.tr,
                          isRequired: true,
                          validator: ValidationBuilder().name().build(),
                        ),
                        CustomTextFormField(
                          controller: c.state.namaBrand,
                          prefixIcon: const Icon(Icons.storefront_sharp),
                          hintText: 'Nama Brand / Bisnis'.tr,
                          isRequired: true,
                          validator: ValidationBuilder().name().build(),
                        ),
                        CustomTextFormField(
                          controller: c.state.noHp,
                          prefixIcon: const Icon(Icons.phone),
                          hintText: 'No Handphone'.tr,
                          isRequired: true,
                          inputType: TextInputType.number,
                          validator: ValidationBuilder().phoneNumber().build(),
                        ),
                        CustomTextFormField(
                          controller: c.state.email,
                          prefixIcon: const Icon(Icons.mail_outline),
                          hintText: 'Email'.tr,
                          isRequired: true,
                          validator: ValidationBuilder(localeName: c.state.locale).email().minLength(10).maxLength(50).build(),
                          inputFormatters: [
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              return newValue.copyWith(text: newValue.text.toLowerCase());
                            })
                          ],
                        ),
                        CustomSearchDropdownField<ReferalModel>(
                          asyncItems: (String filter) => c.getReferalList(filter),
                          itemBuilder: (context, e, b) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(
                                e.name.toString(),
                              ),
                            );
                          },
                          itemAsString: (ReferalModel e) => e.name.toString(),
                          onChanged: (value) => c.onSelectReferal(value),
                          value: c.state.selectedReferal,
                          selectedItem: c.state.selectedReferal?.name,
                          hintText: c.state.isLoadReferal ? "Loading..." : "Kode Referal".tr,
                          prefixIcon: const Icon(Icons.line_style),
                          textStyle: c.state.selectedReferal != null ? subTitleTextStyle : hintTextStyle,
                          readOnly: false,
                          isRequired: false,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          showClearButton: true,
                          showDropdownButton: c.state.selectedReferal == null,
                          onClear: () => c.unSelectReferal(),
                        ),
                        OriginDropdown(
                          onChanged : (value) => c.selectOrigin(value) ,
                        ),
                        // CustomSearchDropdownField<Origin>(
                        //   asyncItems: (String filter) => c.getOriginList(filter),
                        //   itemBuilder: (context, e, b) {
                        //     return Container(
                        //       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        //       child: Text(
                        //         e.originName.toString(),
                        //       ),
                        //     );
                        //   },
                        //   itemAsString: (Origin e) => e.originName.toString(),
                        //   onChanged: (value) => c.selectOrigin(value),
                        //   value: c.state.selectedOrigin,
                        //   selectedItem: c.state.kotaPengirim.text,
                        //   hintText: c.state.isLoadOrigin ? "Loading..." : "Kota Pengiriman".tr,
                        //   searchHintText: 'Masukan Kota Pengiriman'.tr,
                        //   prefixIcon: const Icon(Icons.location_city),
                        //   textStyle: c.state.selectedOrigin != null ? subTitleTextStyle : hintTextStyle,
                        //   readOnly: c.state.isDefaultOrigin,
                        //   isRequired: true,
                        // ),
                        c.state.isSelectCounter
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sudah menggunakan JNE'.tr),
                                  Switch(
                                    value: c.state.pakaiJNE,
                                    activeColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                                    onChanged: (value) {
                                      c.state.pakaiJNE = value;
                                      c.update();
                                    },
                                  )
                                ],
                              )
                            : const SizedBox(),
                        c.state.pakaiJNE && c.state.isSelectCounter
                            ? CustomDropDownFormField(
                                isRequired: c.state.pakaiJNE,
                                items: c.state.agenList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.custName ?? ''),
                                      ),
                                    )
                                    .toList(),
                                hintText: c.state.isLoadAgent ? 'Loading...' : 'Agen / Sales Counter'.tr,
                                onChanged: (value) {
                                  c.state.selectedAgent = value;
                                  c.update();
                                },
                                value: c.state.selectedAgent,
                                selectedItem: c.state.selectedAgent?.custName ?? '',
                              )
                            : const SizedBox(),
                        CustomFilledButton(
                          color: c.state.formKey.currentState?.validate() == true && c.state.selectedOrigin != null ? blueJNE : greyColor,
                          title: 'Daftar'.tr,
                          radius: 50,
                          onPressed: () {
                            if (c.state.formKey.currentState?.validate() == true && c.state.selectedOrigin != null) {
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
