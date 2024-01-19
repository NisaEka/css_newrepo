import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPenerimaController extends BaseController {
  Shipper shipper = Get.arguments['shipper'];
  bool dropship = Get.arguments['dropship'];
  bool codOngkir = Get.arguments['cod_ongkir'];
  Origin origin = Get.arguments['origin'];
  AccountNumberModel account = Get.arguments['account'];

  final formKey = GlobalKey<FormState>();
  final namaPenerima = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaTujuan = TextEditingController();
  final alamatLengkap = TextEditingController();

  bool isLoading = false;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<DestinationModel> destinationList = [];

  DestinationModel? selectedDestination;

  @override
  void onInit() {
    super.onInit();
    Future.wait([getDestinationList('')]);
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

  void nextStep() {
    Get.to(const InformasiKirimanScreen(), arguments: {
      "cod_ongkir": codOngkir,
      "account": account,
      "origin": origin,
      "dropship": dropship,
      "shipper": shipper,
      "receiver": Receiver(
        name: namaPenerima.text.toUpperCase(),
        address: alamatLengkap.text.toUpperCase(),
        address1: '',
        address2: '',
        address3: '',
        city: selectedDestination?.cityName,
        zip: selectedDestination?.zipCode,
        region: selectedDestination?.cityName,
        country: selectedDestination?.countryName,
        contact: namaPenerima.text.toUpperCase(),
        district: selectedDestination?.districtName,
        subDistrict: selectedDestination?.subDistrictName,
      ),
      "destination": selectedDestination,
    });
  }
}