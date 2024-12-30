import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_id_card_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/bank/facility_form_bank_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/util/constant.dart';
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

  String? pickedImageUrl;

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;

  bool _pickImageFailed = false;

  bool get pickImageFailed => _pickImageFailed;

  set pickImageFailed(bool value) {
    _pickImageFailed = value;
    update();
  }

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getUserProfile()]);
    _checkConnectivity();
  }

  @override
  void onClose() {
    Get.delete<FacilityFormInfoController>();
    Get.delete<FacilityFormReturnController>(force: true);
    Get.delete<FacilityFormBankController>(force: true);
    super.onClose();
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
      } else {
        _pickImageFailed = true;
      }

      update();
    }
  }

  void onRefreshUploadState() {
    _pickImageFailed = false;
    update();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList.clear();

    var response =
        await master.getDestinations(QueryModel(search: keyword.toUpperCase()));
    var models = response.data?.toList();

    isLoading = false;
    update();

    return models ?? List.empty();
    // return [];
  }

  Future<String> getJlcAccount() async {
    var response = await master.getAccounts(QueryModel(where: [
      {'accountService': 'JLC'},
    ], limit: 1));
    return response.data?.first.accountNumber ?? '';
  }

  Future<FacilityCreateModel> submitData() async {
    requestData.setBrand(brand.text);
    requestData.setName(fullName.text);
    requestData.setJlcNumber(await getJlcAccount());
    requestData.setEmail(email.text);
    requestData.setFacilityType(_facilityType);

    final FacilityCreateIdCardModel idCard = FacilityCreateIdCardModel();
    idCard.setNumber(idCardNumber.text);
    idCard.setImageUrl(pickedImageUrl ?? "");
    requestData.setIdCard(idCard);

    final FacilityCreateAddressModel address = FacilityCreateAddressModel();
    address.setAddress(fullAddress.text);
    address.setCountry(selectedDestination!.countryName!);
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
