import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:flutter/material.dart';

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
}
