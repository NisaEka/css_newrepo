import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/dialog/success_dialog.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
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
            appBar: CustomTopBar(
              screenTittle: 'Input Transaksi'.tr,
              flexibleSpace: CustomStepper(currentStep: 2, totalStep: controller.steps.length, steps: controller.steps,),
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
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: controller.asuransi,
                                    onChanged: (bool? value) {
                                      controller.asuransi = value!;
                                      controller.update();
                                    },
                                  ),
                                  Text("Asuransi".tr, style: listTitleTextStyle),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: controller.packingKayu,
                                    onChanged: (bool? value) {
                                      controller.packingKayu = value!;
                                      controller.update();
                                    },
                                  ),
                                  Text("Packing Kayu".tr, style: listTitleTextStyle)
                                ],
                              ),
                              const CustomFormLabel(label: "Dimensi (Opsional)"),
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
                                      const DropdownMenuItem(
                                        child: Text('Paket'),
                                      ),
                                      const DropdownMenuItem(
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
                              controller.asuransi
                                  ? CustomTextFormField(
                                      controller: controller.hargaAsuransi,
                                      label: 'Harga Asuransi'.tr,
                                    )
                                  : SizedBox(),
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
                                onPressed: () {
                                  Get.to(SucceesDialog(
                                    message: "Resi telah dibuat",
                                    buttonTitle: "Selanjutnya",
                                    nextAction: () => Get.offAll(DashboardScreen()),
                                  ));
                                },
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
