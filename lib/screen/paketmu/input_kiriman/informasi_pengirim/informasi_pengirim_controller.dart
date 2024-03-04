import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPengirimController extends BaseController {
  final DataTransactionModel? data = Get.arguments['data'];

  final formKey = GlobalKey<FormState>();
  final nomorAkun = TextEditingController();
  final namaPengirim = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaPengirim = TextEditingController();
  final kodePos = TextEditingController();
  final alamatLengkap = TextEditingController();

  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();

  bool dropshipper = false;
  bool codOgkir = false;
  bool isLoading = false;
  bool isLoadOrigin = false;
  bool isValidate = false;
  bool isOnline = true;

  List<String> steps = ['Data Pengirim'.tr, 'Data Penerima'.tr, 'Data Kiriman'.tr];
  List<Account> accountList = [];
  List<Origin> originList = [];

  Account? selectedAccount;
  GetOriginModel? originModel;
  Origin? selectedOrigin;
  ShipperModel? senderOrigin;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      initData(),
    ]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        isOnline = value && (result != ConnectivityResult.none);
        update();
      });
      update();
    }));
  }

  FutureOr<DropshipperModel?> getSelectedDropshipper(DropshipperModel dropshipper) async {
    namaPengirim.text = dropshipper.name ?? '';
    nomorTelpon.text = dropshipper.phone ?? '';
    kotaPengirim.text = dropshipper.city ?? '';
    alamatLengkap.text = dropshipper.address ?? '';
    kodePos.text = dropshipper.zipCode ?? '';
    getOriginList(dropshipper.city ?? '', selectedAccount?.accountId ?? '').then((value) {
      selectedOrigin = value.first;

      update();
    });
    update();

    return dropshipper;
  }

  void formValidate() {
    isValidate = formKey.currentState?.validate() == true && selectedAccount != null && selectedOrigin != null;
    update();
    (formKey.currentState?.validate() == true).printInfo(info: 'form validate');
    (selectedAccount != null).printInfo(info: 'selectedAccount');
    (selectedOrigin != null).printInfo(info: 'selectedOrigin');
    isValidate.printInfo(info: 'isvalidate');
  }

  Future<void> initData() async {
    accountList = [];
    isLoading = true;
    connection.isOnline().then((value) => isOnline = value);

    try {
      await transaction.getAccountNumber().then((value) => accountList.addAll(value.payload ?? []));
      update();
      await transaction.getSender().then((value) {
        senderOrigin = value.payload;
        namaPengirim.text = value.payload?.name ?? '';
        nomorTelpon.text = value.payload?.phone ?? '';
        kotaPengirim.text = value.payload?.origin?.originName ?? '';
        kodePos.text = value.payload?.zipCode ?? '';
        alamatLengkap.text = value.payload?.address ?? '';
        selectedOrigin = Origin(
          originCode: senderOrigin?.origin?.originCode,
          branchCode: senderOrigin?.origin?.branchCode,
          originName: senderOrigin?.origin?.originName,
        );
      });
      update();
    } catch (e) {
      e.printError();
      var accounts = GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts));
      accountList.addAll(accounts.payload ?? []);
      // accountList.addAll(GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts)) );
      senderOrigin = ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
      namaPengirim.text = senderOrigin?.name ?? '';
      nomorTelpon.text = senderOrigin?.phone ?? '';
      kotaPengirim.text = senderOrigin?.origin?.originName ?? '';
      kodePos.text = senderOrigin?.zipCode ?? '';
      alamatLengkap.text = senderOrigin?.address ?? '';
      selectedOrigin = Origin(
        originCode: senderOrigin?.origin?.originCode,
        branchCode: senderOrigin?.origin?.branchCode,
        originName: senderOrigin?.origin?.originName,
      );
    }

    isLoading = false;
    update();

    if (data != null) {
      selectedAccount = accountList.where((element) => element.accountNumber == data?.account?.accountNumber).first;
      namaPengirim.text = data?.shipper?.name ?? '';
      nomorTelpon.text = data?.shipper?.phone ?? '';
      kodePos.text = data?.shipper?.zip ?? '';
      alamatLengkap.text = data?.shipper?.address ?? '';

      getOriginList(data?.shipper?.city ?? '', selectedAccount?.accountId ?? '').then((value) {
        selectedOrigin = value.first;
        kotaPengirim.text = value.first.originName ?? '';
        senderOrigin = ShipperModel(
          origin: value.first,
          name: data?.shipper?.name,
          address: data?.shipper?.address,
          phone: data?.shipper?.phone,
          region: Region(
            name: data?.shipper?.region,
          ),
          zipCode: data?.shipper?.zip,
        );
        update();
      });

      isValidate = true;
      update();

      // Get.showSnackbar(
      //   GetSnackBar(
      //     icon: const Icon(
      //       Icons.info,
      //       color: whiteColor,
      //     ),
      //     message: selectedAccount.toString(),
      //     isDismissible: true,
      //     duration: const Duration(seconds: 3),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  Future<List<Origin>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    try {
      var response = await transaction.getOrigin(keyword, accountID);
      originModel = response;
    } catch (e) {
      e.printError();
    }

    isLoadOrigin = false;
    update();
    return originModel?.payload?.toList() ?? [];
  }

  void nextStep() {
    Get.to(const InformasiPenerimaScreen(), arguments: {
      "cod_ongkir": codOgkir,
      "account": selectedAccount,
      "origin": selectedOrigin ?? senderOrigin?.origin,
      // "origin": Origin(
      //   // origin code kalo sender bukan dropshipper?
      //   originCode: selectedOrigin?.originCode ?? senderOrigin?.origin?.originCode,
      //   originName: selectedOrigin?.originName ?? senderOrigin?.origin?.originName,
      //   branchCode: selectedOrigin?.branchCode ?? senderOrigin?.origin?.branchCode,
      // ),
      "dropship": dropshipper,
      "shipper": Shipper(
        name: namaPengirim.text.toUpperCase(),
        address: alamatLengkap.text.toUpperCase(),
        address1: alamatLengkap.text.length >= 30 ? alamatLengkap.text.substring(0, 30) : '',
        address2: alamatLengkap.text.length >= 60 ? alamatLengkap.text.substring(31, 60) : '',
        address3: alamatLengkap.text.length >= 90 ? alamatLengkap.text.substring(60, 90) : '',
        city: kotaPengirim.text.toUpperCase(),
        zip: kodePos.text,
        region: senderOrigin?.region?.name,
        //province
        country: "ID",
        contact: senderOrigin?.name?.toUpperCase(),
        phone: senderOrigin?.phone,
        dropship: dropshipper,
      ),
      "data": data,
    });
  }

  Future<void> saveDropshipper() async {
    try {
      await transaction
          .postDropshipper(DropshipperModel(
            name: namaPengirim.text,
            phone: nomorTelpon.text,
            origin: selectedOrigin?.originCode,
            zipCode: kodePos.text,
            address: alamatLengkap.text,
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
                backgroundColor: value.code == 200 ? successColor : errorColor,
              ),
            ),
          );
    } catch (e) {
      e.printError();
    }
  }
}
