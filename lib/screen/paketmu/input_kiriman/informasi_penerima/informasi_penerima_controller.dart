import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/delivery/get_destination_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPenerimaController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final namaPenerima = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaTujuan = TextEditingController();
  final alamatLengkap = TextEditingController();

  bool isLoading = false;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<DestinationModel> destinationList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([getDestinationList(''), getDestList('')]);
  }

  Future<void> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList = [];
    try {
      await delivery.getDestination(keyword).then((value) => destinationList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
    }
    isLoading = false;
    update();
  }

  Future<List<DestinationModel>> getDestList(String keyword) async {
    List<DestinationModel> destList = [];
    try {
      await delivery.getDestination(keyword).then((value) => destList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
    }
    return destList;
  }
}