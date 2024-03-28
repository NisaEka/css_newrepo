import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_controller.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/list_penerima_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/tooltip_custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPenerimaScreen extends StatefulWidget {
  const InformasiPenerimaScreen({super.key});

  @override
  State<InformasiPenerimaScreen> createState() => _InformasiPenerimaScreenState();
}

class _InformasiPenerimaScreenState extends State<InformasiPenerimaScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformasiPenerimaController>(
        init: InformasiPenerimaController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Input Transaksi'.tr,
              flexibleSpace: Column(
                children: [
                  CustomStepper(
                    currentStep: 1,
                    totalStep: controller.steps.length,
                    steps: controller.steps,
                  ),
                  const SizedBox(height: 15),
                  // !controller.isOnline ? const OfflineBar() : const SizedBox(),
                ],
              ),
              action: [
                controller.isOnline
                    ? const SizedBox()
                    : Tooltip(
                        key: controller.offlineTooltipKey,
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(seconds: 3),
                        decoration: ShapeDecoration(
                          color: greyColor,
                          shape: ToolTipCustomShape(usePadding: false),
                        ),
                        // textStyle: listTitleTextStyle.copyWith(color: whiteColor),
                        message: 'Offline Mode',
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.cloud_off,
                            color: whiteColor,
                          ),
                        ),
                      )
              ],
            ),
            body: SingleChildScrollView(
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
                            key: controller.formKey,
                            onChanged: () {
                              controller.formKey.currentState?.validate();
                              controller.update();
                            },
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async => controller.selectedReceiver = await Get.to(const ListPenerimaScreen())?.then(
                                    (result) => controller.getSelectedReceiver(result),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: greyColor, width: 2), top: BorderSide(color: greyColor, width: 2)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Lihat Data Penerima'.tr),
                                        const Icon(
                                          Icons.keyboard_arrow_right,
                                          color: redJNE,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: controller.namaPenerima,
                                  hintText: "Nama Penerima".tr,
                                  prefixIcon: const Icon(Icons.person),
                                  isRequired: true,
                                ),
                                CustomTextFormField(
                                  controller: controller.nomorTelpon,
                                  hintText: "Nomor Telepon".tr,
                                  inputType: TextInputType.number,
                                  prefixIcon: const Icon(Icons.phone),
                                  isRequired: true,
                                ),
                                CustomSearchDropdownField<Destination>(
                                  asyncItems: (String filter) => controller.getDestinationList(filter),
                                  itemBuilder: (context, e, b) {
                                    return GestureDetector(
                                      onTap: () => controller.update(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        child: Text(
                                          '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subDistrictName}; ${e.destinationCode}',
                                        ),
                                      ),
                                    );
                                  },
                                  itemAsString: (Destination e) =>
                                      '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subDistrictName}; ${e.destinationCode}',
                                  onChanged: (value) {
                                    controller.selectedDestination = value;
                                    controller.update();
                                    print(controller.selectedDestination?.id);
                                    // print(jsonEncode(value));
                                  },
                                  value: controller.selectedDestination,
                                  isRequired: controller.selectedDestination == null ? true : false,
                                  readOnly: false,
                                  hintText: controller.isLoading ? "Loading..." : "Kota Tujuan".tr,
                                  prefixIcon: const Icon(Icons.location_city),
                                  textStyle: controller.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
                                ),
                                CustomTextFormField(
                                  controller: controller.alamatLengkap,
                                  hintText: "Alamat".tr,
                                  prefixIcon: const Icon(Icons.location_city),
                                  multiLine: true,
                                  isRequired: true,
                                ),
                                controller.isOnline && controller.selectedReceiver == null
                                    ? CustomFilledButton(
                                        color: whiteColor,
                                        title: 'Simpan Data Penerima'.tr,
                                        borderColor: controller.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                                        fontColor: controller.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                                        onPressed: () => controller.formKey.currentState?.validate() == true ? controller.saveReceiver() : null,
                                      )
                                    : const SizedBox(),
                                CustomFilledButton(
                                  color: controller.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                                  title: "Selanjutnya".tr,
                                  onPressed: () => controller.formKey.currentState?.validate() == true ? controller.nextStep() : null,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
