import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPenerimaController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final namaPenerima = TextEditingController();
  final noHP = TextEditingController();
  final kotaTujuan = TextEditingController();
  final alamat = TextEditingController();

  bool isLoading = false;

  List<DestinationModel> destinationList = [];

  DestinationModel? selectedDestination;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<DestinationModel>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList = [];
    var response = await transaction.getDestination(keyword);
    var models = response.payload?.toList();

    isLoading = false;
    update();
    return models ?? [];
  }

  Future<void> saveReceiver() async {
    try {
      await transaction
          .postReceiver(ReceiverModel(
            name: namaPenerima.text,
            contact: namaPenerima.text,
            phone: noHP.text,
            address: alamat.text,
            city: selectedDestination?.cityName,
            zipCode: selectedDestination?.zipCode,
            region: selectedDestination?.provinceName,
            country: selectedDestination?.countryName,
            destinationCode: selectedDestination?.destinationCode,
            destinationDescription: selectedDestination?.cityName,
            idDestination: selectedDestination?.id.toString(),
            receiverDistrict: selectedDestination?.districtName,
            receiverSubDistrict: selectedDestination?.subDistrictName,
          ))
          .then(
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: const Icon(
                  Icons.info,
                  color: whiteColor,
                ),
                message: value.message,
                isDismissible: true,
                duration: const Duration(seconds: 3),
                backgroundColor: value.code == 200 ? successColor : errorColor,
              ),
            ),
          )
          .then((value) => Get.close(2));
    } catch (e) {
      e.printError();
    }
  }
}
