import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DraftTransaksiController extends BaseController {

  List<DataTransactionModel> draftList = [];

  DraftTransactionModel? draftData;

  bool isOnline = true;
  bool isSync = false;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    initData();

    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        isOnline = value && (result != ConnectivityResult.none);
        update();
      });
      initData();
      update();
    }));
  }

  Future<void> initData() async {
    connection.isOnline().then((value) => isOnline = value);
    update();

    draftList = [];
    var data = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    draftList.addAll(data.draft);
    update();

    isSync = draftList.where((element) => element.delivery?.flatRate != 0).isNotEmpty;

    update();
  }

  void delete(int index) async {
    print(draftList);
    draftList.removeAt(index);
    var data = '{"draft" : ${jsonEncode(draftList)}}';
    draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    await storage.saveData(StorageCore.draftTransaction, draftData).then(
          (_) => update(),
        );
    // initData();
    print(draftList);

    update();
  }

  void validate(int index) {
    var data = draftList.elementAt(index);
    print('test validate ${data}');
    Get.to(const InformasiKirimanScreen(), arguments: {
      "cod_ongkir": data.delivery?.codOngkir == "Y" ? true : false,
      "account": data.dataAccount,
      "origin": data.origin,
      "dropship": data.shipper?.dropship,
      "shipper": data.shipper,
      "receiver": data.receiver,
      "destination": data.dataDestination,
      "delivery": data.delivery,
      "goods": data.goods,
      "draft": data,
      "index": index,
    });
  }

  Future<void> syncData() async {
    draftList.where((e) => e.delivery?.flatRate != 0).forEach((upload) async {
      update();
      try {
        isLoading = true;
        update();
        await transaction.postTransaction(upload).then((value) async {
          if (value.code == 201) {
            draftList.removeWhere((draft) => draft.delivery?.flatRate != 0);
            var data = '{"draft" : ${jsonEncode(draftList)}}';
            draftData = DraftTransactionModel.fromJson(jsonDecode(data));

            await storage.saveData(StorageCore.draftTransaction, draftData).then((_) {
              initData();
              isLoading = false;
            });
          }

          update();

          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.info,
                color: whiteColor,
              ),
              message: value.code == 201 ? "Draft berhasil di upload" : "Draft gagal di upload",
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: value.code == 201 ? successColor : errorColor,
            ),
          );
        });
      } catch (e) {
        e.printError();
      }
    });
    initData();
    isLoading = false;
    update();
  }
}
