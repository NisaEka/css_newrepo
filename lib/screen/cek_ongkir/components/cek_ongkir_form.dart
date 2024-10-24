import 'package:css_mobile/screen/cek_ongkir/congkir_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CekOngkirForm extends StatelessWidget {
  const CekOngkirForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CekOngkirController>(
        init: CekOngkirController(),
        builder: (c) {
          return Form(
            key: c.state.formKey,
            child: Column(
              children: [
                OriginDropdown(
                  controller: c.state.kotaPengirim,
                  label: "Origin",
                  showfromBottom: true,
                  value: c.state.selectedOrigin,
                  onChanged: (p0) {
                    print('selected origin : $p0');
                  },
                ),
                CustomTextFormField(
                  controller: c.state.kotaPengirim,
                  // items: [],
                  hintText: 'Kota Asal'.tr,
                  // textStyle: hintTextStyle,
                  readOnly: c.state.selectedOrigin != null,
                  isRequired: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  onTap: () => c.showCityList('Kota Asal'.tr),
                ),

                CustomTextFormField(
                  controller: c.state.kotaTujuan,
                  // items: [],
                  hintText: 'Kota Tujuan'.tr,
                  // textStyle: hintTextStyle,
                  readOnly: c.state.selectedDestination != null,
                  isRequired: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  onTap: () => c.showCityList('Kota Tujuan'.tr),
                ),
                CustomTextFormField(
                  controller: c.state.beratKiriman,
                  hintText: 'Berat Kiriman'.tr,
                  isRequired: true,
                  suffixIcon: const SatuanFieldIcon(
                    title: 'KG',
                    isSuffix: true,
                  ),
                  inputType: TextInputType.number,
                ),
                CustomSwitch(
                  value: c.state.dimensi,
                  label: 'Dimensi'.tr,
                  onChange: (value) {
                    c.state.dimensi = value;
                    c.update();
                  },
                ),
                c.state.dimensi
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            controller: c.state.panjang,
                            hintText: 'Panjang'.tr,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'CM',
                              isSuffix: true,
                            ),
                            width: Get.width / 3.8,
                            inputType: TextInputType.number,
                            readOnly: !c.state.dimensi,
                            onChanged: (value) => c.hitungBerat(
                              c.state.panjang.text.toDouble(),
                              c.state.lebar.text.toDouble(),
                              c.state.tinggi.text.toDouble(),
                            ),
                          ),
                          CustomTextFormField(
                            controller: c.state.lebar,
                            hintText: 'Lebar'.tr,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'CM',
                              isSuffix: true,
                            ),
                            width: Get.width / 3.8,
                            inputType: TextInputType.number,
                            readOnly: !c.state.dimensi,
                            onChanged: (value) => c.hitungBerat(
                              c.state.panjang.text.toDouble(),
                              c.state.lebar.text.toDouble(),
                              c.state.tinggi.text.toDouble(),
                            ),
                          ),
                          CustomTextFormField(
                            controller: c.state.tinggi,
                            hintText: 'Tinggi'.tr,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'CM',
                              isSuffix: true,
                            ),
                            width: Get.width / 3.8,
                            inputType: TextInputType.number,
                            readOnly: !c.state.dimensi,
                            onChanged: (value) => c.hitungBerat(
                              c.state.panjang.text.toDouble(),
                              c.state.lebar.text.toDouble(),
                              c.state.tinggi.text.toDouble(),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                CustomSwitch(
                  value: c.state.asuransi,
                  label: "Asuransi".tr,
                  onChange: (value) {
                    c.state.asuransi = value;
                    if (value == false) {
                      c.state.isr = 0;
                      c.state.estimasiHargaBarang.clear();
                      // controller.loadOngkir();
                    }
                    c.update();
                  },
                ),
                c.state.asuransi
                    ? CustomTextFormField(
                        controller: c.state.estimasiHargaBarang,
                        hintText: 'Estimasi Harga Barang'.tr,
                        isRequired: c.state.asuransi,
                        prefixIcon: const SatuanFieldIcon(
                          title: 'Rp',
                          isPrefix: true,
                        ),
                        inputType: TextInputType.number,
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
          );
        });
  }


}
