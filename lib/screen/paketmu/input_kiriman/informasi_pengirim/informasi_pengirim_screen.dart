import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/list_dropshipper_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_controller.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
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
                                child: controller.isLoading
                                    ? const Text('Loading data...')
                                    : Row(
                                        children: controller.accountList
                                            .mapIndexed(
                                              (i, e) => AccountListItem(
                                                accountID: e.accountId.toString(),
                                                accountNumber: e.accountNumber.toString(),
                                                accountName: e.accountName.toString(),
                                                accountType: e.accountService.toString(),
                                                // isSelected: e.isSelected ?? false,
                                                isSelected: controller.selectedAccount == e ? true : false,
                                                onTap: () {
                                                  controller.selectedAccount = e;
                                                  controller.getOriginList(e.accountId.toString());
                                                  controller.update();
                                                },
                                              ),
                                            )
                                            .toList(),
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
                                  if (value == true) {
                                    controller.namaPengirim.text = '';
                                    controller.nomorTelpon.text = '';
                                    controller.kotaPengirim.text = '';
                                    controller.kodePos.text = '';
                                    controller.alamatLengkap.text = '';
                                  } else {
                                    controller.namaPengirim.text = controller.senderOrigin?.name ?? '';
                                    controller.nomorTelpon.text = controller.senderOrigin?.phone ?? '';
                                    controller.kotaPengirim.text = controller.senderOrigin?.city ?? '';
                                    controller.kodePos.text = controller.senderOrigin?.zipCode ?? '';
                                    controller.alamatLengkap.text = controller.senderOrigin?.address ?? '';
                                  }

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
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: greyColor, width: 2), top: BorderSide(color: greyColor, width: 2)),
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
                                items: controller.originList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.originName.toString()),
                                      ),
                                    )
                                    .toList(),
                                hintText: controller.isLoadOrigin ? "Loading..." : "Kota Pengirim".tr,
                                selectedItem: controller.kotaPengirim.text,
                                textStyle: controller.selectedOrigin == null ? hintTextStyle : subTitleTextStyle,
                                readOnly: !controller.dropshipper,
                                prefixIcon: const Icon(Icons.location_city),
                                onChanged: (value) {
                                  controller.kotaPengirim.text = value?.originName ?? '';
                                  controller.selectedOrigin = value;
                                  controller.update();
                                },
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
