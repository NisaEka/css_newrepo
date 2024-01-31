import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class InformasiKirimanScreen extends StatelessWidget {
  const InformasiKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformasiKirimaController>(
        init: InformasiKirimaController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(
                  title: 'Input Transaksi'.tr,
                  flexibleSpace: CustomStepper(
                    currentStep: 2,
                    totalStep: controller.steps.length,
                    steps: controller.steps,
                  ),
                ),
                body: CustomScrollView(
                  slivers: [
                    // SliverPersistentHeader(
                    //   delegate: SliverAppBarDelegate(
                    //     minHeight: 150,
                    //     maxHeight: 32,
                    //     child: CustomTopBar(
                    //       screenTittle: 'Input Transaksi'.tr,
                    //       flexibleSpace: CustomStepper(
                    //         currentStep: 2,
                    //         totalStep: controller.steps.length,
                    //         steps: controller.steps,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(color: redJNE, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
                            child: Text(controller.account.accountService ?? '', style: listTitleTextStyle.copyWith(color: whiteColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: AccountListItem(
                              accountID: controller.account.accountId ?? '',
                              accountNumber: controller.account.accountNumber ?? '',
                              accountName: controller.account.accountName ?? '',
                              accountType: controller.account.accountService ?? '',
                              isSelected: true,
                              width: Get.width,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: CustomFormLabel(label: 'Service'.tr),
                          ),
                          const SizedBox(height: 10),
                          controller.isServiceLoad ? const Center(child: Text('Loading service...')) : const SizedBox()
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100.0,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 4.0,
                          // mainAxisExtent: 10
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedService = controller.serviceList[index];
                                controller.getOngkir();
                                controller.formValidate = controller.formKey.currentState?.validate() ?? false;
                                controller.update();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedService == controller.serviceList[index] ? blueJNE : greyLightColor3,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  controller.serviceList[index].serviceDisplay ?? '',
                                  style: listTitleTextStyle.copyWith(
                                      color: controller.selectedService == controller.serviceList[index] ? whiteColor : blueJNE),
                                ),
                              ),
                            );
                          },
                          childCount: controller.serviceList.length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: controller.formKey,
                              onChanged: () {
                                controller.formValidate = controller.formKey.currentState?.validate() ?? false;
                                controller.update();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomDropDownFormField(
                                        hintText: 'Jenis Barang'.tr,
                                        width: Get.width / 2.3,
                                        isRequired: true,
                                        value: controller.jenisBarang.text,
                                        items: const [
                                          DropdownMenuItem(
                                            value: "PAKET",
                                            child: Text('Paket'),
                                          ),
                                          DropdownMenuItem(
                                            value: "DOKUMEN",
                                            child: Text('Dokumen'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          controller.jenisBarang.text = value!;
                                          controller.update();
                                        },
                                      ),
                                      CustomTextFormField(
                                        controller: controller.noReference,
                                        hintText: 'No Referensi (opsional)'.tr,
                                        inputType: TextInputType.number,
                                        width: Get.width / 2.3,
                                        height: 46,
                                        validator: (value) {
                                          ValidationBuilder().min(8).build();
                                        },
                                      ),
                                    ],
                                  ),
                                  CustomTextFormField(
                                    controller: controller.namaBarang,
                                    hintText: 'Nama Barang'.tr,
                                    isRequired: true,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTextFormField(
                                        key: controller.hargaCODkey,
                                        controller: controller.hargaBarang,
                                        hintText: 'Harga Barang'.tr,
                                        prefixIcon: const SatuanFieldIcon(
                                          title: 'Rp',
                                          isPrefix: true,
                                        ),
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, ThousandsSeparatorInputFormatter()],
                                        inputType: TextInputType.number,
                                        contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 40, right: 10),
                                        width: Get.width / 2,
                                        isRequired: controller.asuransi,
                                        onChanged: (value) => controller.hitungOngkir(),
                                      ),
                                      CustomTextFormField(
                                        controller: controller.jumlahPacking,
                                        hintText: 'Jumlah Packing'.tr,
                                        inputType: TextInputType.number,
                                        width: Get.width / 2.8,
                                        isRequired: true,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: greyDarkColor2),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                      leading: const Icon(
                                        Icons.verified_user_outlined,
                                        color: redJNE,
                                      ),
                                      title: Text(
                                        'Gunakan Asuransi Pengiriman \n( Rp. ${controller.isr.toInt().toCurrency()} )',
                                        style: sublistTitleTextStyle,
                                      ),
                                      trailing: Checkbox(
                                        checkColor: whiteColor,
                                        activeColor: redJNE,
                                        value: controller.asuransi,
                                        onChanged: (value) {
                                          controller.asuransi = value!;
                                          controller.hitungOngkir();
                                          // value == false ? controller.hargaBarang.clear() : null;
                                          controller.hargaCODkey.currentState?.validate();
                                          controller.update();
                                        },
                                      ),
                                    ),
                                  ),

                                  CustomTextFormField(
                                    controller: controller.intruksiKhusus,
                                    hintText: 'Instruksi Khusus (Opsional)'.tr,
                                  ),
                                  // controller.asuransi
                                  //     ? CustomTextFormField(
                                  //   controller: controller.hargaAsuransi,
                                  //   hintText: 'Harga Asuransi'.tr,
                                  // )
                                  //     : const SizedBox(),
                                  Container(
                                    decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.circular(8),
                                        // border: Border(
                                        //   bottom: BorderSide(color: greyLightColor3, width: 5),
                                        //   top: BorderSide(color: greyLightColor3, width: 5),
                                        // ),
                                        ),
                                    child: ListTile(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                        leading: Switch(
                                          value: controller.packingKayu,
                                          onChanged: (bool? value) {
                                            controller.packingKayu = value!;
                                            controller.intruksiKhusus.text = value == true ? "MOHON DIPACKING KAYU" : "";
                                            controller.update();
                                          },
                                        ),
                                        title: Text("Packing Kayu".tr),
                                        trailing: Tooltip(
                                          key: controller.tooltipkey,
                                          triggerMode: TooltipTriggerMode.manual,
                                          showDuration: const Duration(seconds: 1),
                                          decoration: BoxDecoration(
                                          ),
                                          message: 'Hanya sebagai instruksi penggunaan packing kayu',

                                          child: GestureDetector(
                                            onTap: () {
                                              controller.tooltipkey.currentState?.ensureTooltipVisible().printInfo();
                                            },
                                            child: const Icon(
                                              Icons.info_outline,
                                              color: redJNE,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        controller: controller.beratKiriman,
                                        hintText: "Berat Kiriman".tr,
                                        inputType: TextInputType.number,
                                        width: Get.width / 2.5,
                                        isRequired: true,
                                        suffixIcon: const SatuanFieldIcon(title: 'KG', isSuffix: true),
                                        onChanged: (value) {
                                          controller.berat = value.toDouble();
                                          controller.getOngkir();
                                          controller.update();
                                        },
                                      ),
                                      Text('Dimensi Kiriman'.tr),
                                      Switch(
                                        value: controller.dimensi,
                                        onChanged: (value) {
                                          controller.dimensi = value;
                                          controller.dimensiPanjang.clear();
                                          controller.dimensiLebar.clear();
                                          controller.dimensiTinggi.clear();
                                          controller.beratKiriman.text = '1';
                                          controller.update();
                                          controller.getOngkir();
                                        },
                                      )
                                    ],
                                  ),
                                  controller.dimensi
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextFormField(
                                              controller: controller.dimensiPanjang,
                                              hintText: 'Panjang'.tr,
                                              // hintText: 'Cm',
                                              width: Get.width / 3.5,
                                              inputType: TextInputType.number,
                                              suffixIcon: const SatuanFieldIcon(
                                                title: 'CM',
                                                isSuffix: true,
                                              ),
                                              readOnly: !controller.dimensi,
                                              onChanged: (value) {
                                                controller.hitungBerat();
                                              },
                                            ),
                                      CustomTextFormField(
                                        controller: controller.dimensiLebar,
                                              hintText: 'Lebar'.tr,
                                              // hintText: 'Cm',
                                              width: Get.width / 3.5,
                                              inputType: TextInputType.number,
                                              suffixIcon: const SatuanFieldIcon(
                                                title: 'CM',
                                                isSuffix: true,
                                              ),
                                              readOnly: !controller.dimensi,
                                              onChanged: (value) {
                                                controller.hitungBerat();
                                              },
                                            ),
                                      CustomTextFormField(
                                        controller: controller.dimensiTinggi,
                                        hintText: 'Tinggi'.tr,
                                        // hintText: 'Cm',
                                        width: Get.width / 3.5,
                                        inputType: TextInputType.number,
                                        suffixIcon: const SatuanFieldIcon(
                                                title: 'CM',
                                                isSuffix: true,
                                              ),
                                              readOnly: !controller.dimensi,
                                              onChanged: (value) {
                                                controller.hitungBerat();
                                              },
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  controller.isCalculate
                                      ? Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: greyDarkColor2),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomFormLabel(label: 'Ringkasan Transaksimu'.tr),
                                              Text('Menghitung...'.tr),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: greyDarkColor2),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomFormLabel(label: 'Ringkasan Transaksimu'.tr),
                                              controller.account.accountService?.toUpperCase() == 'COD'
                                                  // &&
                                                  //     (controller.account.accountCustType?.toUpperCase() == "990" ||
                                                  //         controller.account.accountCustType?.toUpperCase() == "992")
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text('COD fee'),
                                                        Text('${controller.codfee * 100}%'.replaceAll('.', ','), style: listTitleTextStyle),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              controller.account.accountService?.toUpperCase() == 'COD'
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text('Harga COD'),
                                                        Text('Rp. ${controller.hargacod.toInt().toCurrency()}', style: listTitleTextStyle),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              controller.codOngkir
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text('COD Ongkir'),
                                                        Text('Rp. ${controller.freightCharge.toInt().toCurrency()}', style: listTitleTextStyle),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              controller.asuransi
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text('Asuransi Pengiriman'),
                                                        Text('Rp. ${controller.isr.toInt().toCurrency()}', style: listTitleTextStyle),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('Ongkos Kirim'),
                                                  Text('Rp. ${controller.flatRate.toInt().toCurrency()}', style: listTitleTextStyle),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('Total Ongkos Kirim'),
                                                  Text('Rp. ${(controller.totalOngkir).toInt().toCurrency()}', style: listTitleTextStyle),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                  CustomFilledButton(
                                    color: controller.formValidate && controller.selectedService != null ? blueJNE : greyColor,
                                    title: 'Buat Resi'.tr,
                                    onPressed: () {
                                      controller.formValidate && controller.selectedService != null ? controller.saveTransaction() : null;
                                    },
                                  ),

                                  /// Sementara
                                  controller.goods == null
                                      ? CustomFilledButton(
                                          color: whiteColor,
                                          borderColor: controller.formValidate ? blueJNE : greyColor,
                                          fontColor: controller.formValidate ? blueJNE : greyColor,
                                          title: 'Simpan ke Draft'.tr,
                                          onPressed: () {
                                            controller.formValidate ? controller.saveDraft() : null;
                                          },
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              controller.isLoading || controller.isCalculate || controller.isServiceLoad ? const LoadingDialog() : Container(),
            ],
          );
        });
  }
}
