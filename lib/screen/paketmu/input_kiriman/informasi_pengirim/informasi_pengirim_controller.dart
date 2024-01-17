import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/delivery/get_account_number_model.dart';
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

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<AccountNumber> accountList = [];

  AccountNumber? selectedAccount;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    accountList = [];
    isLoading = true;
    try {
      await delivery.getAccountNumber().then((value) => accountList.addAll(value.payload ?? []));
      await delivery.getSender().then((value) {
        namaPengirim.text = value.payload?.name ?? '';
        nomorTelpon.text = value.payload?.phone ?? '';
        kotaPengirim.text = value.payload?.city ?? '';
        kodePos.text = value.payload?.zipCode ?? '';
        alamatLengkap.text = value.payload?.address ?? '';
      });
      update();
    } catch (e) {
      e.printError();
    }
    isLoading = false;
    update();
  }
}
