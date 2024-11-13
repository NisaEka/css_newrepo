import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver_state.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_screen.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiverController extends BaseController {
  final state = ReceiverState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    connection.isOnline().then((value) => state.isOnline = value);

    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        state.isOnline = value && (result != ConnectivityResult.none);
        update();
        if (state.isOnline) {
          AppSnackBar.custom(
            message: '',
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.only(top: 195),
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            messageText: Container(
              color: successColor, // Set your desired background color here
              child: Center(
                child: Text(
                  'Online Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
            ),
          );
        }
      });
      update();
    }));
  }

  Future<void> initData() async {
    if (state.data != null) {
      state.receiverName.text = state.data?.receiver?.name ?? '';
      state.receiverPhone.text = state.data?.receiver?.phone ?? '';
      state.receiverAddress.text = state.data?.receiver?.address ?? '';
      // state.kotaTujuan.text = state.data?.destination?.cityName

      update();
    }
  }

  FutureOr<ReceiverModel?> getSelectedReceiver() async {
    state.receiverName.text = state.receiver?.name?.toUpperCase() ?? '';
    state.receiverPhone.text = state.receiver?.phone ?? '';
    state.receiverDest.text = state.receiver?.idDestination ?? '';
    state.receiverAddress.text = state.receiver?.address?.toUpperCase() ?? '';
    getDestinationList(state.receiver?.destinationCode ?? '').then((value) {
      state.selectedDestination = value
          .where((element) =>
              element.destinationCode == state.receiver?.destinationCode)
          .first;
    });
    update();
    return state.receiver;
  }

  bool isSaveReceiver() {
    if (state.receiver?.name != state.receiverName.text &&
        state.receiver?.phone != state.receiverPhone.text) {
      return true;
    }
    return false;
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    state.isLoading = true;
    BaseResponse<List<Destination>>? response;
    try {
      response = await master
          .getDestinations(QueryParamModel(search: keyword.toUpperCase()));
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    state.isLoading = false;
    update();
    return response?.data?.toList() ?? [];
  }

  void nextStep() {
    var receiver = ReceiverModel(
      name: state.receiverName.text.toUpperCase(),
      address: state.receiverAddress.text.toUpperCase(),
      phone: state.receiverPhone.text,
      city: state.selectedDestination?.cityName,
      zipCode: state.selectedDestination?.zipCode,
      region: state.selectedDestination?.provinceName,
      country: state.selectedDestination?.countryName,
      contact: state.receiverName.text.toUpperCase(),
      receiverDistrict: state.selectedDestination?.districtName,
      receiverSubDistrict: state.selectedDestination?.subdistrictName,
    );

    var trans = DataTransactionModel(
      shipper: state.shipper,
      origin: state.origin,
      account: state.account,
      dataAccount: state.account,
      dropshipper: state.dropshipper,
      receiver: receiver,
      dataDestination: state.selectedDestination,
      destination: state.selectedDestination,
    );

    storage.writeString(
      StorageCore.transactionTemp,
      trans.toString(),
    );
    Get.to(
      const TransactionScreen(),
      transition: Transition.rightToLeft,
      arguments: {
        "data": state.data ?? trans,
        "cod_ongkir": state.codOngkir,
        "account": state.account,
        "origin": state.origin,
        "dropship": state.dropship,
        "dropshipper": state.dropshipper,
        "shipper": state.shipper,
        "receiver": receiver,
        "destination": state.selectedDestination,
      },
    );
  }

  Future<void> saveReceiver() async {
    state.isLoadSave = true;
    update();
    try {
      await master
          .postReceiver(ReceiverModel(
            name: state.receiverName.text,
            contact: state.receiverName.text,
            phone: state.receiverPhone.text,
            address: state.receiverAddress.text,
            city: state.selectedDestination?.cityName ?? '-',
            zipCode: state.selectedDestination?.zipCode ?? '00000',
            region: state.selectedDestination?.provinceName ?? '-',
            country: state.selectedDestination?.countryName ?? '-',
            destinationCode: state.selectedDestination?.destinationCode ?? '-',
            destinationDescription: state.selectedDestination?.cityName ?? '-',
            idDestination: state.selectedDestination?.id.toString() ?? '-',
            receiverDistrict: state.selectedDestination?.districtName ?? '-',
            receiverSubDistrict:
                state.selectedDestination?.subdistrictName ?? '-',
          ))
          .then((value) => value.code == 201
              ? AppSnackBar.success('Data receiver telah disimpan'.tr)
              : AppSnackBar.error(value.error?.first.message.tr));
    } catch (e) {
      e.printError();
      AppSnackBar.error('Tidak dapat menyimpan state.data'.tr);
    }

    state.isLoadSave = false;
    update();
  }
}
