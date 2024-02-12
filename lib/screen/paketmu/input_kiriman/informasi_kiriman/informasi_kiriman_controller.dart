import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
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
  Delivery? delivery = Get.arguments['delivery'];
  Goods? goods = Get.arguments['goods'];
  int? draftIndex = Get.arguments['index'];
  DataTransactionModel? draft = Get.arguments['draft'];

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();
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
  bool formValidate = false;
  bool isOnline = true;

  List<String> steps = ['Data Pengirim'.tr, 'Data Penerima'.tr, 'Data Kiriman'.tr];
  List<ServiceModel> serviceList = [];
  List<DataTransactionModel> draftList = [];

  ServiceModel? selectedService;
  DraftTransactionModel? draftData;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);

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

  void hitungBerat(double p, double l, double t) {
    isCalculate = true;
    berat = 0;
    update();

    if (dimensi) {
      if (selectedService?.serviceCode?.contains("JTR") == true) {
        // if (selectedService?.serviceCode == "JTR23" ||
        //     selectedService?.serviceCode == "JTR<130" ||
        //     selectedService?.serviceCode == "JTR250" ||
        //     selectedService?.serviceCode == "JTR>250") {

        berat = (p * l * t) / 5000;
      } else {
        berat = (p * l * t) / 6000;
      }
      beratKiriman.text = berat!.toStringAsFixed(2);
    }
    update();
    getOngkir();

    update();
  }

  void hitungOngkir() {
    totalOngkir = 0;
    isr = 0;
    isr = (0.002 * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) + 5000;
    flatRateISR = flatRate + isr;
    update();

    if (isOnline) {
      isCalculate = true;
      update();
      if (isOnline) {
        // if (asuransi) {
        // isr = (0.002 * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) + 5000;
        // flatRateISR = flatRate + isr;
        freightChargeISR = freightCharge + isr;
        update();
        // }
        totalOngkir = asuransi ? flatRateISR.toInt() : flatRate.toInt();
        hargacod = (codfee * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) +
            (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt()) +
            totalOngkir;
        hargacCODOngkir = freightCharge + (asuransi ? isr : 0) + 1100;

        update();
      }

      isCalculate = false;
      update();
    }
  }

  Future<void> getCODfee() async {
    if (isOnline) {
      isCalculate = true;

      await transaction.getCODFee(account.accountId.toString()).then(
            (value) => codfee = value.payload?.disc?.toDouble() ?? 0,
          );
      isCalculate = false;

      update();
    }
  }

  Future<void> getOngkir() async {
    isCalculate = isOnline ? true : false;
    try {
      await transaction
          .getTransactionFee(
        DataTransactionFeeModel(
          destinationCode: destination.destinationCode,
          originCode: origin.code,
          serviceCode: selectedService?.serviceCode,
          weight: beratKiriman.text == '' ? 1 : beratKiriman.text.split('.').first.toInt(),
          custNo: account.accountNumber,
        ),
      )
          .then((value) {
        flatRate = value.payload?.flatRate?.toInt() ?? 0;
        freightCharge = value.payload?.freightCharge?.toInt() ?? 0;
      });
    } catch (e) {
      e.printError();
      String message;
      if (selectedService == null && isOnline) {
        message = "Service harus diisi".tr;
        Get.showSnackbar(
          GetSnackBar(
            message: message,
            isDismissible: true,
            margin: const EdgeInsets.only(bottom: 0),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING,
            animationDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    }
    hitungOngkir();
    update();
  }

  void loadDraft() async {
    draftList = [];
    DraftTransactionModel temp = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    draftList.addAll(temp.draft);

    namaBarang.text = goods?.desc ?? '';
    jenisBarang.text = goods?.type ?? '';
    hargaBarang.text = goods?.amount?.toInt().toCurrency().toString() ?? '';
    jumlahPacking.text = goods?.quantity.toString() ?? '';
    asuransi = delivery?.insuranceFlag == "Y" ? true : false;
    intruksiKhusus.text = delivery?.specialInstruction ?? '';
    packingKayu = delivery?.woodPackaging == "Y" ? true : false;
    beratKiriman.text = goods?.weight.toString() ?? '1';
    selectedService = serviceList.where((e) => e.serviceCode == delivery?.serviceCode).first;

    if (delivery?.flatRate != null) {
      getOngkir();
    }
    update();
  }

  void deleteDraft(int index) async {
    draftList.removeAt(index);
    var data = '{"draft" : ${jsonEncode(draftList)}}';
    draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    await storage.saveData(StorageCore.draftTransaction, draftData).then(
          (_) => update(),
        );
    // initData();

    update();
  }

  Future<void> initData() async {
    isServiceLoad = true;
    serviceList = [];
    // print('account id : ${account.accountId}');
    connection.isOnline().then((value) => isOnline = value);

    try {
      await transaction
          .getService(
        DataServiceModel(
          accountId: account.accountId,
          originCode: origin.code,
          destinationCode: destination.destinationCode,
        ),
      )
          .then((value) {
        serviceList.addAll(value.payload ?? []);
        if (value.code != 200) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.error,
                color: whiteColor,
              ),
              message: value.message.toString(),
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
          isOnline = false;
        }
      });
      getCODfee();
    } catch (e) {
      e.printError();
      // isOnline = false;
    }
    hitungOngkir();

    goods != null ? loadDraft() : null;
    isServiceLoad = false;
    update();
  }

  Future<void> saveDraft() async {
    draftList = [];
    DraftTransactionModel temp = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    draftList.addAll(temp.draft);
    draftList.add(DataTransactionModel(
      createAt: goods == null ? DateTime.now().toString() : draft?.createAt,
      updateAt: DateTime.now().toString(),
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
          weight: berat ?? beratKiriman.text.toInt()),
      shipper: shipper,
      receiver: receiver,
      dataAccount: account,
      dataDestination: destination,
    ));

    var data = '{"draft" : ${jsonEncode(draftList)}}';
    draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    goods != null ? deleteDraft(draftIndex!) : null;

    await storage.saveData(StorageCore.draftTransaction, draftData).then(
          (_) => Get.to(
            SuccessScreen(
              message: "Transaksi di simpan ke draft".tr,
              icon: const Icon(
                Icons.warning,
                color: warningColor,
                size: 150,
              ),
              buttonTitle: "Kembali ke Beranda".tr,
              nextAction: () => Get.offAll(
                const DashboardScreen(),
              ),
              secondButtonTitle: "Lihat Draft".tr,
              secondAction: () => Get.offAll(const DraftTransaksiScreen()),
              thirdButtonTitle: "Buat Transaksi Lainnya".tr,
              thirdAction: () => Get.offAll(const InformasiPengirimScreen()),
            ),
            arguments: {
              'transaction': true,
            },
          ),
        );
  }

  Future<void> saveTransaction() async {
    isLoading = true;
    update();
    try {
      await transaction
          .postTransaction(DataTransactionModel(
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
          .then((v) {
        if (goods != null) {
          deleteDraft(draftIndex!);
        }

        Get.to(
          SuccessScreen(
            message: "${'Transaksi Berhasil'.tr}\n${v.payload?.awb}",
            buttonTitle: "Kembali ke Beranda".tr,
            nextAction: () => Get.offAll(
              const DashboardScreen(),
              arguments: {
                'awb': v.payload?.awb,
              },
            ),
            thirdButtonTitle: "Buat Transaksi Lainnya".tr,
            thirdAction: () => Get.offAll(const InformasiPengirimScreen()),
          ),
        );
      });
    } catch (e, i) {
      e.printError();
      i.printError();
      saveDraft();
    }
    isLoading = false;
    update();
  }
}
