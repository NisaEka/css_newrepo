import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_screen.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/items/draft_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DraftTransaksiController extends BaseController {
  List<DataTransactionModel> draftList = [];
  List<DataTransactionModel> searchList = [];
  DraftTransactionModel? draftData;
  final search = TextEditingController();

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
    searchList = [];
    draftList = [];
    var data = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    draftList.addAll(data.draft);
    update();

    isSync = draftList.where((element) => element.delivery?.flatRate != 0).isNotEmpty;

    update();
  }

  void delete(int index) async {
    draftList.removeAt(index);
    var data = '{"draft" : ${jsonEncode(draftList)}}';
    draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    await storage.saveData(StorageCore.draftTransaction, draftData).then(
          (_) => update(),
        );
    update();
  }

  void validate(int index) {
    var data = draftList.elementAt(index);
    Get.to(const TransactionScreen(), arguments: {
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
      // "data": data,
      "index": index,
    });
  }

  // Future<void> syncData() async {
  //   draftList.where((e) => e.delivery?.flatRate != 0).forEach((upload) async {
  //     update();
  //     try {
  //       isLoading = true;
  //       update();
  //       await transaction.postTransaction(upload).then((value) async {
  //         if (value.code == 201) {
  //           draftList.removeWhere((draft) => draft.delivery?.flatRate != 0);
  //           var data = '{"draft" : ${jsonEncode(draftList)}}';
  //           draftData = DraftTransactionModel.fromJson(jsonDecode(data));
  //
  //           await storage.saveData(StorageCore.draftTransaction, draftData).then((_) {
  //             initData();
  //             isLoading = false;
  //           });
  //         }
  //
  //         update();
  //
  //         Get.showSnackbar(
  //           GetSnackBar(
  //             icon: const Icon(
  //               Icons.info,
  //               color: whiteColor,
  //             ),
  //             message: value.code == 201 ? "Draft berhasil di upload" : "Draft gagal di upload",
  //             isDismissible: true,
  //             duration: const Duration(seconds: 3),
  //             backgroundColor: value.code == 201 ? successColor : errorColor,
  //           ),
  //         );
  //       });
  //     } catch (e) {
  //       e.printError();
  //     }
  //   });
  //   initData();
  //   isLoading = false;
  //   update();
  // }

  void searchDraft(String text) {
    searchList = [];
    if (text.isEmpty) {
      searchList = [];
      update();
    } else {
      for (var draft in draftList) {
        if (draft.dataAccount!.accountNumber!.contains(text) ||
            draft.dataAccount!.accountName!.contains(text) ||
            draft.dataAccount!.accountService!.contains(text) ||
            draft.shipper!.name!.contains(text) ||
            draft.receiver!.name!.contains(text) ||
            draft.destination!.cityName!.contains(text) ||
            draft.goods!.desc!.contains(text)) {
          searchList.add(draft);
          update();
        }
      }
      update();
    }

    update();
  }

  Widget draftItem(DataTransactionModel e, int i, BuildContext context) {
    return DraftTransactionListItem(
      data: e,
      index: i,
      onDelete: () => showDialog(
        context: context,
        builder: (context) => DeleteAlertDialog(
          onDelete: () {
            delete(i);
            initData();
            Get.back();
          },
          onBack: () {
            Get.back();
            initData();
          },
        ),
      ),
      onValidate: () => validate(i),
    );
  }
}
