import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/input/input_laporanku_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputLaporankuScreen extends StatelessWidget {
  const InputLaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputLaporankuController>(
        init: InputLaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Buat Laporan".tr,
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(InputLaporankuController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
      child: Form(
        key: c.formKey,
        child: ListView(
          children: [
            CustomTextFormField(
              controller: c.noResi,
              hintText: "No Resi".tr,
              isRequired: true,
            ),
            CustomTextFormField(
              controller: c.category,
              readOnly: true,
              hintText: "Kategori".tr,
              isRequired: true,
              onTap: () {},
              suffixIcon: const Icon(Icons.keyboard_arrow_right),
            ),
            CustomTextFormField(
              controller: c.subject,
              hintText: "Subjek".tr,
              isRequired: true,
            ),
            CustomTextFormField(
              controller: c.message,
              hintText: "Isi Pesan".tr,
              isRequired: true,
              multiLine: true,
            ),
            CustomTextFormField(
              controller: c.image,
              hintText: "Pilih Gambar".tr,
              readOnly: true,
              suffixIcon: const Icon(Icons.camera_alt_outlined, color: greyColor,),
              onTap: () {},
            ),
            Row(
              children: [
                const Icon(
                  Icons.info,
                  color: greyColor,
                ),
                const SizedBox(width: 10),
                Text(
                  "Maksimal ukuran 2 MB".tr,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            CustomCheckbox(
              value: c.priority,
              label: "Prioritas".tr,
              onChanged: (value) {
                c.priority = value!;
                c.update();
              },
            ),
            CustomFilledButton(
              color: blueJNE,
              title: "Kirim".tr,
            )
          ],
        ),
      ),
    );
  }
}
