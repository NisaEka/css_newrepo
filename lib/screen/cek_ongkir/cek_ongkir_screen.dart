import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:css_mobile/widgets/items/ongkir_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              // title: Text('Cek Ongkos Kirim'.tr),
              title: 'Cek Ongkos Kirim'.tr,
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
                          CustomTextFormField(
                            controller: controller.kotaPengirim,
                            // items: [],
                            hintText: 'Kota Asal'.tr,
                            // textStyle: hintTextStyle,
                            readOnly: controller.selectedOrigin != null,
                            isRequired: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            onTap: () => controller.showCityList('Kota Asal'.tr),
                          ),
                          CustomTextFormField(
                            controller: controller.kotaTujuan,
                            // items: [],
                            hintText: 'Kota Tujuan'.tr,
                            // textStyle: hintTextStyle,
                            readOnly: controller.selectedDestination != null,
                            isRequired: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            onTap: () => controller.showCityList('Kota Tujuan'.tr),
                          ),
                          CustomTextFormField(
                            controller: controller.beratKiriman,
                            hintText: 'Berat Kiriman'.tr,
                            isRequired: true,
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
                          controller.dimensi
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormField(
                                      controller: controller.panjang,
                                      hintText: 'Panjang'.tr,
                                      suffixIcon: const SatuanFieldIcon(
                                        title: 'CM',
                                        isSuffix: true,
                                      ),
                                      width: Get.width / 3.8,
                                      inputType: TextInputType.number,
                                      readOnly: !controller.dimensi,
                                      onChanged: (value) => controller.hitungBerat(
                                        controller.panjang.text.toDouble(),
                                        controller.lebar.text.toDouble(),
                                        controller.tinggi.text.toDouble(),
                                      ),
                                    ),
                                    CustomTextFormField(
                                      controller: controller.lebar,
                                      hintText: 'Lebar'.tr,
                                      suffixIcon: const SatuanFieldIcon(
                                        title: 'CM',
                                        isSuffix: true,
                                      ),
                                      width: Get.width / 3.8,
                                      inputType: TextInputType.number,
                                      readOnly: !controller.dimensi,
                                      onChanged: (value) => controller.hitungBerat(
                                        controller.panjang.text.toDouble(),
                                        controller.lebar.text.toDouble(),
                                        controller.tinggi.text.toDouble(),
                                      ),
                                    ),
                                    CustomTextFormField(
                                      controller: controller.tinggi,
                                      hintText: 'Tinggi'.tr,
                                      suffixIcon: const SatuanFieldIcon(
                                        title: 'CM',
                                        isSuffix: true,
                                      ),
                                      width: Get.width / 3.8,
                                      inputType: TextInputType.number,
                                      readOnly: !controller.dimensi,
                                      onChanged: (value) => controller.hitungBerat(
                                        controller.panjang.text.toDouble(),
                                        controller.lebar.text.toDouble(),
                                        controller.tinggi.text.toDouble(),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          CustomSwitch(
                            value: controller.asuransi,
                            label: "Asuransi".tr,
                            onChange: (value) {
                              controller.asuransi = value;
                              if (value == false) {
                                controller.isr = 0;
                                controller.estimasiHargaBarang.clear();
                                // controller.loadOngkir();
                              }
                              controller.update();
                            },
                          ),
                          controller.asuransi
                              ? CustomTextFormField(
                                  controller: controller.estimasiHargaBarang,
                                  hintText: 'Estimasi Harga Barang'.tr,
                                  isRequired: controller.asuransi,
                                  prefixIcon: const SatuanFieldIcon(
                                    title: 'Rp',
                                    isPrefix: true,
                                  ),
                                  contentPadding: const EdgeInsets.only(left: 40),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                  // onChanged: (value) => controller.hitungAsuransi(),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomFormLabel(label: 'Layanan'.tr),
                        CustomFormLabel(label: 'Biaya & Durasi'.tr),
                      ],
                    ),
                    const Divider(),
                    controller.isLoading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                          )
                        : Column(
                            children: controller.ongkirList
                                .map(
                                  (e) => OngkirListItem(
                                    serviceTitle: e.serviceDisplay.toString(),
                                    serviceSubtitle: e.goodsType.toString(),
                                    servicePrice: (e.price!.toInt() + controller.isr).toInt().toCurrency().toString(),
                                    serviceDuration: '${e.etdFrom ?? ''} - ${e.etdThru ?? ''} ${e.times ?? ''}',
                                  ),
                                )
                                .toList(),
                          )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomFilledButton(
              color: blueJNE,
              title: 'Cek Ongkos Kirim'.tr,
              margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              onPressed: () {
                if (controller.formKey.currentState!.validate() == true) {
                  controller.loadOngkir();
                }
              },
            ),
          );
        });
  }
}
