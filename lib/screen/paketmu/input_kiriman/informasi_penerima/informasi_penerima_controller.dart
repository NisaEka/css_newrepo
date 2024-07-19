import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPenerimaController extends BaseController {
  DataTransactionModel? data = Get.arguments['data'];
  Shipper shipper = Get.arguments['shipper'];
  bool dropship = Get.arguments['dropship'];
  DropshipperModel? dropshipper = Get.arguments['dropshipper'];
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
  bool isOnline = true;
  bool isLoadSave = false;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<Destination> destinationList = [];

  GetDestinationModel? destinationModel;
  Destination? selectedDestination;
  ReceiverModel? receiver;

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
        if (isOnline) {
          Get.showSnackbar(
            GetSnackBar(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              margin: const EdgeInsets.only(top: 195),
              snackPosition: SnackPosition.TOP,
              messageText: Center(
                child: Text(
                  'Online Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor.withOpacity(0.7),
            ),
          );
        }
      });
      update();
    }));
  }

  Future<void> initData() async {
    if (data != null) {
      namaPenerima.text = data?.receiver?.name ?? '';
      nomorTelpon.text = data?.receiver?.phone ?? '';
      alamatLengkap.text = data?.receiver?.address ?? '';
      getDestinationList(data?.destination?.cityName ?? '').then((value) {
        selectedDestination = value.first;
        update();
      });
      // kotaTujuan.text = data?.destination?.cityName

      update();
    }
  }

  FutureOr<ReceiverModel?> getSelectedReceiver() async {
    namaPenerima.text = receiver?.name?.toUpperCase() ?? '';
    nomorTelpon.text = receiver?.phone ?? '';
    kotaTujuan.text = receiver?.idDestination ?? '';
    alamatLengkap.text = receiver?.address?.toUpperCase() ?? '';
    getDestinationList(receiver?.city?.split(',').first ?? '');
    selectedDestination = Destination(
      id: receiver?.idDestination?.toInt(),
      destinationCode: receiver?.destinationCode,
      cityName: receiver?.city,
      countryName: receiver?.country,
      districtName: receiver?.receiverDistrict,
      provinceName: receiver?.region,
      subDistrictName: receiver?.receiverSubDistrict,
      zipCode: receiver?.zipCode,
    );

    update();
    return receiver;
  }

  bool isSaveReceiver() {
    if (receiver?.name != namaPenerima.text && receiver?.phone != nomorTelpon.text) {
      return true;
    }
    return false;
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
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
    Get.to(
      const InformasiKirimanScreen(),
      transition: Transition.rightToLeft,
      arguments: {
        "data": data,
        "cod_ongkir": codOngkir,
        "account": account,
        "origin": origin,
        "dropship": dropship,
        "dropshipper": dropshipper,
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
          region: selectedDestination?.provinceName,
          country: selectedDestination?.countryName,
          contact: namaPenerima.text.toUpperCase(),
          district: selectedDestination?.districtName,
          subDistrict: selectedDestination?.subDistrictName,
        ),
        "destination": selectedDestination,
      },
    );
  }

  Future<void> saveReceiver() async {
    isLoadSave = true;
    update();
    try {
      await transaction
          .postReceiver(ReceiverModel(
            name: namaPenerima.text,
            contact: namaPenerima.text,
            phone: nomorTelpon.text,
            address: alamatLengkap.text,
            city: selectedDestination?.cityName ?? '-',
            zipCode: selectedDestination?.zipCode ?? '00000',
            region: selectedDestination?.provinceName ?? '-',
            country: selectedDestination?.countryName ?? '-',
            destinationCode: selectedDestination?.destinationCode ?? '-',
            destinationDescription: selectedDestination?.cityName ?? '-',
            idDestination: selectedDestination?.id.toString() ?? '-',
            receiverDistrict: selectedDestination?.districtName ?? '-',
            receiverSubDistrict: selectedDestination?.subDistrictName ?? '-',
          ))
          .then(
            (value) => value == 201
                ? Get.showSnackbar(
                    GetSnackBar(
                      icon: const Icon(
                        Icons.info,
                        color: whiteColor,
                      ),
                      message: "Data penerima telah disimpan".tr,
                      isDismissible: true,
                      duration: const Duration(seconds: 3),
                      backgroundColor: value.code == 201 ? successColor : errorColor,
                    ),
                  )
                : Get.showSnackbar(
                    GetSnackBar(
                      icon: const Icon(
                        Icons.info,
                        color: whiteColor,
                      ),
                      message: value.error?.first.message ?? ''.tr,
                      isDismissible: true,
                      duration: const Duration(seconds: 3),
                      backgroundColor: value.code == 201 ? successColor : errorColor,
                    ),
                  ),
          );
    } catch (e) {
      e.printError();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.info,
            color: whiteColor,
          ),
          message: 'Tidak dapat menyimpan data'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
    }

    isLoadSave = false;
    update();
  }
}
