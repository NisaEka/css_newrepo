import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_return_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_tax_info_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FacilityFormReturnController extends BaseController {

  FacilityCreateModel facilityCreateArgs = Get.arguments['data'];
  Destination shipperDestination = Get.arguments['destination'];

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final returnAddress = TextEditingController();
  final returnPhone = TextEditingController();
  final returnWhatsAppNumber = TextEditingController();
  final returnResponsibleName = TextEditingController();
  final npwpNumber = TextEditingController();
  final npwpType = TextEditingController();
  final npwpName = TextEditingController();
  final npwpAddress = TextEditingController();
  final npwpImageUrl = TextEditingController();

  bool sameWithOwner = false;

  File? pickedImage;
  String? pickedImageUrl;

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;

  bool _pickImageFailed = false;
  bool get pickImageFailed => _pickImageFailed;

  bool _addressSectionReadOnly = false;
  bool get addressSectionReadOnly => _addressSectionReadOnly;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  @override
  void onInit() {
    npwpType.text = 'PRIBADI';
    _checkConnectivity();
    super.onInit();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList.clear();

    var response = await transaction.getDestination(keyword);
    var models = response.payload?.toList();

    isLoading = false;
    update();

    return models ?? List.empty();
  }

  void _checkConnectivity() {
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        _isOnline = value && (result != ConnectivityResult.none);
        if (_isOnline) {
          Get.showSnackbar(
            GetSnackBar(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              margin: const EdgeInsets.only(top: 195),
              snackPosition: SnackPosition.TOP,
              messageText: Center(
                child: Text(
                  'Online Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor.withOpacity(0.7),
            ),
          );
        } else {
          Get.showSnackbar(
            GetSnackBar(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              margin: const EdgeInsets.only(top: 195),
              snackPosition: SnackPosition.TOP,
              messageText: Center(
                child: Text(
                  'Offline Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: greyDarkColor1.withOpacity(0.7),
            ),
          );
        }
        update();
      });
    }));
  }

  void onAddressSameCheck() async {
    sameWithOwner = !sameWithOwner;
    if (sameWithOwner) {
      returnAddress.text = facilityCreateArgs.address!.address;
      selectedDestination = shipperDestination;
      returnPhone.text = facilityCreateArgs.address!.phone;
      returnWhatsAppNumber.text = facilityCreateArgs.address!.handphone;
      _addressSectionReadOnly = true;
    } else {
      returnAddress.clear();
      selectedDestination = null;
      returnPhone.clear();
      returnWhatsAppNumber.clear();
      _addressSectionReadOnly = false;
    }

    update();
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageNotNull = image != null;

    if (imageNotNull) {
      final imageSizeApproved = await image.length() <= Constant.maxImageLength;

      if (imageSizeApproved) {
        pickedImageUrl = image.path;
        pickedImage = File(pickedImageUrl!);
        update();
      } else {
        _pickImageFailed = true;
        update();
      }
    }
  }

  void onRefreshPickImageState() {
    _pickImageFailed = false;
    update();
  }

  FacilityCreateModel submitData() {
    final returnAddress = FacilityCreateReturnAddress();
    returnAddress.setAddress(this.returnAddress.text);
    returnAddress.setProvince(selectedDestination!.provinceName!);
    returnAddress.setCity(selectedDestination!.cityName!);
    returnAddress.setDistrict(selectedDestination!.districtName!);
    returnAddress.setSubDistrict(selectedDestination!.subDistrictName!);
    returnAddress.setZipCode(selectedDestination!.zipCode!);
    returnAddress.setPhone(returnPhone.text);
    returnAddress.setHandPhone(returnWhatsAppNumber.text);
    returnAddress.setResponsibleName(returnResponsibleName.text);
    facilityCreateArgs.setReturnAddress(returnAddress);

    final taxInfo = FacilityCreateTaxInfoModel();
    taxInfo.setType(npwpType.text);
    taxInfo.setName(npwpName.text);
    taxInfo.setNumber(npwpNumber.text);
    taxInfo.setAddress(npwpAddress.text);
    taxInfo.setImageUrl(pickedImageUrl ?? "-");
    facilityCreateArgs.setTaxInfo(taxInfo);

    return facilityCreateArgs;
  }

}