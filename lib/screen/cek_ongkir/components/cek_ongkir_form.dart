import 'package:css_mobile/screen/cek_ongkir/congkir_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/destination_external_dropdown.dart';
import 'package:css_mobile/widgets/forms/origin_external_dropdown.dart';
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
                OriginExternalDropdown(
                  controller: c.state.kotaPengirim,
                  isRequired: true,
                  label: 'Kota Pengirim'.tr,
                  showfromBottom: true,
                  value: c.state.selectedOrigin,
                  onChanged: (selected) => c.state.selectedOrigin = selected,
                ),
                DestinationExternalDropdown(
                  controller: c.state.kotaTujuan,
                  isRequired: true,
                  label: 'Kota Tujuan'.tr,
                  showfromBottom: true,
                  value: c.state.selectedDestination,
                  onChanged: (selected) =>
                      c.state.selectedDestination = selected,
                ),
                CustomTextFormField(
                  controller: c.state.beratKiriman,
                  hintText: 'Berat Kiriman'.tr,
                  isRequired: !c.state.dimensi,
                  suffixIcon: const SatuanFieldIcon(
                    title: 'KG',
                    isSuffix: true,
                  ),
                  inputType: TextInputType.number,
                  readOnly: c.state.dimensi,
                ),
                CustomSwitch(
                  value: c.state.dimensi,
                  label: 'Dimensi'.tr,
                  onChange: (value) {
                    c.state.dimensi = value;
                    c.state.beratKiriman.clear();
                    c.state.panjang.clear();
                    c.state.lebar.clear();
                    c.state.tinggi.clear();
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
                            isRequired: c.state.dimensi,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'CM',
                              isSuffix: true,
                            ),
                            width: Get.width / 3.8,
                            inputType: TextInputType.number,
                            readOnly: !c.state.dimensi,
                            onChanged: (value) => {
                              c.state.panjang.text.toDouble(),
                            },
                          ),
                          CustomTextFormField(
                            controller: c.state.lebar,
                            hintText: 'Lebar'.tr,
                            isRequired: c.state.dimensi,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'CM',
                              isSuffix: true,
                            ),
                            width: Get.width / 3.8,
                            inputType: TextInputType.number,
                            readOnly: !c.state.dimensi,
                            onChanged: (value) => {
                              c.state.lebar.text.toDouble(),
                            },
                          ),
                          CustomTextFormField(
                            controller: c.state.tinggi,
                            hintText: 'Tinggi'.tr,
                            isRequired: c.state.dimensi,
                            suffixIcon: const SatuanFieldIcon(
                              title: 'CM',
                              isSuffix: true,
                            ),
                            width: Get.width / 3.8,
                            inputType: TextInputType.number,
                            readOnly: !c.state.dimensi,
                            onChanged: (value) => {
                              c.state.tinggi.text.toDouble(),
                            },
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
                      )
                    : const SizedBox(),
              ],
            ),
          );
        });
  }
}
