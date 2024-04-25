import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/akun_transaksi/akun_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:css_mobile/widgets/items/tooltip_custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  action: [
                    controller.isOnline
                        ? const SizedBox()
                        : Tooltip(
                            key: controller.offlineTooltipKey,
                            triggerMode: TooltipTriggerMode.tap,
                            showDuration: const Duration(seconds: 3),
                            decoration: ShapeDecoration(
                              color: greyColor,
                              shape: ToolTipCustomShape(usePadding: false),
                            ),
                            // textStyle: listTitleTextStyle.copyWith(color: whiteColor),
                            message: 'Offline Mode',
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.cloud_off,
                                color: whiteColor,
                              ),
                            ),
                          )
                  ],
                  flexibleSpace: Column(
                    children: [
                      CustomStepper(
                        currentStep: 2,
                        totalStep: controller.steps.length,
                        steps: controller.steps,
                      ),
                      const SizedBox(height: 10),
                      // !controller.isOnline ? const SizedBox() : const OfflineBar(),
                    ],
                  ),
                ),
                body: CustomScrollView(
                  slivers: [
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
                              accountName:
                                  "${controller.account.accountName.toString()} / ${controller.account.accountType ?? controller.account.accountService}",
                              accountType: controller.account.accountService ?? '',
                              isSelected: true,
                              width: Get.width,
                              onTap: () => controller.dropship == false
                                  ? Get.to(const AkunTransaksiScreen())?.then((result) {
                                      controller.account = result;
                                      controller.update();
                                    })
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: CustomFormLabel(label: 'Services'.tr),
                          ),
                          const SizedBox(height: 10),
                          // controller.isServiceLoad
                          //     ? const Center(
                          //         child: Text('Loading services...'),
                          //       )
                          //     : const SizedBox(),
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
                              child: Shimmer(
                                isLoading: controller.isServiceLoad,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: controller.isServiceLoad
                                        ? greyColor
                                        : controller.selectedService == controller.serviceList[index]
                                            ? Theme.of(context).brightness == Brightness.light
                                                ? blueJNE
                                                : redJNE
                                            : greyLightColor3,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: controller.serviceList.isEmpty
                                      ? const SizedBox()
                                      : Text(
                                          controller.serviceList[index].serviceDisplay ?? '',
                                          style: listTitleTextStyle.copyWith(
                                              color: controller.selectedService == controller.serviceList[index] ? whiteColor : blueJNE),
                                        ),
                                ),
                              ),
                            );
                          },
                          childCount: controller.isServiceLoad ? 6 : controller.serviceList.length,
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
                                        items: [
                                          DropdownMenuItem(
                                            value: "PAKET",
                                            child: Text('Paket'.tr),
                                          ),
                                          DropdownMenuItem(
                                            value: "DOKUMEN",
                                            child: Text('Dokumen'.tr),
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
                                        validator: (value) => value?.isNotEmpty ?? false
                                            ? value!.length <= 8
                                                ? "Harus lebih dari 8 karakter".tr
                                                : null
                                            : null,
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          ThousandsSeparatorInputFormatter(),
                                        ],
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
                                        '${'Gunakan Asuransi Pengiriman'.tr} ( Rp. ${controller.isr.toInt().toCurrency()} )',
                                        style: sublistTitleTextStyle.copyWith(
                                          color: Theme.of(context).brightness == Brightness.light ? greyDarkColor2 : greyLightColor2,
                                        ),
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
                                  Container(
                                    decoration: const BoxDecoration(),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                      leading: Switch(
                                        value: controller.packingKayu,
                                        activeColor: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                                        onChanged: (bool? value) {
                                          controller.packingKayu = value!;
                                          controller.intruksiKhusus.text = value == true ? "MOHON DIPACKING KAYU" : "";
                                          controller.update();
                                        },
                                      ),
                                      title: Text("Packing Kayu".tr),
                                      // trailing: IconButton(
                                      //   onPressed: () {},
                                      //   icon: const Icon(
                                      //     Icons.info_outline,
                                      //     color: redJNE,
                                      //   ),
                                      //   tooltip: 'Hanya sebagai instruksi penggunaan packing kayu',
                                      // ),
                                      trailing: Tooltip(
                                        key: controller.tooltipkey,
                                        triggerMode: TooltipTriggerMode.tap,
                                        showDuration: const Duration(seconds: 3),
                                        decoration: ShapeDecoration(
                                          color: greyColor,
                                          shape: ToolTipCustomShape(usePadding: false),
                                        ),
                                        textStyle: listTitleTextStyle.copyWith(color: whiteColor),
                                        message: 'Hanya sebagai instruksi penggunaan packing kayu'.tr,
                                        child: const Icon(
                                          Icons.info_outline,
                                          color: redJNE,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        controller: controller.beratKiriman,
                                        hintText: "Berat Kiriman".tr,
                                        inputType: TextInputType.number,
                                        width: Get.width / 3,
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
                                        activeColor: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
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
                                                controller.hitungBerat(
                                                  controller.dimensiPanjang.text.toDouble(),
                                                  controller.dimensiLebar.text.toDouble(),
                                                  controller.dimensiTinggi.text.toDouble(),
                                                );
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
                                                controller.hitungBerat(
                                                  controller.dimensiPanjang.text.toDouble(),
                                                  controller.dimensiLebar.text.toDouble(),
                                                  controller.dimensiTinggi.text.toDouble(),
                                                );
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
                                                controller.hitungBerat(
                                                  controller.dimensiPanjang.text.toDouble(),
                                                  controller.dimensiLebar.text.toDouble(),
                                                  controller.dimensiTinggi.text.toDouble(),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  controller.isOnline
                                      ? /*controller.isCalculate
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
                                          : */
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Theme.of(context).brightness == Brightness.light ? greyDarkColor2 : greyLightColor2),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomFormLabel(label: 'Ringkasan Transaksimu'.tr),
                                              controller.isCalculate
                                                  ? Column(
                                                      children: List.generate(
                                                        2,
                                                        (index) => Shimmer(
                                                          isLoading: controller.isCalculate,
                                                          child: Container(
                                                            width: Get.width,
                                                            height: 15,
                                                            margin: const EdgeInsets.symmetric(vertical: 5),
                                                            color: greyLightColor3,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Column(
                                                      children: [
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
                                                                  Text('Harga COD'.tr),
                                                                  Text('Rp. ${controller.hargacod.toInt().toCurrency()}', style: listTitleTextStyle),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        controller.codOngkir
                                                            ? Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Fee COD Ongkir'.tr),
                                                                  Text('Rp. ${1000.toCurrency()}', style: listTitleTextStyle),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        controller.asuransi
                                                            ? Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Asuransi Pengiriman'.tr),
                                                                  Text('Rp. ${controller.isr.toInt().toCurrency()}', style: listTitleTextStyle),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Ongkos Kirim'.tr),
                                                            Text('Rp. ${controller.freightCharge.toInt().toCurrency()}', style: listTitleTextStyle),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Total Ongkos Kirim'.tr),
                                                            //gak boleh lebih dari 1jt //kalo cod ongkir true // kasih notif gak bisa di simpan transaksi // button transaksi disable
                                                            Text('Rp. ${(controller.totalOngkir).toInt().toCurrency()}', style: listTitleTextStyle),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  controller.isOnline
                                      ? CustomFilledButton(
                                          color: controller.isValidate() ? blueJNE : greyColor,
                                          title: controller.dataEdit != null ? 'Edit Resi'.tr : 'Buat Resi'.tr,
                                          onPressed: () {
                                            controller.isValidate()
                                                ? controller.dataEdit == null
                                                    ? controller.saveTransaction()
                                                    : controller.updateTransaction()
                                                : null;
                                          },
                                        )
                                      : const SizedBox(),
                                  controller.goods == null && !controller.isOnline || controller.draft != null
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
              controller.isLoading ? const LoadingDialog() : Container(),
              controller.isShowDialog
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      color: greyDarkColor2.withOpacity(0.5),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: Get.width - 50,
                          height: Get.width / 1.5,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Peringatan'.tr,
                                style: appTitleTextStyle.copyWith(color: greyDarkColor1),
                              ),
                              Icon(
                                Icons.warning,
                                color: warningColor,
                                size: Get.width / 4,
                              ),
                              Text(
                                "Total Ongkos Kirim tidak bisa lebih dari Rp.1000.000".tr,
                                style: subTitleTextStyle.copyWith(color: greyDarkColor1),
                                textAlign: TextAlign.center,
                              ),
                              CustomFilledButton(
                                color: blueJNE,
                                isTransparent: true,
                                title: 'OK',
                                onPressed: () {
                                  controller.isShowDialog = false;
                                  controller.update();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        });
  }
}
