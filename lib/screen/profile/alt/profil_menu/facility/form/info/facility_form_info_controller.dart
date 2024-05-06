import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FacilityFormInfoController extends BaseController {

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

}