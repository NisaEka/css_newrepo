import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/kiriman_stepper.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LacakKirimanScreen extends StatelessWidget {
  const LacakKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LacakKirimanController>(
      init: LacakKirimanController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            // title: Text('Lacak Kiriman'.tr),
            title: 'Lacak Kiriman'.tr,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSearchField(
                    hintText: 'Masukan Nomor Resimu',
                    suffixIcon: Icon(
                      Icons.qr_code_scanner,
                      color: whiteColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCodeLabel(label: 'TLJR35UH49MKKGJE'),
                      CustomLabelText(
                        title: 'Service',
                        value: 'REG',
                        valueColor: redJNE,
                        alignment: 'end',
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        title: 'Dari',
                        value: 'Kota administrasi j',
                        width: Get.width / 3,
                      ),
                      CustomLabelText(
                        title: 'Status Kiriman',
                        value: 'Delivered',
                        valueColor: redJNE,
                        width: Get.width / 3,
                        alignment: 'end',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(
                        title: 'Menuju',
                        value: 'Bandung kidul, Bandung',
                        width: Get.width / 3,
                      ),
                      CustomLabelText(
                        title: 'Perkiraan sampai tujuan',
                        value: '2 days',
                        valueColor: redJNE,
                        width: Get.width / 2,
                        alignment: 'end',
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Dari',
                  //       style: sublistTitleTextStyle.copyWith(color: greyColor),
                  //     ),
                  //     Text(
                  //       'Status Kiriman',
                  //       style: sublistTitleTextStyle.copyWith(color: greyColor),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Kota administrasi j'.toUpperCase(),
                  //       style: listTitleTextStyle.copyWith(color: greyDarkColor1),
                  //     ),
                  //     Text(
                  //       'Delivered'.toUpperCase(),
                  //       style: listTitleTextStyle.copyWith(color: redJNE),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Menuju',
                  //       style: sublistTitleTextStyle.copyWith(color: greyColor),
                  //     ),
                  //     Text(
                  //       'Perkiraan Sampai Tujuan',
                  //       style: sublistTitleTextStyle.copyWith(color: greyColor),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Bandung kidul, Bandung'.toUpperCase(),
                  //       style: listTitleTextStyle.copyWith(color: greyDarkColor1),
                  //     ),
                  //     Text(
                  //       '2 days'.toUpperCase(),
                  //       style: listTitleTextStyle.copyWith(color: redJNE),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  const CustomFormLabel(label: 'Detail Kiriman'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        title: 'Tanggal Kirim',
                        value: '16 Oktober 2023 18.40',
                        width: Get.width / 3,
                      ),
                      CustomLabelText(
                        title: 'Berat Kiriman',
                        value: '1 KG',
                        width: Get.width / 3,
                        alignment: 'end',
                      ),
                    ],
                  ),
                  CustomLabelText(
                    title: 'Deskripsi',
                    value: 'SEAGATE EXPANSION HARDDISK  EXTERNAL 1 TB - HITAM [FS]',
                    width: Get.width / 2,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        title: 'Nama Pengirim',
                        value: 'SEAGATE OFFICIAL STORE',
                        width: Get.width / 3,
                      ),
                      CustomLabelText(
                        title: 'Nama Penerima',
                        value: 'SEAGATE OFFICIAL STORE',
                        width: Get.width / 3,
                        alignment: 'end',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        title: 'Kota Pengirim',
                        value: 'kota administrasi J',
                        width: Get.width / 3,
                      ),
                      CustomLabelText(
                        title: 'Kota Penerima',
                        value: 'Bandung kidul, Bandung',
                        width: Get.width / 3,
                        alignment: 'end',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomFormLabel(label: 'Riwayat Kiriman'),
                  const Divider(),
                  KirimanStepper(
                    steps: controller.steps,
                    currentStep: 0,
                    type: StepperType.vertical,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
