import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_id_card_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = File(image.path);
      update();
    }
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

  FacilityCreateModel submitData() {
    requestData.setBrand(brand.text);
    requestData.setName(fullName.text);
    requestData.setEmail(email.text);
    requestData.setFacilityType(_facilityType);

    final FacilityCreateIdCardModel idCard = FacilityCreateIdCardModel();
    idCard.setNumber(idCardNumber.text);
    idCard.setImageUrl("https://storage.api.css.jne.co.id/mbckdiwjwkerjwp.png");
    requestData.setIdCard(idCard);

    final FacilityCreateAddressModel address = FacilityCreateAddressModel();
    address.setAddress(fullAddress.text);
    address.setProvince(selectedDestination!.provinceName!);
    address.setCity(selectedDestination!.cityName!);
    address.setDistrict(selectedDestination!.districtName!);
    address.setSubDistrict(selectedDestination!.subDistrictName!);
    address.setZipCode(selectedDestination!.zipCode!);
    address.setPhone(phone.text);
    address.setHandPhone(whatsAppPhone.text);
    requestData.setAddress(address);

    return requestData;
  }

}