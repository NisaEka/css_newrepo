import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/service_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_fee_data_model.dart';
import 'package:css_mobile/dialog/success_dialog.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
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
  bool isCalculate = false;
  bool dimensi = false;
  double isr = 0;
  double berat = 0;
  double hargacod = 0;
  double hargacCODOngkir = 0;

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];
  List<ServiceModel> serviceList = [];

  ServiceModel? selectedService;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  int totalOngkir = 0;
  num flatRate = 0;
  num flatRateISR = 0;
  num freightCharge = 0;
  num freightChargeISR = 0;

  void hitungOngkir() {
    if (dimensi) {
      if (selectedService?.serviceCode == "JTR23" ||
          selectedService?.serviceCode == "JTR<130" ||
          selectedService?.serviceCode == "JTR250" ||
          selectedService?.serviceCode == "JTR>250") {
        berat = (dimensiPanjang.text.toDouble() * dimensiLebar.text.toDouble() * dimensiTinggi.text.toDouble()) / 5000;
      } else {
        berat = (dimensiPanjang.text.toDouble() * dimensiLebar.text.toDouble() * dimensiTinggi.text.toDouble()) / 6000;
      }
      beratKiriman.text = berat.toString();
    }

    if (asuransi) {
      isr = (0.002 * (hargaBarang.text == '' ? 0 : hargaBarang.text.toInt())) + 5000;
      flatRateISR = flatRate + isr;
    }
    hargacod = ((2.5 / 100) * ((hargaBarang.text == '' ? 0 : hargaBarang.text.toInt()) + freightCharge)) +
        (hargaBarang.text == '' ? 0 : hargaBarang.text.toInt()) +
        freightCharge +
        (asuransi ? isr : 0);
    hargacCODOngkir = freightCharge + (asuransi ? isr : 0) + 1100;
    update();
  }

  Future<void> getOngkir() async {
    isCalculate = true;
    try {
      await transaction
          .getTransactionFee(
        TransactionFeeDataModel(
          destinationCode: destination.destinationCode,
          originCode: origin.code,
          serviceCode: selectedService?.serviceCode,
          weight: int.parse(beratKiriman.text),
          custNo: account.accountNumber,
        ),
      )
          .then((value) {
        flatRate = value.payload?.flatRate?.toInt() ?? 0;
        freightCharge = value.payload?.freightCharge?.toInt() ?? 0;
        hitungOngkir();
      });
    } catch (e) {
      e.printError();
      var message;
      if (selectedService == null) {
        message = "Service harus diisi";
        Get.showSnackbar(
          GetSnackBar(
            message: message,
            isDismissible: true,
            margin: EdgeInsets.only(bottom: 0),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING,
            animationDuration: Duration(milliseconds: 500),
          ),
        );
      }
    }

    isCalculate = false;
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
              insuranceFee: isr,
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
          .then(
            (_) => Get.to(SucceesDialog(
              message: "Resi telah dibuat",
              buttonTitle: "Selanjutnya",
              nextAction: () => Get.offAll(const DashboardScreen()),
            )),
          );
    } catch (e, i) {
      e.printError();
      i.printError();
    }
  }
}
