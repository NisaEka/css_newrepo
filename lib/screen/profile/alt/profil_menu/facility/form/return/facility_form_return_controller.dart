import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FacilityFormReturnController extends BaseController {

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
  final npwpImageUrl = TextEditingController();

  bool sameWithOwner = false;

  File? pickedImage;

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;

  @override
  void onInit() {
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

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = File(image.path);
      update();
    }
  }

}