import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/npwp_separator_input_formater.dart';
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
              title: 'Cek Ongkos Kirim'.tr,
            ),
            body: _bodyContent(controller, context),
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

  Widget _bodyContent(CekOngkirController c, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Form(
              key: c.formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: c.kotaPengirim,
                    // items: [],
                    hintText: 'Kota Asal'.tr,
                    // textStyle: hintTextStyle,
                    readOnly: c.selectedOrigin != null,
                    isRequired: true,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    onTap: () => c.showCityList('Kota Asal'.tr),
                  ),
                  CustomTextFormField(
                    controller: c.kotaTujuan,
                    // items: [],
                    hintText: 'Kota Tujuan'.tr,
                    // textStyle: hintTextStyle,
                    readOnly: c.selectedDestination != null,
                    isRequired: true,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    onTap: () => c.showCityList('Kota Tujuan'.tr),
                  ),
                  CustomTextFormField(
                    controller: c.beratKiriman,
                    hintText: 'Berat Kiriman'.tr,
                    isRequired: true,
                    suffixIcon: const SatuanFieldIcon(
                      title: 'KG',
                      isSuffix: true,
                    ),
                    inputType: TextInputType.number,
                  ),
                  CustomSwitch(
                    value: c.dimensi,
                    label: 'Dimensi'.tr,
                    onChange: (value) {
                      c.dimensi = value;
                      c.update();
                    },
                  ),
                  c.dimensi
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextFormField(
                              controller: c.panjang,
                              hintText: 'Panjang'.tr,
                              suffixIcon: const SatuanFieldIcon(
                                title: 'CM',
                                isSuffix: true,
                              ),
                              width: Get.width / 3.8,
                              inputType: TextInputType.number,
                              readOnly: !c.dimensi,
                              onChanged: (value) => c.hitungBerat(
                                c.panjang.text.toDouble(),
                                c.lebar.text.toDouble(),
                                c.tinggi.text.toDouble(),
                              ),
                            ),
                            CustomTextFormField(
                              controller: c.lebar,
                              hintText: 'Lebar'.tr,
                              suffixIcon: const SatuanFieldIcon(
                                title: 'CM',
                                isSuffix: true,
                              ),
                              width: Get.width / 3.8,
                              inputType: TextInputType.number,
                              readOnly: !c.dimensi,
                              onChanged: (value) => c.hitungBerat(
                                c.panjang.text.toDouble(),
                                c.lebar.text.toDouble(),
                                c.tinggi.text.toDouble(),
                              ),
                            ),
                            CustomTextFormField(
                              controller: c.tinggi,
                              hintText: 'Tinggi'.tr,
                              suffixIcon: const SatuanFieldIcon(
                                title: 'CM',
                                isSuffix: true,
                              ),
                              width: Get.width / 3.8,
                              inputType: TextInputType.number,
                              readOnly: !c.dimensi,
                              onChanged: (value) => c.hitungBerat(
                                c.panjang.text.toDouble(),
                                c.lebar.text.toDouble(),
                                c.tinggi.text.toDouble(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  CustomSwitch(
                    value: c.asuransi,
                    label: "Asuransi".tr,
                    onChange: (value) {
                      c.asuransi = value;
                      if (value == false) {
                        c.isr = 0;
                        c.estimasiHargaBarang.clear();
                        // controller.loadOngkir();
                      }
                      c.update();
                    },
                  ),
                  c.asuransi
                      ? CustomTextFormField(
                          controller: c.estimasiHargaBarang,
                          hintText: 'Estimasi Harga Barang'.tr,
                          isRequired: c.asuransi,
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
            c.isLoading
                ? CircularProgressIndicator(
                    color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                  )
                : Column(
                    children: c.ongkirList
                        .map(
                          (e) => OngkirListItem(
                            serviceTitle: e.serviceDisplay.toString(),
                            serviceSubtitle: e.goodsType.toString(),
                            servicePrice: (e.price!.toInt() + c.isr).toInt().toCurrency().toString(),
                            serviceDuration: '${e.etdFrom ?? ''} - ${e.etdThru ?? ''} ${e.times ?? ''}',
                          ),
                        )
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
