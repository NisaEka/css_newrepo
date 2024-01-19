import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/service_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_fee_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiKirimaController extends BaseController {
  Shipper shipper = Get.arguments['shipper'];
  bool dropship = Get.arguments['dropship'];
  bool codOngkir = Get.arguments['cod_ongkir'];
  Origin origin = Get.arguments['origin'];
  AccountNumberModel account = Get.arguments['account'];
  Receiver receiver = Get.arguments['receiver'];
  DestinationModel destination = Get.arguments['destination'];

  final formKey = GlobalKey<FormState>();
  final service = TextEditingController();
  final beratKiriman = TextEditingController();
  final dimensiPanjang = TextEditingController();
  final dimensiLebar = TextEditingController();
  final dimensiTinggi = TextEditingController();
  final jumlahPacking = TextEditingController();
  final jenisBarang = TextEditingController();
  final namaBarang = TextEditingController();
  final noReference = TextEditingController();
  final intruksiKhusus = TextEditingController();
  final layanan = TextEditingController();
  final hargaBarang = TextEditingController();
  final ongkosKirim = TextEditingController();
  final hargaAsuransi = TextEditingController();
  final codFee = TextEditingController();
  final hargaCOD = TextEditingController();

  bool asuransi = false;
  bool packingKayu = false;
  bool isLoading = false;
  bool dimensi = false;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<ServiceModel> serviceList = [];

  ServiceModel? selectedService;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  int? totalOngkir = 0;

  Future<void> hitungOngkir() async {
    var resp = await transaction.getTransactionFee(TransactionFeeDataModel(
      destinationCode: destination.destinationCode,
      originCode: origin.code,
      serviceCode: selectedService?.serviceCode,
      weight: int.parse(beratKiriman.text),
      custNo: account.accountNumber,
    ));
    var fee = resp.payload;
    totalOngkir = int.parse(fee?.flatRate ?? fee?.freightCharge ?? '0');

    update();
  }

  Future<void> initData() async {
    isLoading = true;
    serviceList = [];
    try {
      await transaction
          .getService(
            ServiceDataModel(
              accountId: account.accountId,
              originCode: origin.code,
              destinationCode: destination.destinationCode,
            ),
          )
          .then(
            (value) => serviceList.addAll(value.payload ?? []),
          );
    } catch (e) {
      e.printError();
    }
    isLoading = false;
    update();
  }
}
