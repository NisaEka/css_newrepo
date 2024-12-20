import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
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
  bool pop = false;

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
    var data = DraftTransactionModel.fromJson(
        await storage.readData(StorageCore.draftTransaction));
    draftList.addAll(data.draft);
    update();

    isSync = draftList
        .where((element) => element.delivery?.freightCharge != 0)
        .isNotEmpty;

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
    Get.to(() => const TransactionScreen(), arguments: {
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
      "data": data,
      "index": index,
    });
  }

  Future<void> syncData() async {
    draftList
        .where((e) => e.delivery?.freightCharge != 0)
        .forEach((upload) async {
      update();
      try {
        isLoading = true;
        update();
        await transaction
            .postTransaction(TransactionModel(
          // orderId: upload.noReference.text.isNotEmpty ? upload.noReference.text : null,
          // apiStatus: 0,
          apiType: upload.account?.accountService,
          custId: upload.account?.accountNumber,
          branch:
              upload.origin?.branchCode ?? upload.origin?.branch?.branchCode,
          codAmount: upload.delivery?.codFlag == "YES"
              ? upload.delivery?.codFee
              : null,
          codFlag: upload.delivery?.codFlag,
          codOngkir: upload.delivery?.codOngkir,
          // custId:
          deliveryPrice: upload.delivery?.freightCharge,
          deliveryPricePublish: upload.delivery?.freightCharge,
          destinationCode: upload.receiver?.destinationCode,
          goodsAmount: upload.goods?.amount,
          goodsDesc: upload.goods?.desc,
          goodsType: (upload.goods?.type?.isNotEmpty ?? false)
              ? upload.goods?.type
              : "PAKET",
          qty: upload.goods?.quantity,
          insuranceAmount: upload.delivery?.insuranceFee,
          insuranceFlag: upload.delivery?.insuranceFlag,
          originCode: upload.origin?.originCode,
          originDesc: upload.origin?.originName,
          packingkayuFlag: upload.delivery?.woodPackaging,
          receiverAddr: upload.receiver?.address,
          receiverCity: upload.receiver?.city,
          receiverCountry: upload.receiver?.country,
          receiverDistrict: upload.receiver?.district,
          receiverSubdistrict: upload.receiver?.subDistrict,
          receiverRegion: upload.receiver?.region,
          receiverZip: upload.receiver?.zipCode,
          receiverAddr1: upload.receiver?.address?.substring(
              0,
              (upload.receiver?.address?.length ?? 0) > 30
                  ? 29
                  : (upload.receiver?.address?.length ?? 0)),
          receiverAddr2: (upload.receiver?.address?.length ?? 0) > 30
              ? upload.receiver?.address?.substring(
                  30,
                  (upload.receiver?.address?.length ?? 0) > 60
                      ? 59
                      : (upload.receiver?.address?.length ?? 0))
              : '',
          receiverAddr3: (upload.receiver?.address?.length ?? 0) >= 60
              ? upload.receiver?.address
                  ?.substring(60, (upload.receiver?.address?.length ?? 0))
              : '',
          receiverName: upload.receiver?.name,
          receiverPhone: upload.receiver?.phone,
          receiverContact: upload.receiver?.contact,
          serviceCode: upload.delivery?.serviceCode,
          shipperName: upload.shipper?.name,
          shipperPhone: upload.shipper?.phone,
          shipperAddr: upload.shipper?.address,
          shipperCity: upload.shipper?.city,
          shipperZip: upload.shipper?.zipCode,
          shipperContact: upload.shipper?.contact,
          shipperRegion: upload.shipper?.region?.name ??
              upload.origin?.branch?.regional?.name,
          shipperCountry: upload.shipper?.country,
          shipperAddr1: upload.shipper?.address1,
          shipperAddr2: upload.shipper?.address2,
          shipperAddr3: upload.shipper?.address3,
          specialIns: upload.delivery?.specialInstruction,
          weight: upload.goods?.weight,
        ))
            .then((value) async {
          if (value.code == 201) {
            draftList
                .removeWhere((draft) => draft.delivery?.freightCharge != 0);
            var data = '{"draft" : ${jsonEncode(draftList)}}';
            draftData = DraftTransactionModel.fromJson(jsonDecode(data));

            await storage
                .saveData(StorageCore.draftTransaction, draftData)
                .then((_) {
              initData();
              isLoading = false;
            });
          }

          update();

          value.code == 201
              ? AppSnackBar.success('Draft berhasil di upload'.tr)
              : AppSnackBar.error('Draft gagal di upload'.tr);
        });
      } catch (e) {
        AppLogger.e('error sync $e');
      }
    });
    initData();
    isLoading = false;
    update();
  }

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

  void navigateToDraftTransaksi() {
    Get.to(
      const DraftTransaksiScreen(),
      arguments: {'fromMenu': true},
    );
  }

// Jika dari layar inputan transaksi
  void navigateFromInputTransaksi() {
    Get.to(
      const DraftTransaksiScreen(),
      arguments: {'fromMenu': false},
    );
  }
}
