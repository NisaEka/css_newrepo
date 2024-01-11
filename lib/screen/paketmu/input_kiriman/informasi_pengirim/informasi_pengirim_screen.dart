import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/custom_stepper.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_controller.dart';
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
                  child: const CustomStepper(totalStep: 3, currentStep: 0),
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
                          'Informasi Pengirim'.tr,
                          style: appTitleTextStyle.copyWith(color: greyDarkColor1),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        const SizedBox(height: 15),
                        Form(
                          child: Column(
                            children: [
                              CustomDropDownFormField(
                                items: [],
                                label: "Nomor Akun".tr,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: controller.dropshipper,
                                    onChanged: (bool? value) {
                                      controller.dropshipper = value!;
                                      controller.update();
                                    },
                                  ),
                                  Text("Kirim sebagai dropshipper".tr, style: listTitleTextStyle)
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: controller.codOgkir,
                                    onChanged: (bool? value) {
                                      controller.codOgkir = value!;
                                      controller.update();
                                    },
                                  ),
                                  Text("COD Ongkir".tr, style: listTitleTextStyle)
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.namaPengirim,
                                label: "Nama Pengirim".tr,
                                readOnly: !controller.dropshipper,
                              ),
                              CustomTextFormField(
                                controller: controller.nomorTelpon,
                                label: "Nomor Telepon".tr,
                                inputType: TextInputType.number,
                                readOnly: !controller.dropshipper,
                              ),
                              CustomDropDownFormField(
                                items: [],
                                label: "Kota Pengirim".tr,
                                readOnly: !controller.dropshipper,
                              ),
                              CustomTextFormField(
                                controller: controller.kodePos,
                                label: "Kode Pos".tr,
                                readOnly: !controller.dropshipper,
                              ),
                              CustomTextFormField(
                                controller: controller.alamatLengkap,
                                label: "Alamat".tr,
                                readOnly: !controller.dropshipper,
                                multiLine: true,

                              ),
                              CustomFilledButton(
                                color: redJNE,
                                title: "Selanjutnya".tr,
                                radius: 20,
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
