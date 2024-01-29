import 'dart:async';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPengirimController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final nomorAkun = TextEditingController();
  final namaPengirim = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaPengirim = TextEditingController();
  final kodePos = TextEditingController();
  final alamatLengkap = TextEditingController();

  bool dropshipper = false;
  bool codOgkir = false;
  bool isLoading = false;
  bool isLoadOrigin = false;
  bool isValidate = false;
  bool isOnline = false;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<AccountNumberModel> accountList = [];
  List<OriginModel> originList = [];

  AccountNumberModel? selectedAccount;
  GetOriginModel? originModel;
  OriginModel? selectedOrigin;
  ShipperModel? senderOrigin;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      initData(),
    ]);
  }

  FutureOr<DropshipperModel?> getSelectedDropshipper(DropshipperModel dropshipper) async {
    namaPengirim.text = dropshipper.name ?? '';
    nomorTelpon.text = dropshipper.phone ?? '';
    kotaPengirim.text = dropshipper.city ?? '';
    alamatLengkap.text = dropshipper.address ?? '';
    kodePos.text = dropshipper.zipCode ?? '';
    getOriginList(dropshipper.city ?? '', selectedAccount?.accountId ?? '');
    selectedOrigin = OriginModel(
      originName: dropshipper.city,
      originCode: dropshipper.origin,
    );

    update();
    return dropshipper;
  }


  Future<void> initData() async {
    accountList = [];
    isLoading = true;
    connection.isOnline().then((value) => isOnline = value);
    update();

    // if (isOnline) {
    try {
      await transaction.getAccountNumber().then((value) => accountList.addAll(value.payload ?? []));
      await transaction.getSender().then((value) {
        senderOrigin = value.payload;
        namaPengirim.text = value.payload?.name ?? '';
        nomorTelpon.text = value.payload?.phone ?? '';
        kotaPengirim.text = value.payload?.origin?.originName ?? '';
        kodePos.text = value.payload?.zipCode ?? '';
        alamatLengkap.text = value.payload?.address ?? '';
        selectedOrigin = OriginModel(
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
      selectedOrigin = OriginModel(
        originCode: senderOrigin?.origin?.originCode,
        branchCode: senderOrigin?.origin?.branchCode,
        originName: senderOrigin?.origin?.originName,
      );
    }
    // } else {
    //
    // }

    isLoading = false;
    update();
  }

  Future<List<OriginModel>> getOriginList(String keyword, String accountID) async {
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
      "origin": Origin(
        // origin code kalo sender bukan dropshipper?
        code: selectedOrigin?.originCode ?? senderOrigin?.origin?.originCode,
        desc: selectedOrigin?.originName ?? senderOrigin?.origin?.originName,
        branch: selectedOrigin?.branchCode ?? senderOrigin?.origin?.branchCode,
      ),
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
      ),
    });
  }
}
