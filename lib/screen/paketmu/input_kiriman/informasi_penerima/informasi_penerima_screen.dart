import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/delivery/get_destination_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_controller.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/list_penerima_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
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
              screenTittle: 'Input Transaksi'.tr,
              flexibleSpace: CustomStepper(
                currentStep: 1,
                totalStep: controller.steps.length,
                steps: controller.steps,
              ),
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
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(const ListPenerimaScreen()),
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
                                ),
                                CustomTextFormField(
                                  controller: controller.nomorTelpon,
                                  hintText: "Nomor Telepon".tr,
                                  inputType: TextInputType.number,
                                  prefixIcon: const Icon(Icons.phone),
                                ),
                                CustomSearchDropdownField<DestinationModel>(
                                  asyncItems: (String filter) => controller.getDestinationList(filter),
                                  itemBuilder: (context, e, b) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                      child: Text(
                                        '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subDistrictName}; ${e.tariffCode}',
                                      ),
                                    );
                                  },
                                  itemAsString: (DestinationModel e) =>
                                  '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subDistrictName}; ${e.tariffCode}',
                                  onChanged: (value) {
                                    controller.selectedDestination = value;
                                    controller.update();
                                    // print(jsonEncode(value));
                                  },
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
                                ),
                                CustomFilledButton(
                                  color: greyLightColor3,
                                  title: 'Simpan Data Penerima'.tr,
                                  fontColor: blueJNE,
                                ),
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
