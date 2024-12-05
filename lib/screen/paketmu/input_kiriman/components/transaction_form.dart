import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:css_mobile/widgets/items/tooltip_custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (c) {
          return SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: c.state.formKey,
                    onChanged: () {
                      c.state.formValidate =
                          c.state.formKey.currentState?.validate() ?? false;
                      c.update();
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
                              value: c.state.goodType.text,
                              readOnly: c.state.isSelectGoodsType,
                              selectedItem: c.state.goodType.text,
                              items: [
                                DropdownMenuItem(
                                  value: "PAKET",
                                  child: Text(
                                    'Paket'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: regular),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "DOKUMEN",
                                  child: Text(
                                    'Dokumen'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: regular),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                c.state.goodType.text = value!;
                                c.update();
                              },
                            ),
                            CustomTextFormField(
                              controller: c.state.noReference,
                              hintText: 'No Referensi (opsional)'.tr,
                              width: Get.width / 2.3,
                              // height: 46,
                              validator: (value) => value?.isNotEmpty ?? false
                                  ? value!.length < 8
                                      ? "Harus lebih dari 8 karakter".tr
                                      : null
                                  : null,
                            ),
                          ],
                        ),
                        CustomTextFormField(
                          controller: c.state.goodName,
                          hintText: 'Nama Barang'.tr,
                          isRequired: true,
                          validator: ValidationBuilder()
                              .minLength(3)
                              .maxLength(100)
                              .build(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextFormField(
                              key: c.state.codKey,
                              controller: c.state.goodAmount,
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
                              contentPadding: const EdgeInsets.only(
                                  top: 0, bottom: 0, left: 40, right: 10),
                              width: Get.width / 2,
                              isRequired: c.state.insurance,
                              onChanged: (value) => c.getOngkir(),
                            ),
                            CustomTextFormField(
                              controller: c.state.goodQty,
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            leading: const Icon(
                              Icons.verified_user_outlined,
                              color: redJNE,
                            ),
                            title: Text(
                              '${'Gunakan Asuransi Pengiriman'.tr} ( Rp. ${c.state.isr.toInt().toCurrency()} )',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            trailing: Checkbox(
                              checkColor: whiteColor,
                              activeColor: redJNE,
                              value: c.state.insurance,
                              onChanged: (value) {
                                c.state.insurance = value!;
                                c.getOngkir();
                                // value == false ? controller.hargaBarang.clear() : null;
                                c.state.codKey.currentState?.validate();
                                c.update();
                              },
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          controller: c.state.specialInstruction,
                          hintText: 'Instruksi Khusus (Opsional)'.tr,
                          validator: (value) => value!.isNotEmpty
                              ? value.length < 8
                                  ? 'Masukan ini harus terdiri dari minimal 8 karakter'
                                      .tr
                                  : null
                              : null,
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            leading: Switch(
                              value: c.state.woodPacking,
                              activeColor: AppConst.isLightTheme(context)
                                  ? blueJNE
                                  : redJNE,
                              onChanged: (bool? value) {
                                c.state.woodPacking = value!;
                                var temp = c.state.specialInstruction.text;
                                c.state.specialIns =
                                    c.state.specialInstruction.text;
                                c.state.specialInstruction.text = value == true
                                    ? "MOHON DIPACKING KAYU $temp"
                                    : temp.substring(21, temp.length);
                                c.update();
                              },
                            ),
                            title: Text(
                              "Packing Kayu".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: regular),
                            ),
                            // trailing: IconButton(
                            //   onPressed: () {},
                            //   icon: const Icon(
                            //     Icons.info_outline,
                            //     color: redJNE,
                            //   ),
                            //   tooltip: 'Hanya sebagai instruksi penggunaan packing kayu',
                            // ),
                            trailing: Tooltip(
                              key: c.state.tooltipkey,
                              triggerMode: TooltipTriggerMode.tap,
                              showDuration: const Duration(seconds: 3),
                              decoration: const ShapeDecoration(
                                color: greyColor,
                                shape: ToolTipCustomShape(usePadding: false),
                              ),
                              textStyle: listTitleTextStyle.copyWith(
                                  color: whiteColor),
                              message:
                                  'Hanya sebagai instruksi penggunaan packing kayu'
                                      .tr,
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
                              controller: c.state.weight,
                              hintText: "Berat Kiriman".tr,
                              inputType: TextInputType.number,
                              width: Get.width / 3,
                              isRequired: true,
                              validator: ValidationBuilder().min(1).build(),
                              suffixIcon: const SatuanFieldIcon(
                                  title: 'KG', isSuffix: true),
                              onChanged: (value) {
                                c.state.berat = value.toDouble();
                                c.getOngkir();
                                c.update();
                              },
                            ),
                            Text('Dimensi Kiriman'.tr),
                            Switch(
                              value: c.state.dimension,
                              activeColor: AppConst.isLightTheme(context)
                                  ? blueJNE
                                  : redJNE,
                              onChanged: (value) {
                                c.state.dimension = value;
                                c.state.goodLength.clear();
                                c.state.goodWidth.clear();
                                c.state.goodHeight.clear();
                                c.state.weight.text = '1';
                                c.update();
                                c.getOngkir();
                              },
                            )
                          ],
                        ),
                        c.state.dimension
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormField(
                                    controller: c.state.goodLength,
                                    hintText: 'Panjang'.tr,
                                    // hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                    suffixIcon: const SatuanFieldIcon(
                                      title: 'CM',
                                      isSuffix: true,
                                    ),
                                    readOnly: !c.state.dimension,
                                    onChanged: (value) {
                                      c.hitungBerat(
                                        c.state.goodLength.text.toDouble(),
                                        c.state.goodWidth.text.toDouble(),
                                        c.state.goodHeight.text.toDouble(),
                                      );
                                    },
                                  ),
                                  CustomTextFormField(
                                    controller: c.state.goodWidth,
                                    hintText: 'Lebar'.tr,
                                    // hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                    suffixIcon: const SatuanFieldIcon(
                                      title: 'CM',
                                      isSuffix: true,
                                    ),
                                    readOnly: !c.state.dimension,
                                    onChanged: (value) {
                                      c.hitungBerat(
                                        c.state.goodLength.text.toDouble(),
                                        c.state.goodWidth.text.toDouble(),
                                        c.state.goodHeight.text.toDouble(),
                                      );
                                    },
                                  ),
                                  CustomTextFormField(
                                    controller: c.state.goodHeight,
                                    hintText: 'Tinggi'.tr,
                                    // hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                    suffixIcon: const SatuanFieldIcon(
                                      title: 'CM',
                                      isSuffix: true,
                                    ),
                                    readOnly: !c.state.dimension,
                                    onChanged: (value) {
                                      c.hitungBerat(
                                        c.state.goodLength.text.toDouble(),
                                        c.state.goodWidth.text.toDouble(),
                                        c.state.goodHeight.text.toDouble(),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        c.state.isOnline && c.state.selectedService != null
                            ? /*controller..state.isCalculate
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
                            Column(
                                children: [
                                  (c.state.account.accountService
                                                      ?.toUpperCase() ==
                                                  'COD' ||
                                              c.state.codOngkir) &&
                                          !c.state.isCalculate &&
                                          !c.state.isServiceLoad
                                      ? CustomTextFormField(
                                          controller: c.state.codAmountText,
                                          prefixIcon: const SatuanFieldIcon(
                                            title: 'Rp',
                                            isPrefix: true,
                                          ),
                                          hintText: "Harga COD".tr,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            ThousandsSeparatorInputFormatter(),
                                          ],
                                          validator: ValidationBuilder()
                                              .min(1000)
                                              .build(),
                                          // validator: (value) =>
                                          //     ((value?.digitOnly().toInt() ?? 0) < 1000 && c.state.account.state.accountService?.toUpperCase() == 'COD')
                                          //         ? 'Harga COD Minimal 1000'.tr
                                          //         : null,
                                          inputType: TextInputType.number,
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 40,
                                              right: 10),
                                          onSaved: (value) =>
                                              c.onChangeCodAmountText(
                                                  value ?? ''),
                                        )
                                      : const SizedBox(),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppConst.isLightTheme(context)
                                              ? greyDarkColor2
                                              : greyLightColor2),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomFormLabel(
                                            label: 'Ringkasan Transaksimu'.tr),
                                        c.state.isCalculate ||
                                                c.state.isServiceLoad
                                            ? Column(
                                                children: List.generate(
                                                  5,
                                                  (index) => Shimmer(
                                                    isLoading:
                                                        c.state.isCalculate,
                                                    child: Container(
                                                      width: Get.width,
                                                      height: 15,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      color: greyLightColor3,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  c.state.account.accountService
                                                              ?.toUpperCase() ==
                                                          'COD'
                                                      // &&
                                                      //     (controller.state.account.state.accountCustType?.toUpperCase() == "990" ||
                                                      //         controller.state.account.state.accountCustType?.toUpperCase() == "992")
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('COD fee',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                            Text(
                                                                '${c.state.codfee * 100}%'
                                                                    .replaceAll(
                                                                        '.',
                                                                        ','),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  c.state.account.accountService
                                                              ?.toUpperCase() ==
                                                          'COD'
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Harga COD'.tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                            Text(
                                                                'Rp. ${c.state.codAmount.toInt().toCurrency()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  c.state.codOngkir
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'Fee COD Ongkir'
                                                                    .tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                            Text(
                                                                'Rp. ${1000.toCurrency()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  c.state.insurance
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'Asuransi Pengiriman'
                                                                    .tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                            Text(
                                                                'Rp. ${c.state.isr.toInt().toCurrency()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Ongkos Kirim'.tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium),
                                                      Text(
                                                          'Rp. ${c.state.freightCharge.toInt().toCurrency()}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Total Ongkos Kirim'
                                                              .tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium),
                                                      //gak boleh lebih dari 1jt //kalo cod ongkir true // kasih notif gak bisa di simpan transaksi // button transaksi disable
                                                      Text(
                                                          'Rp. ${(c.state.totalOngkir).toInt().toCurrency()}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium),
                                                    ],
                                                  )
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        c.state.isOnline
                            ? CustomFilledButton(
                                color: c.isValidate() ? blueJNE : greyColor,
                                title: (c.state.isEdit ?? false)
                                    ? 'Edit Resi'.tr
                                    : 'Buat Resi'.tr,
                                onPressed: () => c.onSaved(),
                              )
                            : const SizedBox(),
                        // c.state.goods == null && !c.state.isOnline ||
                        //         c.state.draft != null
                        //     ?
                        CustomFilledButton(
                          color: whiteColor,
                          borderColor:
                              c.state.formValidate ? blueJNE : greyColor,
                          fontColor: c.state.formValidate ? blueJNE : greyColor,
                          title: 'Simpan ke Draft'.tr,
                          onPressed: () {
                            c.state.formValidate ? c.saveDraft() : null;
                          },
                        )
                        // : const SizedBox(),
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
