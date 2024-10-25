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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiverController>(
        init: ReceiverController(),
        builder: (c) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: c.formKey,
                        onChanged: () {
                          c.formKey.currentState?.validate();
                          c.update();
                        },
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Get.to(const ListPenerimaScreen())?.then(
                                (result) {
                                  c.receiver = result;
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
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: redJNE,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              controller: c.namaPenerima,
                              hintText: "Nama Penerima".tr,
                              prefixIcon: const Icon(Icons.person),
                              isRequired: true,
                              validator: ValidationBuilder().name().build(),
                            ),
                            CustomTextFormField(
                              controller: c.nomorTelpon,
                              hintText: "Nomor Telepon".tr,
                              inputType: TextInputType.number,
                              prefixIcon: const Icon(Icons.phone),
                              isRequired: true,
                              validator:
                                  ValidationBuilder().phoneNumber().build(),
                            ),
                            DestinationDropdown(
                              onChanged: (value) {
                                c.selectedDestination = value;
                                c.update();
                              },
                              value: c.selectedDestination,
                              isRequired:
                                  c.selectedDestination == null ? true : false,
                              readOnly: false,
                              label: "Kota Tujuan".tr,
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: AppConst.isLightTheme(context)
                                    ? greyDarkColor1
                                    : greyLightColor1,
                              ),
                            ),
                            CustomTextFormField(
                              controller: c.alamatLengkap,
                              hintText: "Alamat".tr,
                              prefixIcon: const Icon(Icons.location_city),
                              multiLine: true,
                              isRequired: true,
                              validator: ValidationBuilder().address().build(),
                            ),
                            c.isOnline && c.isSaveReceiver()
                                ? CustomFilledButton(
                                    color: whiteColor,
                                    title: 'Simpan Data Penerima'.tr,
                                    borderColor:
                                        c.formKey.currentState?.validate() ==
                                                true
                                            ? blueJNE
                                            : greyColor,
                                    fontColor:
                                        c.formKey.currentState?.validate() ==
                                                true
                                            ? blueJNE
                                            : greyColor,
                                    onPressed: () =>
                                        c.formKey.currentState?.validate() ==
                                                true
                                            ? c.saveReceiver()
                                            : null,
                                  )
                                : const SizedBox(),
                            CustomFilledButton(
                              color: c.formKey.currentState?.validate() == true
                                  ? blueJNE
                                  : greyColor,
                              title: "Selanjutnya".tr,
                              onPressed: () =>
                                  c.formKey.currentState?.validate() == true
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
