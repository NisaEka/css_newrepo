import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/reusable/bar/customstepper.dart';
import 'package:css_mobile/reusable/forms/customdropdownformfield.dart';
import 'package:css_mobile/reusable/forms/customfilledbutton.dart';
import 'package:css_mobile/reusable/forms/customformlabel.dart';
import 'package:css_mobile/reusable/forms/customtextformfield.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiKirimanScreen extends StatelessWidget {
  const InformasiKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformasiKirimaController>(
        init: InformasiKirimaController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: greyLightColor1,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: AppBar(
                toolbarHeight: 100,
                title: Text('Input Kiriman'.tr),
                flexibleSpace: Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: blueJNE,
                  ),
                  child: const CustomStepper(totalStep: 3, currentStep: 3),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Kiriman'.tr,
                          style: appTitleTextStyle.copyWith(color: greyDarkColor1),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        const SizedBox(height: 15),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDropDownFormField(items: [], label: "Service".tr),
                              CustomTextFormField(
                                controller: controller.beratKiriman,
                                label: "Berat Kiriman".tr,
                                inputType: TextInputType.number,
                                hintText: 'Kg',
                                // suffixIcon: Container(
                                //   height: 55,
                                //   width: 55,
                                //   decoration: BoxDecoration(
                                //     color: greyLightColor2,
                                //     borderRadius: BorderRadius.circular(8),
                                //     border: Border.all(color: greyDarkColor1),
                                //   ),
                                //   child: Center(child: const Text('Kg')),
                                // ),
                              ),
                              CustomFormLabel(label: "Dimensi (Opsional)"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormField(
                                    controller: controller.dimensiPanjang,
                                    label: 'Panjang'.tr,
                                    hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.dimensiLebar,
                                    label: 'Lebar'.tr,
                                    hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.dimensiTinggi,
                                    label: 'Tinggi'.tr,
                                    hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormField(
                                    controller: controller.jumlahPacking,
                                    label: 'Jumlah Packing'.tr,
                                    inputType: TextInputType.number,
                                    width: Get.width / 2.3,
                                    height: 46,
                                  ),
                                  CustomDropDownFormField(
                                    label: 'Jumlah Packing'.tr,
                                    width: Get.width / 2.3,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Paket'),
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Dokumen'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.namaBarang,
                                label: 'Nama Barang'.tr,
                              ),
                              CustomTextFormField(
                                controller: controller.noReference,
                                label: 'Nomor Referensi (Opsional)'.tr,
                              ),
                              CustomTextFormField(
                                controller: controller.intruksiKhusus,
                                label: 'Instruksi Khusus (Opsional)'.tr,
                              ),
                              CustomTextFormField(
                                controller: controller.hargaBarang,
                                label: 'Harga Barang'.tr,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormField(
                                    controller: controller.layanan,
                                    label: 'Layanan'.tr,
                                    readOnly: true,
                                    width: Get.width / 2.3,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.ongkosKirim,
                                    label: 'Ongkos Kirim'.tr,
                                    readOnly: true,
                                    width: Get.width / 2.3,
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.codFee,
                                label: 'COD Fee'.tr,
                              ),
                              CustomTextFormField(
                                controller: controller.hargaCOD,
                                label: "Harga COD Ongkir",
                              ),
                              CustomFilledButton(
                                color: redJNE,
                                title: 'Buat Resi'.tr,
                                radius: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    ;
  }
}
