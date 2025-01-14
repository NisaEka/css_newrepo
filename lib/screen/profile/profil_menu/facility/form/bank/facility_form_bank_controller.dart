import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_bank_info_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/info/facility_form_info_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

class FacilityFormBankController extends BaseController {
  FacilityCreateModel facilityCreateArgs = Get.arguments['data'];

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final formKey = GlobalKey<FormState>();
  final accountNumber = TextEditingController();
  final accountName = TextEditingController();

  bool termsAndConditionsCheck = false;
  bool buttonEnabled = false;

  final List<BankModel> _banks = [];

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

  String? _postDataErrors = "";

  String? get postDataErrors => _postDataErrors;

  bool _postFileFailed = false;

  bool get postFileFailed => _postFileFailed;

  bool _showTermsAndConditions = false;

  bool get showTermsAndConditions => _showTermsAndConditions;

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  @override
  void onInit() {
    super.onInit();
    Future.wait([getTermsAndConditions()]);
    _checkConnectivity();
  }

  Future<void> getTermsAndConditions() async {
    facility
        .getFacilityTermsAndConditions(facilityCreateArgs.getFacilityType())
        .then((response) {
      _termsAndConditions = response.data ?? '';
    });
  }

  void _checkConnectivity() {
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        _isOnline = value && (result != ConnectivityResult.none);
        update();
      });
    }));
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
        Get.dialog(DefaultAlertDialog(
          title: 'Gagal mengambil gambar'.tr,
          subtitle:
              'Periksa kembali file gambar rekening. File gambar tidak boleh kosong atau lebih dari 2MB'
                  .tr,
          confirmButtonTitle: 'OK'.tr,
          onConfirm: () => onRefreshPickImageState(),
        ));
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
    bankInfo.setBankId(selectedBank?.bankId ?? "");
    bankInfo.setAccountNumber(accountNumber.text);
    bankInfo.setAccountName(accountName.text);
    bankInfo.setAccountImageUrl(pickedImagePath ?? "-");
    facilityCreateArgs.setBankInfo(bankInfo);
  }

  Future<bool> _uploadFiles() async {
    var fileMap = {
      Constant.keyImageKtp: facilityCreateArgs.getIdCardPath(),
      Constant.keyImageNpwp: facilityCreateArgs.getTaxInfoPath(),
      Constant.keyImageRekening: facilityCreateArgs.getBankInfoPath()
    };

    AppLogger.i(
        'facilityCreateArgs.getIdCardPath() ${facilityCreateArgs.getIdCardPath()}');
    AppLogger.i(
        'facilityCreateArgs.getTaxInfoPath() ${facilityCreateArgs.getTaxInfoPath()}');
    AppLogger.i('_pickedImagePath $_pickedImagePath');
    AppLogger.i(
        'facilityCreateArgs.getBankInfoPath() ${facilityCreateArgs.getBankInfoPath()}');

    return await storageRepository.postCcrfFile(fileMap).then((response) {
      if (response.code == HttpStatus.created) {
        FileModel? ktpUrl = response.data?.firstWhereOrNull(
            (element) => element.fileType == Constant.keyImageKtp);
        FileModel? npwpUrl = response.data?.firstWhereOrNull(
            (element) => element.fileType == Constant.keyImageNpwp);
        FileModel? rekeningUrl = response.data?.firstWhereOrNull(
            (element) => element.fileType == Constant.keyImageRekening);

        if (ktpUrl?.fileUrl != null) {
          facilityCreateArgs.setIdCardPath(ktpUrl?.fileUrl ?? '');
        }

        if (npwpUrl?.fileUrl != null) {
          facilityCreateArgs.setTaxInfoPath(npwpUrl?.fileUrl ?? '');
        }

        if (rekeningUrl?.fileUrl != null) {
          facilityCreateArgs.setBankInfoPath(rekeningUrl?.fileUrl ?? '');
        }

        return true;
      } else {
        return false;
      }
    }).onError((error, stackTrace) {
      AppLogger.i("Error upload file: ${error.toString()}");
      return false;
    });
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
            () => SuccessScreen(
              message:
                  'Upgrade profil kamu berhasil diajukan\n Mohon tunggu Approval dari Tim JNE Ya!'
                      .tr,
              thirdButtonTitle: 'Tutup'.tr,
              iconMargin: 100,
              onThirdAction: () async {
                await Get.delete<DashboardController>();
                await Get.delete<FacilityFormInfoController>();
                await Get.delete<FacilityFormReturnController>(force: true);
                await Get.delete<FacilityFormBankController>(force: true);
                Get.offAll(() => const DashboardScreen());
              },
            ),
          );
        } else {
          Get.dialog(DefaultAlertDialog(
            title: "Gagal menyimpan data".tr,
            subtitle: postDataErrors ?? "Pastikan input data sudah benar".tr,
            confirmButtonTitle: "OK".tr,
            onConfirm: () => onRefreshPostDataState(),
          ));
          _postDataErrors = response.error ?? "";
          update();
        }
      }).onError((error, stackTrace) {
        Get.dialog(DefaultAlertDialog(
          title: "Gagal menyimpan data".tr,
          subtitle: postDataErrors ?? "Pastikan input data sudah benar".tr,
          confirmButtonTitle: "OK".tr,
          onConfirm: () => onRefreshPostDataState(),
        ));
        _postDataErrors = error.toString();
        update();
      });
    } else {
      Get.dialog(DefaultAlertDialog(
        title: "Gagal menyimpan data".tr,
        subtitle: postDataErrors ?? "Pastikan input data sudah benar".tr,
        confirmButtonTitle: "OK".tr,
        onConfirm: () => onRefreshPostDataState(),
      ));
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
