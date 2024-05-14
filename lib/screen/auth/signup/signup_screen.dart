import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/versionsection.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(200),
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 10,
                          top: 40,
                          child: CustomBackButton(),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: Get.height / 4,
                            alignment: Alignment.topLeft,
                            child: Transform.flip(
                              flipX: true,
                              child: SvgPicture.asset(ImageConstant.vector2),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 140,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            ImageConstant.logoCSS_blue,
                            height: 67,
                            color: Theme.of(context).brightness == Brightness.light ? null : Colors.white,
                          ),
                        ),
                      ],
                    )),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const LogoHeader(),
                      Form(
                        key: controller.formKey,
                        onChanged: () async{
                          controller.initData();
                          controller.update();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                          child: Column(
                            children: [
                              Center(child: Text('Buat akun anda'.tr, style: listTitleTextStyle)),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                controller: controller.namaLengkap,
                                prefixIcon: const Icon(Icons.person),
                                hintText: 'Nama Lengkap'.tr,
                                isRequired: true,
                                validator: ValidationBuilder().name().build(),
                              ),
                              CustomTextFormField(
                                controller: controller.namaBrand,
                                prefixIcon: const Icon(Icons.storefront_sharp),
                                hintText: 'Nama Brand / Bisnis'.tr,
                                isRequired: true,
                                validator: ValidationBuilder().name().build(),
                              ),
                              CustomTextFormField(
                                controller: controller.noHp,
                                prefixIcon: const Icon(Icons.phone),
                                hintText: 'No Handphone'.tr,
                                isRequired: true,
                                inputType: TextInputType.number,
                                validator: ValidationBuilder().phoneNumber().build(),
                              ),
                              CustomTextFormField(
                                controller: controller.email,
                                prefixIcon: const Icon(Icons.mail_outline),
                                hintText: 'Email'.tr,
                                isRequired: true,
                                validator: ValidationBuilder(localeName: controller.locale).email().minLength(10).maxLength(50).build(),
                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return newValue.copyWith(text: newValue.text.toLowerCase());
                                  })
                                ],
                              ),
                              // Autocomplete<ReferalModel>(
                              //   optionsBuilder: (code) async => await controller.getReferalList(code.text.toUpperCase()),
                              //   displayStringForOption: (option) => option.name ?? '',
                              //   fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) => CustomTextFormField(
                              //     controller: textEditingController,
                              //     prefixIcon: const Icon(Icons.line_style),
                              //     hintText: 'Kode Referal'.tr,
                              //     onChanged: (value) => onFieldSubmitted,
                              //     focusNode: focusNode,
                              //   ),
                              //   // optionsViewOpenDirection: OptionsViewOpenDirection.up,
                              //   // optionsMaxHeight: 100,
                              //   onSelected: (ReferalModel selection) {
                              //     controller.kodeReferal.text = selection.name ?? '';
                              //     controller.update();
                              //   },
                              // ),
                              CustomSearchDropdownField<ReferalModel>(
                                asyncItems: (String filter) => controller.getReferalList(filter),
                                itemBuilder: (context, e, b) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child: Text(
                                      e.name.toString(),
                                    ),
                                  );
                                },
                                itemAsString: (ReferalModel e) => e.name.toString(),
                                onChanged: (value) => controller.onSelectReferal(value),
                                value: controller.selectedReferal,
                                selectedItem: controller.selectedReferal?.name,
                                hintText: controller.isLoadReferal ? "Loading..." : "Kode Referal".tr,
                                prefixIcon: const Icon(Icons.line_style),
                                textStyle: controller.selectedReferal != null ? subTitleTextStyle : hintTextStyle,
                                readOnly: false,
                                isRequired: false,
                              ),
                              CustomSearchDropdownField<Origin>(
                                asyncItems: (String filter) => controller.getOriginList(filter),
                                itemBuilder: (context, e, b) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child: Text(
                                      e.originName.toString(),
                                    ),
                                  );
                                },
                                itemAsString: (Origin e) => e.originName.toString(),
                                onChanged: (value) {
                                  controller.selectedOrigin = value;
                                  controller.kotaPengirim.text = controller.selectedOrigin?.originName ?? '';
                                  controller.branchCode = controller.selectedOrigin?.branchCode;
                                  controller.update();

                                  controller.getAgentList();
                                },
                                value: controller.selectedOrigin,
                                selectedItem: controller.kotaPengirim.text,
                                hintText: controller.isLoadOrigin ? "Loading..." : "Kota Pengiriman".tr,
                                prefixIcon: const Icon(Icons.location_city),
                                textStyle: controller.selectedOrigin != null ? subTitleTextStyle : hintTextStyle,
                                readOnly: controller.isDefaultOrigin,
                                isRequired: true,
                              ),
                              controller.isSelectCounter
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Sudah menggunakan JNE'.tr),
                                        Switch(
                                          value: controller.pakaiJNE,
                                          activeColor: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                                          onChanged: (value) {
                                            controller.pakaiJNE = value;
                                            controller.update();
                                          },
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              controller.pakaiJNE && controller.isSelectCounter
                                  ? CustomDropDownFormField(
                                      isRequired: controller.pakaiJNE,
                                      items: controller.agenList
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.custName ?? ''),
                                            ),
                                          )
                                          .toList(),
                                      hintText: controller.isLoadAgent ? 'Loading...' : 'Agen / Sales Counter'.tr,
                                      onChanged: (value) {
                                        controller.selectedAgent = value;
                                        controller.update();
                                      },
                                      value: controller.selectedAgent,
                                      selectedItem: controller.selectedAgent?.custName ?? '',
                                    )
                                  : const SizedBox(),
                              CustomFilledButton(
                                color: controller.formKey.currentState?.validate() == true && controller.selectedOrigin != null ? blueJNE : greyColor,
                                title: 'Daftar'.tr,
                                radius: 50,
                                onPressed: () {
                                  if (controller.formKey.currentState?.validate() == true && controller.selectedOrigin != null) {
                                    controller.mailValidation();
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
                ),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
