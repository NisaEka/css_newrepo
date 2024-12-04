import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/add_eclaim_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/image_preview_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/satuanfieldicon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            color: Theme.of(context).colorScheme.onSurface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomFilledButton(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: redJNE,
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
                    color: blueJNE,
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
            height: 70, // Tinggi kotak
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
                    DateTime.now().toString(),
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
                      color: Colors.orange,
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
            inputType: TextInputType.number,
          ),
          CustomTextFormField(
            controller: c.imageFile,
            // isRequired: true,
            hintText: "Pilih berkas lampiran".tr,
            readOnly: true,
            suffixIcon: GestureDetector(
              onTap: c.selectedImage != null
                  ? () {
                      c.selectedImage = null;
                      c.imageFile.clear();
                      c.update();
                    }
                  : null,
              child: SatuanFieldIcon(
                title: 'Pilih'.tr,
                width: 100,
                isSuffix: true,
              ),
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
                      onPressed: () => c
                          .addImage(ImageSource.camera)
                          .then((_) => Get.back()),
                    ),
                    CustomFilledButton(
                      color: blueJNE,
                      title: "Pilih dari galeri".tr,
                      onPressed: () => c
                          .addImage(ImageSource.gallery)
                          .then((_) => Get.back()),
                    )
                  ],
                ),
              ),
            )),
          ),
          const SizedBox(height: 10),
          // Preview Image
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (c.selectedImage != null)
                GestureDetector(
                  onTap: () {
                    Get.to(() => ImagePreviewScreen(image: c.selectedImage!));
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(c.selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => c.removeImage(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
