import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/list_dropshipper_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_controller.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPengirimScreen extends StatefulWidget {
  const InformasiPengirimScreen({super.key});

  @override
  State<InformasiPengirimScreen> createState() => _InformasiPengirimScreenState();
}

class _InformasiPengirimScreenState extends State<InformasiPengirimScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformasiPengirimController>(
        init: InformasiPengirimController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              screenTittle: 'Input Transaksi'.tr,
              flexibleSpace: CustomStepper(
                currentStep: 0,
                totalStep: controller.steps.length,
                steps: controller.steps,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormLabel(label: 'Nomor Akun'.tr),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    AccountListItem(
                                      accountNumber: '80563320',
                                      accountName:
                                          'SETIAP HARI DIPAKAI PT / EVERPRO COD DROP OFF REG',
                                      accountType: 'NON CASHLESS',
                                    ),
                                    AccountListItem(
                                      accountNumber: '80563320',
                                      accountName:
                                          'SETIAP HARI DIPAKAI PT / EVERPRO COD DROP OFF REG',
                                      accountType: 'NON CASHLESS',
                                    ),
                                    AccountListItem(
                                      accountNumber: '80563320',
                                      accountName:
                                          'SETIAP HARI DIPAKAI PT / EVERPRO COD DROP OFF REG',
                                      accountType: 'NON CASHLESS',
                                    ),
                                    AccountListItem(
                                      accountNumber: '80563320',
                                      accountName:
                                          'SETIAP HARI DIPAKAI PT / EVERPRO COD DROP OFF REG',
                                      accountType: 'NON CASHLESS',
                                    ),
                                  ],
                                ),
                              ),
                              // CustomDropDownFormField(
                              //   items: [],
                              //   label: "Nomor Akun".tr,
                              // ),
                              CustomSwitch(
                                value: controller.dropshipper,
                                label: 'Kirim sebagai dropshipper'.tr,
                                onChange: (bool? value) {
                                  controller.dropshipper = value!;
                                  controller.update();
                                },
                              ),
                              CustomSwitch(
                                value: controller.codOgkir,
                                label: 'COD Ongkir'.tr,
                                onChange: (bool? value) {
                                  controller.codOgkir = value!;
                                  controller.update();
                                },
                              ),
                              controller.dropshipper
                                  ? GestureDetector(
                                      onTap: () => Get.to(const ListDropshipperScreen()),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(color: greyColor, width: 2),
                                              top: BorderSide(color: greyColor, width: 2)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Lihat Data Dropshipper'.tr),
                                            const Icon(
                                              Icons.keyboard_arrow_right,
                                              color: redJNE,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              CustomTextFormField(
                                controller: controller.namaPengirim,
                                hintText: "Nama Pengirim".tr,
                                readOnly: !controller.dropshipper,
                                prefixIcon: const Icon(Icons.person),
                              ),
                              CustomTextFormField(
                                controller: controller.nomorTelpon,
                                hintText: "Nomor Telepon".tr,
                                inputType: TextInputType.number,
                                readOnly: !controller.dropshipper,
                                prefixIcon: const Icon(Icons.phone),
                              ),
                              CustomDropDownFormField(
                                items: [],
                                hintText: "Kota Pengirim".tr,
                                textStyle: hintTextStyle,
                                readOnly: !controller.dropshipper,
                                prefixIcon: const Icon(Icons.location_city),
                              ),
                              CustomTextFormField(
                                controller: controller.kodePos,
                                hintText: "Kode Pos".tr,
                                readOnly: !controller.dropshipper,
                                prefixIcon: const Icon(Icons.line_style),
                              ),
                              CustomTextFormField(
                                controller: controller.alamatLengkap,
                                hintText: "Alamat".tr,
                                readOnly: !controller.dropshipper,
                                multiLine: true,
                                prefixIcon: const Icon(Icons.location_city),
                              ),
                              controller.dropshipper
                                  ? CustomFilledButton(
                                      color: greyLightColor3,
                                      title: 'Simpan Data Dropshipper'.tr,
                                      fontColor: blueJNE,
                                    )
                                  : const SizedBox(),
                              CustomFilledButton(
                                color: blueJNE,
                                title: "Selanjutnya".tr,
                                // radius: 20,
                                onPressed: () => Get.to(const InformasiPenerimaScreen()),
                              )
                            ],
                          ),
                        )
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
