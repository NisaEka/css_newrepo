import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
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

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<AccountNumberModel> accountList = [];
  List<OriginModel> originList = [];

  AccountNumberModel? selectedAccount;
  OriginModel? selectedOrigin;
  ShipperModel? senderOrigin;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    accountList = [];
    isLoading = true;
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
    }
    isLoading = false;
    update();
  }

  Future<List<OriginModel>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    var response = await transaction.getOrigin(keyword, accountID);
    var models = response.payload?.toList();

    isLoadOrigin = false;
    update();
    return models ?? [];
  }

  void nextStep() {
    Get.to(const InformasiPenerimaScreen(), arguments: {
      "cod_ongkir": codOgkir,
      "account": selectedAccount,
      "origin": Origin(
        // origin code kalo sender bukan dropshipper?
        code: selectedOrigin?.branchCode ?? senderOrigin?.origin?.originCode,
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
