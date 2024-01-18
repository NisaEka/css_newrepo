import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/delivery/delivery_data_model.dart';
import 'package:css_mobile/data/model/delivery/get_account_number_model.dart';
import 'package:css_mobile/data/model/delivery/get_origin_model.dart';
import 'package:css_mobile/data/model/delivery/get_sender_model.dart';
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
  SenderModel? senderOrigin;

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
        senderOrigin = value.payload;
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

  Future<List<OriginModel>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    var response = await delivery.getOrigin(keyword, accountID);
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
        code: selectedOrigin?.branchCode,
        desc: selectedOrigin?.originName,
        branch: selectedOrigin?.branchCode,
      ),
      "dropship": dropshipper,
      "shipper": Shipper(
        name: namaPengirim.text.toUpperCase(),
        address: alamatLengkap.text.toUpperCase(),
        address1: '',
        address2: '',
        address3: '',
        city: kotaPengirim.text.toUpperCase(),
        zip: kodePos.text,
        // region: senderOrigin?., //province
        country: "ID",
        contact: senderOrigin?.name?.toUpperCase(),
        phone: senderOrigin?.phone,
      ),
    });
  }
}
