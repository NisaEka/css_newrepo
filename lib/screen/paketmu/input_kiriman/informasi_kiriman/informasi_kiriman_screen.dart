import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/dialog/success_dialog.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
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
            appBar: CustomTopBar(
              screenTittle: 'Input Transaksi'.tr,
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
                      controller.isLoading ? Center(child: Text('Loading service...')) : SizedBox()
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
                            controller.hitungOngkir(controller.beratKiriman.text ?? '0', controller.selectedService?.serviceCode ?? '');
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
                            controller.hitungOngkir(controller.beratKiriman.text ?? '0', controller.selectedService?.serviceCode ?? '');
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
                                  ),
                                  CustomTextFormField(
                                    controller: controller.noReference,
                                    hintText: 'No Referensi (opsional)'.tr,
                                    inputType: TextInputType.number,
                                    width: Get.width / 2.3,
                                    height: 46,
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
                                    controller: controller.hargaBarang,
                                    hintText: 'Harga Barang'.tr,
                                    prefixIcon: const SatuanFieldIcon(
                                      title: 'Rp',
                                      isPrefix: true,
                                    ),
                                    width: Get.width / 2,
                                    // isRequired: true,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.jumlahPacking,
                                    hintText: 'Jumlah Packing'.tr,
                                    inputType: TextInputType.number,
                                    width: Get.width / 2.8,
                                    // isRequired: true,
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: greyDarkColor2),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                  leading: Icon(
                                    Icons.verified_user_outlined,
                                    color: redJNE,
                                  ),
                                  title: Text(
                                    'Gunakan Asuransi Pengiriman ( Rp. 100.000 )',
                                    style: sublistTitleTextStyle,
                                  ),
                                  trailing: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: redJNE,
                                    value: controller.asuransi,
                                    onChanged: (bool? value) {
                                      controller.asuransi = value!;
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
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(8),
                                    // border: Border(
                                    //   bottom: BorderSide(color: greyLightColor3, width: 5),
                                    //   top: BorderSide(color: greyLightColor3, width: 5),
                                    // ),
                                    ),
                                child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                    leading: Switch(
                                      value: controller.packingKayu,
                                      onChanged: (bool? value) {
                                        controller.packingKayu = value!;
                                        controller.update();
                                      },
                                    ),
                                    title: Text("Packing Kayu".tr),
                                    trailing: const Icon(
                                      Icons.info_outline,
                                      color: redJNE,
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
                                    onSubmit: (value) {
                                      controller.hitungOngkir(controller.beratKiriman.text ?? '0', controller.selectedService?.serviceCode ?? '');
                                      controller.update();
                                    },
                                  ),
                                  Text('Dimensi Kiriman'.tr),
                                  Switch(
                                    value: controller.dimensi,
                                    onChanged: (value) {
                                      controller.dimensi = value;
                                      controller.update();
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormField(
                                    controller: controller.dimensiPanjang,
                                    hintText: 'Panjang'.tr,
                                    // hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                    suffixIcon: SatuanFieldIcon(
                                      title: 'CM',
                                      isSuffix: true,
                                    ),
                                    readOnly: !controller.dimensi,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.dimensiLebar,
                                    hintText: 'Lebar'.tr,
                                    // hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                    suffixIcon: SatuanFieldIcon(
                                      title: 'CM',
                                      isSuffix: true,
                                    ),
                                    readOnly: !controller.dimensi,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.dimensiTinggi,
                                    hintText: 'Tinggi'.tr,
                                    // hintText: 'Cm',
                                    width: Get.width / 3.5,
                                    inputType: TextInputType.number,
                                    suffixIcon: SatuanFieldIcon(
                                      title: 'CM',
                                      isSuffix: true,
                                    ),
                                    readOnly: !controller.dimensi,
                                  ),
                                ],
                              ),
                              Container(
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
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total COD fee'),
                                              Text('15%', style: listTitleTextStyle),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller.account.accountService?.toUpperCase() == 'COD'
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total COD'),
                                              Text('Rp. 641.590', style: listTitleTextStyle),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller.codOngkir
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total COD Ongkir'),
                                              Text('Rp. 641.590', style: listTitleTextStyle),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller.asuransi
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total Asuransi Pengiriman'),
                                              Text('Rp. 100.000', style: listTitleTextStyle),
                                            ],
                                          )
                                        : const SizedBox(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total Ongkos Kirim'),
                                        Text('Rp. ${controller.totalOngkir}', style: listTitleTextStyle),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              CustomFilledButton(
                                color:
                                    controller.formKey.currentState?.validate() == true && controller.selectedService != null ? blueJNE : greyColor,
                                title: 'Buat Resi'.tr,
                                onPressed: () {
                                  Get.to(SucceesDialog(
                                    message: "Resi telah dibuat",
                                    buttonTitle: "Selanjutnya",
                                    nextAction: () => Get.offAll(const DashboardScreen()),
                                  ));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
