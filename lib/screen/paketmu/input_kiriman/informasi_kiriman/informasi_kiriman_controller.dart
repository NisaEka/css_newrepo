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
  final hargaCODkey = GlobalKey<FormFieldState>();
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

  // final codFee = TextEditingController();
  final hargaCOD = TextEditingController();

  bool asuransi = false;
  bool packingKayu = false;
  bool isServiceLoad = false;
  bool isCalculate = false;
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
  num flatRate = 0;
  num flatRateISR = 0;
  num freightCharge = 0;
  num freightChargeISR = 0;
  double isr = 0;
  double? berat;
  double hargacod = 0;
  double hargacCODOngkir = 0;
  double codfee = 0;

  void hitungBerat() {
    isCalculate = true;
    berat = 0;

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
    update();
    getOngkir();
    update();
    hitungOngkir();
    isCalculate = false;

    update();
  }

  void hitungOngkir() {
    totalOngkir = 0;
    isr = 0;
    isCalculate = true;
    // if (asuransi) {
    isr = (0.002 * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) + 5000;
    flatRateISR = flatRate + isr;
    freightChargeISR = freightCharge + isr;
    update();
    // }
    totalOngkir = asuransi ? flatRateISR.toInt() : flatRate.toInt();
    hargacod = (codfee * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) +
        (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt()) +
        totalOngkir;
    hargacCODOngkir = freightCharge + (asuransi ? isr : 0) + 1100;
    isCalculate = false;
    update();
  }

  Future<void> getCODfee() async {
    isCalculate = true;

    await transaction.getCODFee(account.accountId.toString()).then(
          (value) => codfee = value.payload?.disc?.toDouble() ?? 0,
        );
    isCalculate = false;

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
          weight: beratKiriman.text == '' ? 1 : beratKiriman.text.toInt(),
          custNo: account.accountNumber,
        ),
      )
          .then((value) {
        flatRate = value.payload?.flatRate?.toInt() ?? 0;
        freightCharge = value.payload?.freightCharge?.toInt() ?? 0;

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
    hitungOngkir();
    isCalculate = false;
    update();
  }

  Future<void> initData() async {
    isServiceLoad = true;
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
      getCODfee();
    } catch (e) {
      e.printError();
    }
    isServiceLoad = false;
    update();
  }

  Future<void> saveTransaction() async {
    isLoading = true;
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
              codFee: codfee,
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
                amount: hargaBarang.text.digitOnly().toInt(),
                quantity: jumlahPacking.text.toInt(),
                weight: berat),
            shipper: shipper,
            receiver: receiver,
          ))
          .then(
            (v) => Get.to(
                SucceesDialog(
                    message: "Transaksi Berhasil\n${v.payload?.awb}",
                    buttonTitle: "Selanjutnya",
                    nextAction: () => Get.offAll(
                          const DashboardScreen(),
                        )),
                arguments: {
                  'awb': v.payload?.awb,
                }),
          );
    } catch (e, i) {
      e.printError();
      i.printError();
    }
    isLoading = false;
    update();
  }
}
