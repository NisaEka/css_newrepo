import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:css_mobile/widgets/items/ongkir_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CekOngkirScreen extends StatelessWidget {
  const CekOngkirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CekOngkirController>(
        init: CekOngkirController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: Text('Cek Ongkos Kirim'.tr),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          CustomDropDownFormField(
                            items: [],
                            hintText: 'Kota Pengirim'.tr,
                            textStyle: hintTextStyle,
                          ),
                          CustomDropDownFormField(
                            items: [],
                            hintText: 'Kota Tujuan'.tr,
                            textStyle: hintTextStyle,
                          ),
                          CustomTextFormField(
                            controller: controller.beratKiriman,
                            hintText: 'Berat Kiriman'.tr,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'KG',
                              isSuffix: true,
                            ),
                            inputType: TextInputType.number,
                          ),
                          CustomSwitch(
                            value: controller.dimensi,
                            label: 'Dimensi'.tr,
                            onChange: (value) {
                              controller.dimensi = value;
                              controller.update();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextFormField(
                                controller: controller.panjang,
                                hintText: 'Panjang'.tr,
                                suffixIcon: SatuanFieldIcon(
                                  title: 'CM',
                                  isSuffix: true,
                                ),
                                width: Get.width / 3.8,
                                inputType: TextInputType.number,
                                readOnly: !controller.dimensi,
                              ),
                              CustomTextFormField(
                                controller: controller.lebar,
                                hintText: 'Lebar'.tr,
                                suffixIcon: SatuanFieldIcon(
                                  title: 'CM',
                                  isSuffix: true,
                                ),
                                width: Get.width / 3.8,
                                inputType: TextInputType.number,
                                readOnly: !controller.dimensi,
                              ),
                              CustomTextFormField(
                                controller: controller.tinggi,
                                hintText: 'Tinggi'.tr,
                                suffixIcon: SatuanFieldIcon(
                                  title: 'CM',
                                  isSuffix: true,
                                ),
                                width: Get.width / 3.8,
                                inputType: TextInputType.number,
                                readOnly: !controller.dimensi,
                              ),
                            ],
                          ),
                          CustomSwitch(
                            value: controller.asuransi,
                            label: "Asuransi".tr,
                            onChange: (value) {
                              controller.asuransi = value;
                              controller.update();
                            },
                          ),
                          CustomTextFormField(
                            controller: controller.estimasiHargaBarang,
                            hintText: 'Estimasi Harga Barang'.tr,
                            prefixIcon: SatuanFieldIcon(
                              title: 'Rp',
                              isPrefix: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [CustomFormLabel(label: 'Layanan'.tr), CustomFormLabel(label: 'Biaya & Durasi'.tr)],
                    ),
                    Divider(),
                    OngkirListItem(
                      serviceTitle: 'REG',
                      serviceSubtitle: 'Dokumen/Paket',
                      servicePrice: '10.000',
                      serviceDuration: '3 - 4 D',
                    ),
                    OngkirListItem(
                      serviceTitle: 'YES',
                      serviceSubtitle: 'Paket',
                      servicePrice: '15.000',
                      serviceDuration: '1 - 2 D',
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomFilledButton(
              color: blueJNE,
              title: 'Cek Ongkos Kirim'.tr,
              margin: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            ),
          );
        });
  }
}
