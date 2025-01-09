import 'dart:io';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/add_eclaim_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/image_preview_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/thousand_separator_input_formater.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddEclaimScreen extends StatelessWidget {
  const AddEclaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEclaimController>(
      init: AddEclaimController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            title: "E-Claim".tr,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          body: Stack(
            children: [
              _bodyContent(controller, context),
              controller.isLoading ? const LoadingDialog() : const SizedBox(),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            color: AppConst.isLightTheme(context) ? whiteColor : Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomFilledButton(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: errorColor,
                    title: 'Batal'.tr,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomFilledButton(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: primaryColor(context),
                    title: 'Ajukan'.tr,
                    onPressed: () =>
                        controller.formKey.currentState?.validate() == true
                            ? controller.sendReport()
                            : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _bodyContent(AddEclaimController c, BuildContext context) {
  bool isImageFile(File file) {
    String extension = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif'].contains(extension);
  }

  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
    child: Form(
      key: c.formKey,
      onChanged: () => c.update(),
      child: ListView(
        children: [
          CustomFormLabel(label: 'Ajukan Claim'.tr),
          const SizedBox(height: 10),
          Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // Date
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    DateTime.now().toString().toLongDateTimeFormat(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                // AWB
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    decoration: BoxDecoration(
                      color: primaryColor(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      c.awb ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: c.category,
            readOnly: true,
            hintText: "Kategori".tr,
            isRequired: true,
            onTap: () => c.showManualCategoryList(),
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
          ),
          CustomTextFormField(
            controller: c.description,
            hintText: "Deskripsi".tr,
            isRequired: true,
            multiLine: true,
            onChanged: (value) => c.formKey.currentState?.validate(),
          ),
          CustomTextFormField(
            controller: c.nominalPengajuan,
            hintText: 'Nominal Pengajuan'.tr,
            contentPadding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 40, right: 10),
            isRequired: true,
            prefixIcon: const SatuanFieldIcon(
              title: 'RP',
              isPrefix: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ThousandsSeparatorInputFormatter(),
            ],
            inputType: TextInputType.number,
          ),
          CustomTextFormField(
            controller: c.imageFile,
            hintText: "Pilih berkas lampiran".tr,
            readOnly: true,
            suffixIcon: SatuanFieldIcon(
              title: 'Pilih'.tr,
              width: 100,
              isSuffix: true,
            ),
            validator: (value) {
              if ((c.selectedImage?.lengthSync() ?? 0) >= c.maxImageSize) {
                return "Ukuran file terlalu besar".tr;
              }
              return null;
            },
            onTap: () => c.addFile(),
          ),
          const SizedBox(height: 10),
          // Preview lampiran
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (c.selectedImage != null)
                GestureDetector(
                  onTap: isImageFile(c.selectedImage!)
                      ? () {
                          Get.to(() =>
                              ImagePreviewScreen(image: c.selectedImage!));
                        }
                      : null,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: fileIcon(c.selectedImage!),
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          icon:
                              Icon(Icons.close, color: secondaryColor(context)),
                          onPressed: () => c.removeFile(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

Widget fileIcon(File file) {
  String extension = file.path.split('.').last.toLowerCase();

  switch (extension) {
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
      return Image.file(file, width: 100, height: 100, fit: BoxFit.cover);
    case 'pdf':
      return const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red);
    case 'doc':
    case 'docx':
      return const Icon(Icons.description, size: 100, color: Colors.blue);
    case 'xls':
    case 'xlsx':
      return const Icon(Icons.table_chart, size: 100, color: Colors.green);
    default:
      return const Icon(Icons.insert_drive_file, size: 100, color: Colors.grey);
  }
}
