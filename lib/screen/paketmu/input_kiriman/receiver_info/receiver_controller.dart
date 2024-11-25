import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver_state.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
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
          // AppSnackBar.success('Online Mode'.tr);
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
      state.receiverDest.text = state.data?.destination?.cityName ?? '';
      state.selectedDestination = state.data?.destination;
      state.isValidate = state.isEdit ?? false;
      update();
    }
  }

  FutureOr<ReceiverModel?> getSelectedReceiver() async {
    AppLogger.i("state.receiver ${jsonEncode(state.receiver)}");
    state.receiverName.text = state.receiver?.name?.toUpperCase() ?? '';
    state.receiverPhone.text = state.receiver?.phone ?? '';
    state.receiverDest.text = state.receiver?.idDestination ?? '';
    state.receiverAddress.text = state.receiver?.address?.toUpperCase() ?? '';
    getDestinationList(QueryParamModel(
      table: true,
      limit: 1,
      where: jsonEncode([
        {
          "countryName": state.receiver?.country,
        },
        {
          "provinceName": state.receiver?.region,
        },
        {
          "cityName": state.receiver?.city,
        },
        {
          "districtName": state.receiver?.district,
        },
        {
          "subdistrictName": state.receiver?.subDistrict,
        },
        {
          "zipCode": state.receiver?.zipCode,
        },
      ]),
    )).then((value) {
      AppLogger.i("getSelectedReceiver destination ${jsonEncode(value)}");
      state.selectedDestination = value.first;
    });
    update();
    return state.receiver;
  }

  bool isSaveReceiver() {
    if (state.receiver?.phone != state.receiverPhone.text) {
      return true;
    }
    return false;
  }

  Future<List<Destination>> getDestinationList(QueryParamModel param) async {
    state.isLoading = true;
    BaseResponse<List<Destination>>? response;
    try {
      response = await master.getDestinations(param);
    } catch (e, i) {
      AppLogger.e('error getDestinationList $e, $i');
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
      district: state.selectedDestination?.districtName,
      subDistrict: state.selectedDestination?.subdistrictName,
      destinationCode: state.selectedDestination?.destinationCode,
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
        'isEdit': state.isEdit,
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
            district: state.selectedDestination?.districtName ?? '-',
            subDistrict: state.selectedDestination?.subdistrictName ?? '-',
          ))
          .then(
            (value) => value.code == 201
                ? AppSnackBar.success('Data receiver telah disimpan'.tr)
                : AppSnackBar.error(value.error?.first.message.trs),
          );
    } catch (e) {
      AppLogger.e('error saveReceiver $e');
      AppSnackBar.error('Tidak dapat menyimpan state.data'.tr);
    }

    state.isLoadSave = false;
    update();
  }
}
