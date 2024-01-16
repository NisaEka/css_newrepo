import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/list_penerima_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPenerimaScreen extends StatelessWidget {
  const InformasiPenerimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformasiPenerimaController>(
        init: InformasiPenerimaController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              screenTittle: 'Input Transaksi'.tr,
              flexibleSpace: CustomStepper(
                currentStep: 1,
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
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(const ListPenerimaScreen()),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: greyColor, width: 2),
                                      top: BorderSide(color: greyColor, width: 2)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Lihat Data Penerima'.tr),
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: redJNE,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              controller: controller.namaPenerima,
                              hintText: "Nama Penerima".tr,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            CustomTextFormField(
                              controller: controller.nomorTelpon,
                              hintText: "Nomor Telepon".tr,
                              inputType: TextInputType.number,
                              prefixIcon: const Icon(Icons.phone),
                            ),
                            CustomDropDownFormField(
                              items: [],
                              hintText: "Kota Tujuan".tr,
                              prefixIcon: const Icon(Icons.location_city),
                              textStyle: hintTextStyle,
                            ),
                            CustomTextFormField(
                              controller: controller.alamatLengkap,
                              hintText: "Alamat".tr,
                              prefixIcon: const Icon(Icons.location_city),
                              multiLine: true,
                            ),
                            CustomFilledButton(
                              color: greyLightColor3,
                              title: 'Simpan Data Penerima'.tr,

                              fontColor: blueJNE,
                            ),
                            CustomFilledButton(
                              color: blueJNE,
                              title: "Selanjutnya".tr,

                              onPressed: () => Get.to(const InformasiKirimanScreen()),
                            )
                          ],
                        )),
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
