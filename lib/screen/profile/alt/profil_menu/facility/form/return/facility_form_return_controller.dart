import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_return_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_tax_info_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
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

  @override
  void onInit() {
    print(facilityCreateArgs.toJson());
    npwpType.text = 'PRIBADI';
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

  onAddressSameCheck() async {
    sameWithOwner = !sameWithOwner;
    if (sameWithOwner) {
      returnAddress.text = facilityCreateArgs.address!.address;
      selectedDestination = shipperDestination;
      returnPhone.text = facilityCreateArgs.address!.phone;
      returnWhatsAppNumber.text = facilityCreateArgs.address!.handphone;
    }
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