import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/facility/facility_create_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_id_card_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';

class FacilityFormInfoController extends BaseController {
  final String _facilityType = Get.arguments['facility_type'];

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final brand = TextEditingController();
  final idCardUrl = TextEditingController();
  final fullName = TextEditingController();
  final idCardNumber = TextEditingController();
  final fullAddress = TextEditingController();
  final phone = TextEditingController();
  final whatsAppPhone = TextEditingController();
  final email = TextEditingController();

  final requestData = FacilityCreateModel();

  File? pickedImage;
  String? pickedImageUrl;

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;

  bool _pickImageFailed = false;
  bool get pickImageFailed => _pickImageFailed;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getUserProfile()]);
    _checkConnectivity();
  }

  Future<void> _getUserProfile() async {
    await profil.getBasicProfil().then((result) {
      if (result.code == HttpStatus.ok) {
        var payload = result.data?.user;
        brand.setText(payload?.brand ?? '');
        fullName.setText(payload?.name ?? '');
        whatsAppPhone.setText(payload?.phone ?? '');
        email.setText(payload?.email ?? '');
      }
    });
  }

  void _checkConnectivity() {
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        _isOnline = value && (result != ConnectivityResult.none);
        if (_isOnline) {
          AppSnackBar.custom(
            message: '',
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.only(top: 195),
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            messageText: Container(
              color: successColor, // Set your desired background color here
              child: Center(
                child: Text(
                  'Online Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
            ),
          );
        } else {
          AppSnackBar.custom(
            message: '',
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.only(top: 195),
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            messageText: Container(
              color: greyDarkColor1, // Set your desired background color here
              child: Center(
                child: Text(
                  'Offline Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
            ),
          );
        }
        update();
      });
    }));
  }

  void pickImage() async {
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

  void onRefreshUploadState() {
    _pickImageFailed = false;
    update();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList.clear();

    // var response = await transaction.getDestination(keyword);
    // var models = response.payload?.toList();

    isLoading = false;
    update();

    // return models ?? List.empty();
    return [];
  }

  FacilityCreateModel submitData() {
    requestData.setBrand(brand.text);
    requestData.setName(fullName.text);
    requestData.setEmail(email.text);
    requestData.setFacilityType(_facilityType);

    final FacilityCreateIdCardModel idCard = FacilityCreateIdCardModel();
    idCard.setNumber(idCardNumber.text);
    idCard.setImageUrl(pickedImageUrl ?? "-");
    requestData.setIdCard(idCard);

    final FacilityCreateAddressModel address = FacilityCreateAddressModel();
    address.setAddress(fullAddress.text);
    address.setProvince(selectedDestination!.provinceName!);
    address.setCity(selectedDestination!.cityName!);
    address.setDistrict(selectedDestination!.districtName!);
    address.setSubDistrict(selectedDestination!.subdistrictName!);
    address.setZipCode(selectedDestination!.zipCode!);
    address.setPhone(phone.text);
    address.setHandPhone(whatsAppPhone.text);
    requestData.setAddress(address);

    return requestData;
  }
}
