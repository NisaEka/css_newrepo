import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/input/input_laporanku_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
              onTap: () => c.showCategoryList(),
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
              controller: c.imageFile,
              hintText: "Bukti Pendukung".tr,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.camera_alt_outlined,
                color: greyColor,
              ),
              validator: (value) {
                if ((c.imageSize ?? 0) >= c.maxImageSize) {
                  return "Ukuran file terlalu besar".tr;
                }
                return null;
              },
              onTap: () => Get.dialog(StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  scrollable: false,
                  title: Text(
                    "Upload Gambar".tr,
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.center,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text("Upload Gambar".tr),
                      CustomFilledButton(
                        color: blueJNE,
                        title: "Ambil Gambar".tr,
                        isTransparent: true,
                        onPressed: () => c.getSinglePhoto(ImageSource.camera),
                      ),
                      CustomFilledButton(
                        color: blueJNE,
                        title: "Pilih dari galeri".tr,
                        onPressed: () => c.getSinglePhoto(ImageSource.gallery),
                      )
                    ],
                  ),
                ),
              )),
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
              color: c.formKey.currentState?.validate() == true ? blueJNE : greyColor,
              title: "Kirim".tr,
              onPressed: () => c.formKey.currentState?.validate() == true ? c.sendReport : null,
            )
          ],
        ),
      ),
    );
  }
}
