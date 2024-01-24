import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/add/tambah_penerima_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahPenerimaScreen extends StatelessWidget {
  const TambahPenerimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TambahPenerimaController>(
        init: TambahPenerimaController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Tambah Data Penerima'.tr,
                style: appTitleTextStyle.copyWith(
                  color: blueJNE,
                ),
              ),
              leading: const CustomBackButton(),
            ),
            body: Container(
              // padding: const EdgeInsets.all(30),
              margin: EdgeInsets.all(30),
              child: ListView(
                children: [
                  CustomTextFormField(
                    controller: controller.namaPenerima,
                    hintText: "Nama Penerima".tr,
                    prefixIcon: const Icon(Icons.person),
                    isRequired: true,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
