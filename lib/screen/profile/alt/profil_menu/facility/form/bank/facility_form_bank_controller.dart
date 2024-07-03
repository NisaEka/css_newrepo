import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_bank_info_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
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

  List<BankModel> _banks = [];
  List<BankModel> get banks => _banks;

  BankModel? _selectedBank;
  BankModel? get selectedBank => _selectedBank;

  String? _pickedImagePath;
  String? get pickedImagePath => _pickedImagePath;

  String _termsAndConditions = '';
  String get termsAndConditions => _termsAndConditions;

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _pickImageFailed = false;
  bool get pickImageFailed => _pickImageFailed;

  bool _postDataFailed = false;
  bool get postDataFailed => _postDataFailed;

  bool _postFileFailed = false;
  bool get postFileFailed => _postFileFailed;

  bool _showTermsAndConditions = false;
  bool get showTermsAndConditions => _showTermsAndConditions;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getBanks(),
      getTermsAndConditions()
    ]);
  }

  Future<void> getBanks() async {
    bank.getBanks().then((response) {
      if (response.code == HttpStatus.ok && response.payload!.isNotEmpty) {
        _banks.addAll(response.payload!);
        update();
      }
    });
  }

  Future<void> getTermsAndConditions() async {
    facility.getFacilityTermsAndConditions(facilityCreateArgs.getFacilityType()).then((response) {
      _termsAndConditions = response.payload ?? '';
    });
  }

  void setSelectedBank(BankModel bank) {
    _selectedBank = bank;
    update();
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageNotNull = image != null;

    if (imageNotNull) {
      final imageSizeApproved = await image.length() <= Constant.maxImageLength;

      if (imageSizeApproved) {
        _pickedImagePath = image.path;
      } else {
        _pickImageFailed = true;
      }

      update();
    }
  }

  void onRefreshPickImageState() {
    _pickImageFailed = false;
    update();
  }

  void onTermsAndConditionsCheck() {
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

  void _composeBankData() {
    final bankInfo = FacilityCreateBankInfoModel();
    bankInfo.setBankId(selectedBank!.id);
    bankInfo.setAccountNumber(accountNumber.text);
    bankInfo.setAccountName(accountName.text);
    bankInfo.setAccountImageUrl(pickedImagePath ?? "-");
    facilityCreateArgs.setBankInfo(bankInfo);
  }

  CcrfFileModel? ktpUrl;
  CcrfFileModel? npwpUrl;
  CcrfFileModel? rekeningUrl;

  Future<bool> _uploadFiles() async {
    var fileMap = {
      Constant.keyImageKtp: facilityCreateArgs.getIdCardPath(),
      Constant.keyImageNpwp: facilityCreateArgs.getTaxInfoPath(),
      Constant.keyImageRekening: _pickedImagePath ?? ''
    };

    var response = await storageRepository.postCcrfFile(fileMap);

    if (response.code == HttpStatus.ok) {
      ktpUrl =
          response.payload?.firstWhere((element) => element.fileType == Constant.keyImageKtp);
      npwpUrl =
          response.payload?.firstWhere((element) => element.fileType == Constant.keyImageNpwp);
      rekeningUrl =
          response.payload?.firstWhere((element) => element.fileType == Constant.keyImageRekening);

      facilityCreateArgs.setIdCardPath(ktpUrl?.fileUrl ?? '');
      facilityCreateArgs.setTaxInfoPath(npwpUrl?.fileUrl ?? '');
      facilityCreateArgs.setBankInfoPath(rekeningUrl?.fileUrl ?? '');

      return true;
    } else {
      return false;
    }
  }

  void submitData() async {
    _showLoadingIndicator = true;
    update();

    _composeBankData();
    final fileUploaded = await _uploadFiles();

    if (fileUploaded) {
      profil.createProfileCcrf(facilityCreateArgs).then((response) {
        if (response.code == HttpStatus.created) {
          Get.to(
            SuccessScreen(
              message:
                  'Upgrade profil kamu berhasil diajukan\n Mohon tunggu Approval dari Tim JNE Ya!'
                      .tr,
              buttonTitle: 'Selesai'.tr,
              nextAction: () => Get.delete<DashboardController>().then(
                (_) => Get.offAll(const DashboardScreen()),
              ),
            ),
          );
        } else {
          _postDataFailed = true;
          update();
        }
      });
    } else {
      _postFileFailed = true;
      update();
    }

    _showLoadingIndicator = false;
    update();
  }

  void onRefreshPostDataState() {
    _postDataFailed = false;
    _showLoadingIndicator = false;
    _postFileFailed = false;

    update();
  }

  void onShowTermsAndConditions() {
    _showTermsAndConditions = true;
    update();
  }

  void onHideTermsAndConditions() {
    _showTermsAndConditions = false;
    update();
  }

}
