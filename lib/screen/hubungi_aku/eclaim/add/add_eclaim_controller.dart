import 'dart:async';
import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEclaimController extends BaseController {
  final String? awb = Get.arguments?['awb'];

  final formKey = GlobalKey<FormState>();
  final category = TextEditingController();
  final nominalPengajuan = TextEditingController();
  final description = TextEditingController();
  final imageFile = TextEditingController();
  final searchCategory = TextEditingController();
  final int maxImages = 1;
  File? selectedFile;
  String? selectedFileName;
  String? fileExtension;
  int? fileSize;

  bool priority = false;
  bool isLoading = false;
  File? selectedImage;
  int? imageSize;
  var maxImageSize = 2 * 1048576;
  final int maxFileSize = 5 * 1048576;

  List<String> manualCategories = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      await eclaims.getEclaimStatus().then((value) {
        manualCategories.addAll(value.data ?? []);
        update();
      });
    } catch (e) {
      AppLogger.e('error initData ajukan E-Claim $e');
    }

    isLoading = false;
    update();
  }

  // Send form add eclaim
  Future<void> sendReport() async {
    isLoading = true;
    update();
    try {
      await eclaims
          .postEclaimImage(selectedImage ?? File(''))
          .then((response) async {
        if (response.code == 201) {
          await eclaims
              .postEclaim(EclaimModel(
            awb: awb,
            kategori: category.text,
            isipesan: description.text,
            valueclaim: nominalPengajuan.text,
            fileClaim: response.data?.first.fileUrl,
          ))
              .then((value) {
            switch (value.code) {
              case 201:
                Get.to(() => SuccessScreen(
                      message:
                          'Laporanmu berhasil dibuat dan akan diproses lebih lanjut'
                              .tr,
                      thirdButtonTitle: 'OK'.tr,
                      onThirdAction: () => Get.close(2),
                    ));
                break;
              case 404:
                AppSnackBar.warning('Nomor Resi Tidak Terdaftar'.tr);
                break;
              case 409:
                AppSnackBar.warning('Tiket Sudah Terdaftar'.tr);
                break;
              default:
                AppSnackBar.error('Bad Request'.tr);
                break;
            }
          });
        }
      });
    } catch (e, i) {
      AppLogger.e('error sendReport $e');
      AppLogger.e('error sendReport $i');
    }
    isLoading = false;
    update();
  }

  void showManualCategoryList() {
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kategori".tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: manualCategories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        manualCategories[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        category.text = manualCategories[index];
                        update();
                        Get.back();
                      },
                    ),
                    const Divider(height: 1, color: Colors.grey),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedImage = File(result.files.single.path!);
      imageFile.text = selectedImage?.path ?? '';
      AppLogger.i(selectedImage?.lengthSync().toString() ?? '');
      update();
    }
  }

  void removeFile() {
    selectedImage = null;
    imageFile.text = '';
    update();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
