import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
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
            backgroundColor: greyLightColor1,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: AppBar(
                toolbarHeight: 100,
                title: Text('Input Kiriman'.tr),
                flexibleSpace: Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: blueJNE,
                  ),
                  child: const CustomStepper(totalStep: 3, currentStep: 1),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Penerima'.tr,
                          style:
                              appTitleTextStyle.copyWith(color: greyDarkColor1),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        const SizedBox(height: 15),
                        Form(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: Get.width / 1.35,
                                  child: CustomTextFormField(
                                      controller: controller.namaPenerima,
                                      label: "Nama Penerima".tr),
                                ),
                                CustomFilledButton(
                                  color: infoColor,
                                  width: 50,
                                  height: 50,
                                  icon: Icons.perm_contact_cal,
                                  fontSize: 30,
                                  margin: EdgeInsets.only(top: 15, left: 10),
                                  padding: EdgeInsets.only(left: 8),
                                )
                              ],
                            ),
                            CustomTextFormField(
                              controller: controller.nomorTelpon,
                              label: "Nomor Telepon".tr,
                              inputType: TextInputType.number,
                            ),
                            CustomDropDownFormField(
                              items: [],
                              label: "Kota Tujuan".tr,
                            ),
                            CustomTextFormField(
                              controller: controller.alamatLengkap,
                              label: "Alamat".tr,
                              multiLine: true,
                            ),
                            CustomFilledButton(
                              color: redJNE,
                              title: "Selanjutnya".tr,
                              radius: 20,
                              onPressed: () =>
                                  Get.to(const InformasiKirimanScreen()),
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
