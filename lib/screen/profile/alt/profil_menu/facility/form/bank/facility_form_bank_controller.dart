import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_bank_info_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FacilityFormBankController extends BaseController {

  FacilityCreateModel facilityCreateArgs = Get.arguments['data'];

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

  _composeData() {
    final bankInfo = FacilityCreateBankInfoModel();
    bankInfo.setBankId(bankName.text);
    bankInfo.setAccountNumber(accountNumber.text);
    bankInfo.setAccountName(accountName.text);
    bankInfo.setAccountImageUrl("https://storage.api.css.jne.co.id/mbckdiwjwkerjwp.png");
    facilityCreateArgs.setBankInfo(bankInfo);
  }

  submitData() async {
    _composeData();
    profil.createProfileCcrf(facilityCreateArgs).then((response) {
      if (response.code == HttpStatus.created) {
        Get.offAll(const FacilityScreen());
      } else {
        print('Failed when submit facility');
      }
    });
  }

}