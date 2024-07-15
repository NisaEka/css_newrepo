import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_controller.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/list_penerima_screen.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/offlinebar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
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
          return Stack(
            children: [
              Scaffold(
                appBar: _appBarContent(controller),
                body: RefreshIndicator(
                  color: greyColor,
                  onRefresh: () => controller.initData(),
                  child: _bodyContent(controller, context),
                ),
              ),
              controller.isLoadSave ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }

  CustomTopBar _appBarContent(InformasiPenerimaController c) {
    return CustomTopBar(
      title: 'Input Transaksi'.tr,
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: 1,
            totalStep: c.steps.length,
            steps: c.steps,
          ),
          const SizedBox(height: 10),
          c.isOnline ? const SizedBox() : const OfflineBar(),
        ],
      ),
      action: const [
        // controller.isOnline
        //     ? const SizedBox()
        //     : Tooltip(
        //         key: controller.offlineTooltipKey,
        //         triggerMode: TooltipTriggerMode.tap,
        //         showDuration: const Duration(seconds: 3),
        //         decoration: ShapeDecoration(
        //           color: greyColor,
        //           shape: ToolTipCustomShape(usePadding: false),
        //         ),
        //         // textStyle: listTitleTextStyle.copyWith(color: whiteColor),
        //         message: 'Offline Mode',
        //         child: Container(
        //           margin: const EdgeInsets.only(right: 20),
        //           padding: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //             color: successColor,
        //             borderRadius: BorderRadius.circular(50),
        //           ),
        //           child: const Icon(
        //             Icons.cloud_off,
        //             color: whiteColor,
        //           ),
        //         ),
        //       )
      ],
    );
  }

  Widget _bodyContent(InformasiPenerimaController c, BuildContext context) {
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
                        onTap: () => Get.to(const ListPenerimaScreen())?.then(
                          (result) {
                            c.receiver = result;
                            c.update();
                            c.getSelectedReceiver();
                          },
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
                        validator: ValidationBuilder().phoneNumber().build(),
                      ),
                      CustomSearchDropdownField<Destination>(
                        asyncItems: (String filter) => c.getDestinationList(filter.isNotEmpty ? filter : c.selectedDestination?.cityName ?? ''),
                        itemBuilder: (context, e, b) {
                          return GestureDetector(
                            onTap: () => c.update(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(
                                '${e.zipCode ?? ''}; ${e.provinceName ?? ''}; ${e.cityName ?? ''}; ${e.districtName ?? ''}; ${e.subDistrictName ?? ''}; ${e.destinationCode ?? ''}'
                                    .splitMapJoin(
                                  ';',
                                  onMatch: (p0) => '; ',
                                ),
                              ),
                            ),
                          );
                        },
                        itemAsString: (Destination e) => ''
                            '${e.zipCode == null ? '' : '${e.zipCode}; '}'
                            '${e.provinceName == null ? '' : '${e.provinceName}; '}'
                            '${e.cityName == null ? '' : '${e.cityName}; '}'
                            '${e.districtName == null ? '' : '${e.districtName}; '}'
                            '${e.subDistrictName == null ? '' : '${e.subDistrictName}; '}'
                            '${e.destinationCode == null ? '' : '${e.destinationCode}'}',
                        onChanged: (value) {
                          c.selectedDestination = value;
                          c.update();
                        },
                        value: c.selectedDestination,
                        isRequired: c.selectedDestination == null ? true : false,
                        readOnly: false,
                        hintText: c.isLoading ? "Loading..." : "Kota Tujuan".tr,
                        prefixIcon: const Icon(Icons.location_city),
                        textStyle: c.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
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
                              borderColor: c.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                              fontColor: c.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                              onPressed: () => c.formKey.currentState?.validate() == true ? c.saveReceiver() : null,
                            )
                          : const SizedBox(),
                      CustomFilledButton(
                        color: c.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                        title: "Selanjutnya".tr,
                        onPressed: () => c.formKey.currentState?.validate() == true ? c.nextStep() : null,
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
  }
}
