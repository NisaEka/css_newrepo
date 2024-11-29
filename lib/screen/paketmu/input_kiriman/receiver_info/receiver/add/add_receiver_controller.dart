import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReceiverController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final receiverName = TextEditingController();
  final receiverPhone = TextEditingController();
  final receiverDest = TextEditingController();
  final receiverAddress = TextEditingController();

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];

  Destination? selectedDestination;

  Future<void> saveReceiver() async {
    isLoading = true;
    update();
    try {
      await master
          .postReceiver(ReceiverModel(
        name: receiverName.text,
        contact: receiverName.text,
        phone: receiverPhone.text,
        address: receiverAddress.text,
        city: selectedDestination?.cityName,
        zipCode: selectedDestination?.zipCode,
        region: selectedDestination?.provinceName,
        country: selectedDestination?.countryName,
        destinationCode: selectedDestination?.destinationCode,
        destinationDescription: selectedDestination?.cityName,
        idDestination: selectedDestination?.id.toString(),
        district: selectedDestination?.districtName,
        subDistrict: selectedDestination?.subdistrictName,
      ))
          .then((value) {
        if (value.code == 201) {
          AppSnackBar.success("Data receiver telah disimpan".tr);
          Get.close(1);
        } else {
          AppSnackBar.error(value.error[0]);
        }
      });
    } catch (e) {
      AppLogger.e('error saveReceiver $e');
    }

    isLoading = false;
    update();
  }
}
