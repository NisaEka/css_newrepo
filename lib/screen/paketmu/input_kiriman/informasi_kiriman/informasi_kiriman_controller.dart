import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/service_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_fee_data_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
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

  int totalOngkir = 0;
  double flatRate = 0;
  double flatRateISR = 0;
  double freightCharge = 0;
  double freightChargeISR = 0;

  void hitungOngkir(String weight, String service) async {
    var resp = await transaction.getTransactionFee(TransactionFeeDataModel(
      destinationCode: destination.destinationCode,
      originCode: origin.code,
      serviceCode: service,
      weight: int.parse(weight),
      custNo: account.accountNumber,
    ));
    var fee = resp.payload;
    print(fee?.flatRate);
    // totalOngkir = int.parse(fee?.flatRate ?? fee?.freightCharge ?? '99');
    totalOngkir = totalOngkir + 10;
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

  Future<void> saveTransaction() async {
    try {
      await transaction
          .postTransaction(TransactionDataModel(
            delivery: Delivery(
              serviceCode: selectedService?.serviceCode,
              woodPackaging: packingKayu ? "Y" : "N",
              specialInstruction: intruksiKhusus.text,
              codFlag: account.accountService == "COD" ? "Y" : "N",
              codOngkir: codOngkir ? "Y" : "N",
              insuranceFlag: asuransi ? "Y" : "N",
              insuranceFee: hargaAsuransi.text.toInt(),
              flatRate: flatRate,
              flatRateWithInsurance: flatRateISR,
              freightCharge: freightCharge,
              freightChargeWithInsurance: freightChargeISR,
            ),
            account: Account(
              number: account.accountNumber,
              service: account.accountService,
            ),
            origin: origin,
            destination: Destination(code: destination.destinationCode, desc: destination.cityName),
            goods: Goods(
              type: jenisBarang.text,
              desc: namaBarang.text,
              quantity: jumlahPacking.text.toInt(),
              weight: beratKiriman.text.toInt(),
            ),
            shipper: shipper,
            receiver: receiver,
          ))
          .then((value) => print(value.message));
    } catch (e) {
      e.printError();
    }
  }
}
