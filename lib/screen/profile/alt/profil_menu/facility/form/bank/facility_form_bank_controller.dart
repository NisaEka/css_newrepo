import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FacilityFormBankController extends BaseController {

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final bankName = TextEditingController();
  final accountNumber = TextEditingController();
  final accountName = TextEditingController();
  final accountUrl = TextEditingController();

  File? pickedImage;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = File(image.path);
      update();
    }
  }

}