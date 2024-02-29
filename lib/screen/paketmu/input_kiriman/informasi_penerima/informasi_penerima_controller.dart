import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPenerimaController extends BaseController {
  TransactionModel? data = Get.arguments['data'];
  Shipper shipper = Get.arguments['shipper'];
  bool dropship = Get.arguments['dropship'];
  bool codOngkir = Get.arguments['cod_ongkir'];
  Origin origin = Get.arguments['origin'];
  Account account = Get.arguments['account'];

  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();
  final formKey = GlobalKey<FormState>();
  final namaPenerima = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaTujuan = TextEditingController();
  final alamatLengkap = TextEditingController();

  bool isLoading = false;
  bool isOnline = false;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<DestinationModel> destinationList = [];

  GetDestinationModel? destinationModel;
  DestinationModel? selectedDestination;
  ReceiverModel? selectedReceiver;

  @override
  void onInit() {
    super.onInit();
    Future.wait([getDestinationList(''), initData()]);
    connection.isOnline().then((value) => isOnline = value);

    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        isOnline = value && (result != ConnectivityResult.none);
        update();
      });
      update();
    }));
  }

  Future<void> initData() async {
    if (data != null) {
      namaPenerima.text = data?.receiver?.name ?? '';
      nomorTelpon.text = data?.receiver?.phone ?? '';
      selectedDestination = DestinationModel(
        id: data?.receiver?.idDestination?.toInt(),
        destinationCode: data?.receiver?.destinationCode,
        cityName: data?.receiver?.city,
        countryName: data?.receiver?.country,
        districtName: data?.receiver?.district,
        provinceName: data?.receiver?.region,
        subDistrictName: data?.receiver?.subDistrict,
        zipCode: data?.receiver?.zip,
      );
      alamatLengkap.text = data?.receiver?.address ?? '';

      update();
    }
  }

  FutureOr<ReceiverModel?> getSelectedReceiver(ReceiverModel receiver) async {
    namaPenerima.text = receiver.name ?? '';
    nomorTelpon.text = receiver.phone ?? '';
    kotaTujuan.text = receiver.idDestination ?? '';
    alamatLengkap.text = receiver.address ?? '';
    getDestinationList(receiver.city ?? '');
    selectedDestination = DestinationModel(
      id: receiver.idDestination?.toInt(),
      destinationCode: receiver.destinationCode,
      cityName: receiver.city,
      countryName: receiver.country,
      districtName: receiver.receiverDistrict,
      provinceName: receiver.region,
      subDistrictName: receiver.receiverSubDistrict,
      zipCode: receiver.zipCode,
    );

    update();
    return receiver;
  }

  Future<List<DestinationModel>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList = [];
    try {
      var response = await transaction.getDestination(keyword);
      destinationModel = response;
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    return destinationModel?.payload?.toList() ?? [];
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
        phone: nomorTelpon.text,
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

  Future<void> saveReceiver() async {
    try {
      await transaction
          .postReceiver(ReceiverModel(
            name: namaPenerima.text,
            contact: namaPenerima.text,
            phone: nomorTelpon.text,
            address: alamatLengkap.text,
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
                backgroundColor: value.code == 201 ? successColor : errorColor,
              ),
            ),
          );
    } catch (e) {
      e.printError();
    }
  }
}
