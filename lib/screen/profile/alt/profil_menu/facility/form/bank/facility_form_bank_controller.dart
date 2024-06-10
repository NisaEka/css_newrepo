import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_bank_info_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
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

  final accountNumber = TextEditingController();
  final accountName = TextEditingController();

  bool termsAndConditionsCheck = false;
  bool buttonEnabled = false;

  File? pickedImage;
  String? pickedImageUrl;

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  final List<BankModel> banks = [];
  BankModel? selectedBank;

  @override
  void onInit() {
    super.onInit();
    Future.wait([getBanks()]);
  }

  Future<void> getBanks() async {
    bank.getBanks().then((response) {
      if (response.code == HttpStatus.ok &&
          response.payload!.isNotEmpty
      ) {
        banks.addAll(response.payload!);
        update();
      }
    });
  }

  setSelectedBank(BankModel bank) {
    selectedBank = bank;
    update();
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = File(image.path);
      update();
      sendImageToServer();
    }
  }

  sendImageToServer() async {
    if (pickedImage != null) {
      storageRepository.postStorage(pickedImage!)
          .then((storage) {
        pickedImageUrl = storage.payload?.fileAbsolutePath;
      });
    }
  }

  onTermsAndConditionsCheck() {
    termsAndConditionsCheck = !termsAndConditionsCheck;
    if (termsAndConditionsCheck) {
      buttonEnabled = true;
      update();
      facilityCreateArgs.setTermsAndConditions('Y');
    } else {
      buttonEnabled = false;
      update();
      facilityCreateArgs.setTermsAndConditions('');
    }
  }

  _composeData() {
    final bankInfo = FacilityCreateBankInfoModel();
    bankInfo.setBankId(selectedBank!.id);
    bankInfo.setAccountNumber(accountNumber.text);
    bankInfo.setAccountName(accountName.text);
    bankInfo.setAccountImageUrl(pickedImageUrl ?? "-");
    facilityCreateArgs.setBankInfo(bankInfo);
  }

  submitData() async {
    _showLoadingIndicator = true;
    update();
    _composeData();
    profil.createProfileCcrf(facilityCreateArgs).then((response) {
      if (response.code == HttpStatus.created) {
        Get.to(
          SuccessScreen(
            message: 'Upgrade profil kamu berhasil diajukan\n Mohon tunggu Approval dari Tim JNE Ya!'.tr,
            buttonTitle: 'Selesai'.tr,
            nextAction: () => Get.offAll(
                const DashboardScreen()
            ),
          ),
        );
      } else {
      }
    });
    _showLoadingIndicator = false;
    update();
  }

}