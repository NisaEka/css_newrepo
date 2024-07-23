import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/akun_transaksi/akun_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/offlinebar.dart';
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
                appBar: _appBarContent(controller),
                body: RefreshIndicator(
                  color: greyColor,
                  onRefresh: () => controller.initData(),
                  child: _bodyContent(controller, context),
                ),
              ),
              controller.isLoading ? const LoadingDialog() : Container(),
              controller.isShowDialog ? _warningDialog(controller) : const SizedBox()
            ],
          );
        });
  }

  Widget _warningDialog(InformasiKirimaController c) {
    return Container(
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
                  c.isShowDialog = false;
                  c.update();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomTopBar _appBarContent(InformasiKirimaController c) {
    return CustomTopBar(
      title: 'Input Transaksi'.tr,
      flexibleSpace: Column(
        children: [
          c.isOnline ? const SizedBox() : const OfflineBar(),
          CustomStepper(
            currentStep: 2,
            totalStep: c.steps.length,
            steps: c.steps,
          ),
          const SizedBox(height: 10),
        ],
      ),
      action: const [
        // controller.isOnline
        //     ? const SizedBox()
        //     : Tooltip(
        //         key: controller.offlineTooltipKey,
        //         triggerMode: TooltipTriggerMode.tap,
        //         showDuration: const Duration(seconds: 3),
        //         decoration: ShapeDecoration(
        //           color: greyColor,
        //           shape: ToolTipCustomShape(usePadding: false),
        //         ),
        //         // textStyle: listTitleTextStyle.copyWith(color: whiteColor),
        //         message: 'Offline Mode',
        //         child: Container(
        //           margin: const EdgeInsets.only(right: 20),
        //           padding: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //             color: successColor,
        //             borderRadius: BorderRadius.circular(50),
        //           ),
        //           child: const Icon(
        //             Icons.cloud_off,
        //             color: whiteColor,
        //           ),
        //         ),
        //       )
      ],
    );
  }

  Widget _bodyContent(InformasiKirimaController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: redJNE, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
                child: Text(c.account.accountService ?? '', style: listTitleTextStyle.copyWith(color: whiteColor)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AccountListItem(
                  data: c.account,
                  isSelected: true,
                  width: Get.width,
                  onTap: () => c.dropship == false
                      ? Get.to(const AkunTransaksiScreen())?.then((result) {
                          c.account = result;
                          c.update();
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
                    c.selectedService = c.serviceList[index];
                    c.getOngkir();
                    c.formValidate = c.formKey.currentState?.validate() ?? false;
                    c.update();
                  },
                  child: Shimmer(
                    isLoading: c.isServiceLoad,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.isServiceLoad
                            ? greyColor
                            : c.selectedService == c.serviceList[index]
                                ? AppConst.isLightTheme(context)
                                    ? blueJNE
                                    : redJNE
                                : greyLightColor3,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: c.serviceList.isEmpty
                          ? const SizedBox()
                          : Text(
                              c.serviceList[index].serviceDisplay ?? '',
                              style: listTitleTextStyle.copyWith(color: c.selectedService == c.serviceList[index] ? whiteColor : blueJNE),
                            ),
                    ),
                  ),
                );
              },
              childCount: c.isServiceLoad ? 6 : c.serviceList.length,
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
                  key: c.formKey,
                  onChanged: () {
                    c.formValidate = c.formKey.currentState?.validate() ?? false;
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
                            value: c.jenisBarang.text,
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
                              c.jenisBarang.text = value!;
                              c.update();
                            },
                          ),
                          CustomTextFormField(
                            controller: c.noReference,
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
                        controller: c.namaBarang,
                        hintText: 'Nama Barang'.tr,
                        isRequired: true,
                        validator: ValidationBuilder().minLength(3).maxLength(100).build(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            key: c.hargaCODkey,
                            controller: c.hargaBarang,
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
                            isRequired: c.asuransi,
                            onChanged: (value) => c.hitungOngkir(),
                          ),
                          CustomTextFormField(
                            controller: c.jumlahPacking,
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
                            '${'Gunakan Asuransi Pengiriman'.tr} ( Rp. ${c.isr.toInt().toCurrency()} )',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          trailing: Checkbox(
                            checkColor: whiteColor,
                            activeColor: redJNE,
                            value: c.asuransi,
                            onChanged: (value) {
                              c.asuransi = value!;
                              c.hitungOngkir();
                              // value == false ? controller.hargaBarang.clear() : null;
                              c.hargaCODkey.currentState?.validate();
                              c.update();
                            },
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: c.intruksiKhusus,
                        hintText: 'Instruksi Khusus (Opsional)'.tr,
                        validator: (value) => value!.isNotEmpty
                            ? value.length < 8
                                ? 'Masukan ini harus terdiri dari minimal 8 karakter'.tr
                                : null
                            : null,
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                          leading: Switch(
                            value: c.packingKayu,
                            activeColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                            onChanged: (bool? value) {
                              c.packingKayu = value!;
                              var temp = c.intruksiKhusus.text;
                              c.intruksiKhusus.text = value == true ? "MOHON DIPACKING KAYU $temp" : temp.substring(21, temp.length);
                              c.update();
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
                            key: c.tooltipkey,
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
                            controller: c.beratKiriman,
                            hintText: "Berat Kiriman".tr,
                            inputType: TextInputType.number,
                            width: Get.width / 3,
                            isRequired: true,
                            validator: ValidationBuilder().min(1).build(),
                            suffixIcon: const SatuanFieldIcon(title: 'KG', isSuffix: true),
                            onChanged: (value) {
                              c.berat = value.toDouble();
                              c.getOngkir();
                              c.update();
                            },
                          ),
                          Text('Dimensi Kiriman'.tr),
                          Switch(
                            value: c.dimensi,
                            activeColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                            onChanged: (value) {
                              c.dimensi = value;
                              c.dimensiPanjang.clear();
                              c.dimensiLebar.clear();
                              c.dimensiTinggi.clear();
                              c.beratKiriman.text = '1';
                              c.update();
                              c.getOngkir();
                            },
                          )
                        ],
                      ),
                      c.dimensi
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  controller: c.dimensiPanjang,
                                  hintText: 'Panjang'.tr,
                                  // hintText: 'Cm',
                                  width: Get.width / 3.5,
                                  inputType: TextInputType.number,
                                  suffixIcon: const SatuanFieldIcon(
                                    title: 'CM',
                                    isSuffix: true,
                                  ),
                                  readOnly: !c.dimensi,
                                  onChanged: (value) {
                                    c.hitungBerat(
                                      c.dimensiPanjang.text.toDouble(),
                                      c.dimensiLebar.text.toDouble(),
                                      c.dimensiTinggi.text.toDouble(),
                                    );
                                  },
                                ),
                                CustomTextFormField(
                                  controller: c.dimensiLebar,
                                  hintText: 'Lebar'.tr,
                                  // hintText: 'Cm',
                                  width: Get.width / 3.5,
                                  inputType: TextInputType.number,
                                  suffixIcon: const SatuanFieldIcon(
                                    title: 'CM',
                                    isSuffix: true,
                                  ),
                                  readOnly: !c.dimensi,
                                  onChanged: (value) {
                                    c.hitungBerat(
                                      c.dimensiPanjang.text.toDouble(),
                                      c.dimensiLebar.text.toDouble(),
                                      c.dimensiTinggi.text.toDouble(),
                                    );
                                  },
                                ),
                                CustomTextFormField(
                                  controller: c.dimensiTinggi,
                                  hintText: 'Tinggi'.tr,
                                  // hintText: 'Cm',
                                  width: Get.width / 3.5,
                                  inputType: TextInputType.number,
                                  suffixIcon: const SatuanFieldIcon(
                                    title: 'CM',
                                    isSuffix: true,
                                  ),
                                  readOnly: !c.dimensi,
                                  onChanged: (value) {
                                    c.hitungBerat(
                                      c.dimensiPanjang.text.toDouble(),
                                      c.dimensiLebar.text.toDouble(),
                                      c.dimensiTinggi.text.toDouble(),
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),
                      c.isOnline
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
                                border: Border.all(color: AppConst.isLightTheme(context) ? greyDarkColor2 : greyLightColor2),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFormLabel(label: 'Ringkasan Transaksimu'.tr),
                                  c.isCalculate
                                      ? Column(
                                          children: List.generate(
                                            2,
                                            (index) => Shimmer(
                                              isLoading: c.isCalculate,
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
                                            c.account.accountService?.toUpperCase() == 'COD'
                                                // &&
                                                //     (controller.account.accountCustType?.toUpperCase() == "990" ||
                                                //         controller.account.accountCustType?.toUpperCase() == "992")
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text('COD fee'),
                                                      Text('${c.codfee * 100}%'.replaceAll('.', ','), style: listTitleTextStyle),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            c.account.accountService?.toUpperCase() == 'COD'
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Harga COD'.tr),
                                                      Text('Rp. ${c.hargacod.toInt().toCurrency()}', style: listTitleTextStyle),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            c.codOngkir
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Fee COD Ongkir'.tr),
                                                      Text('Rp. ${1000.toCurrency()}', style: listTitleTextStyle),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            c.asuransi
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Asuransi Pengiriman'.tr),
                                                      Text('Rp. ${c.isr.toInt().toCurrency()}', style: listTitleTextStyle),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Ongkos Kirim'.tr),
                                                Text('Rp. ${c.freightCharge.toInt().toCurrency()}', style: listTitleTextStyle),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Total Ongkos Kirim'.tr),
                                                //gak boleh lebih dari 1jt //kalo cod ongkir true // kasih notif gak bisa di simpan transaksi // button transaksi disable
                                                Text('Rp. ${(c.totalOngkir).toInt().toCurrency()}', style: listTitleTextStyle),
                                              ],
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      c.isOnline
                          ? CustomFilledButton(
                              color: c.isValidate() ? blueJNE : greyColor,
                              title: c.dataEdit != null ? 'Edit Resi'.tr : 'Buat Resi'.tr,
                              onPressed: () {
                                c.isValidate()
                                    ? c.dataEdit == null
                                        ? c.saveTransaction()
                                        : c.updateTransaction()
                                    : null;
                              },
                            )
                          : const SizedBox(),
                      c.goods == null && !c.isOnline || c.draft != null
                          ? CustomFilledButton(
                              color: whiteColor,
                              borderColor: c.formValidate ? blueJNE : greyColor,
                              fontColor: c.formValidate ? blueJNE : greyColor,
                              title: 'Simpan ke Draft'.tr,
                              onPressed: () {
                                c.formValidate ? c.saveDraft() : null;
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
    );
  }
}
