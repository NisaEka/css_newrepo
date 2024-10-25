import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPenerimaController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final namaPenerima = TextEditingController();
  final noHP = TextEditingController();
  final kotaTujuan = TextEditingController();
  final alamat = TextEditingController();

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];

  Destination? selectedDestination;

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList = [];
    var response = await master.getDestinations(QueryParamModel(
      search: keyword.toUpperCase(),
    ));
    var models = response.data?.toList();

    isLoading = false;
    update();
    return models ?? [];
  }

  Future<void> saveReceiver() async {
    isLoading = true;
    update();
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
            receiverSubDistrict: selectedDestination?.subdistrictName,
          ))
          .then(
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: const Icon(
                  Icons.info,
                  color: whiteColor,
                ),
                message: "Data receiver telah disimpan".tr,
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

    isLoading = false;
    update();
  }
}
