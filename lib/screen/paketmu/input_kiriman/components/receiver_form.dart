import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver/list_receiver_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/destination_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ReceiverForm extends StatelessWidget {
  const ReceiverForm({super.key});

  get color => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiverController>(
        init: ReceiverController(),
        builder: (c) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: c.state.formKey,
                        onChanged: () {
                          c.state.formKey.currentState?.validate();
                          c.update();
                        },
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Get.to(const ListPenerimaScreen())?.then(
                                (result) {
                                  c.state.receiver = result;
                                  c.update();
                                  c.getSelectedReceiver();
                                },
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: greyColor, width: 2),
                                      top: BorderSide(
                                          color: greyColor, width: 2)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Lihat Data Penerima'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_right_rounded,
                                      color: color ??
                                          (AppConst.isLightTheme(context)
                                              ? blueJNE
                                              : warningColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              controller: c.state.receiverName,
                              hintText: "Nama Penerima".tr,
                              prefixIcon: const Icon(Icons.person_2_rounded),
                              isRequired: true,
                              validator: ValidationBuilder().name().build(),
                            ),
                            CustomTextFormField(
                              controller: c.state.receiverPhone,
                              hintText: "Nomor Telepon".tr,
                              inputType: TextInputType.number,
                              prefixIcon: const Icon(Icons.phone_rounded),
                              isRequired: true,
                              validator:
                                  ValidationBuilder().phoneNumber().build(),
                            ),
                            DestinationDropdown(
                              onChanged: (value) {
                                c.state.selectedDestination = value;
                                c.update();
                              },
                              value: c.state.selectedDestination,
                              isRequired: c.state.selectedDestination == null
                                  ? true
                                  : false,
                              readOnly: false,
                              label: "Kota Tujuan".tr,
                              prefixIcon: Icon(
                                Icons.trip_origin_rounded,
                                color: AppConst.isLightTheme(context)
                                    ? greyDarkColor1
                                    : greyLightColor1,
                              ),
                            ),
                            CustomTextFormField(
                              controller: c.state.receiverAddress,
                              hintText: "Alamat".tr,
                              prefixIcon: const Icon(Icons.home_work_rounded),
                              multiLine: true,
                              isRequired: true,
                              validator: ValidationBuilder().address().build(),
                            ),
                            c.state.isOnline && c.isSaveReceiver()
                                ? CustomFilledButton(
                                    color: whiteColor,
                                    title: 'Simpan Data Penerima'.tr,
                                    suffixIcon: Icons.save_alt_rounded,
                                    borderColor: (c.state.formKey.currentState
                                                    ?.validate() ==
                                                true ||
                                            c.state.isValidate)
                                        ? primaryColor(context)
                                        : greyColor,
                                    fontColor: c.state.formKey.currentState
                                                    ?.validate() ==
                                                true ||
                                            c.state.isValidate
                                        ? primaryColor(context)
                                        : greyColor,
                                    onPressed: () => c
                                                    .state.formKey.currentState
                                                    ?.validate() ==
                                                true ||
                                            c.state.isValidate
                                        ? c.saveReceiver()
                                        : null,
                                  )
                                : const SizedBox(),
                            CustomFilledButton(
                              color: c.state.formKey.currentState?.validate() ==
                                          true ||
                                      c.state.isValidate
                                  ? primaryColor(context)
                                  : greyColor,
                              title: "Selanjutnya".tr,
                              suffixIcon: Icons.arrow_circle_right_rounded,
                              onPressed: () =>
                                  c.state.formKey.currentState?.validate() ==
                                              true ||
                                          c.state.isValidate
                                      ? c.nextStep()
                                      : null,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
