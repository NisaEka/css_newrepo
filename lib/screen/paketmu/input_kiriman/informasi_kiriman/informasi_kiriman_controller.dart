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
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_controller.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiKirimaController extends BaseController {
  DataTransactionModel? dataEdit = Get.arguments['data'];
  Shipper shipper = Get.arguments['shipper'];
  bool dropship = Get.arguments['dropship'];
  bool codOngkir = Get.arguments['cod_ongkir'];
  Origin origin = Get.arguments['origin'];
  Account account = Get.arguments['account'];
  Receiver receiver = Get.arguments['receiver'];
  Destination destination = Get.arguments['destination'];
  Delivery? delivery = Get.arguments['delivery'];
  Goods? goods = Get.arguments['goods'];
  int? draftIndex = Get.arguments['index'];
  DataTransactionModel? draft = Get.arguments['draft'];
  DropshipperModel? dropshipper = Get.arguments['dropshipper'];

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
  bool isShowDialog = false;

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
  double berat = 0;
  double hargacod = 0;
  double hargacCODOngkir = 0;
  double hargacCODOngkirISR = 0;
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

      String b = "0.${berat.toStringAsFixed(2).split('.').last}";

      if (berat < 1) {
        beratKiriman.text = '1';
      } else if (b.toDouble() >= 0.31) {
        beratKiriman.text = berat.ceil().toString();
      } else {
        beratKiriman.text = berat.truncate().toString();
      }
      // beratKiriman.text = berat!.toStringAsFixed(2);
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
    freightChargeISR = freightCharge + isr;
    update();

    if (isOnline) {
      isCalculate = true;
      update();
      if (isOnline) {
        // if (asuransi) {
        // isr = (0.002 * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) + 5000;
        flatRateISR = flatRate + isr;
        freightChargeISR = freightCharge + isr;
        update();
        // }
        hargacod = (codfee * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) +
            (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt()) +
            totalOngkir;
        hargacCODOngkir = freightCharge + (asuransi ? isr : 0) + 1000;
        hargacCODOngkirISR = freightCharge + isr;
        update();

        totalOngkir = codOngkir
            ? hargacCODOngkir.toInt()
            : asuransi
                ? freightChargeISR.toInt()
                : freightCharge.toInt();

        update();
      }
      if (totalOngkir > 1000000) {
        isShowDialog = true;
        update();
        // Get.showSnackbar(
        //   const GetSnackBar(
        //     message: "Total Ongkos Kirim tidak bisa lebih dari Rp. 1000.000,-",
        //     isDismissible: true,
        //     margin: EdgeInsets.only(bottom: 0),
        //     duration: Duration(seconds: 3),
        //     backgroundColor: Colors.red,
        //     snackPosition: SnackPosition.BOTTOM,
        //     snackStyle: SnackStyle.FLOATING,
        //     animationDuration: Duration(milliseconds: 500),
        //   ),
        // );
      } else {
        isShowDialog = false;
        update();
      }

      isValidate();

      isCalculate = false;
      update();
    }
  }

  bool isValidate() {
    if (formValidate && selectedService != null && !isCalculate && totalOngkir <= 1000000) {
      return true;
    }

    return false;
  }

  Future<void> getCODfee() async {
    if (isOnline && account.accountService == "COD") {
      isCalculate = true;
      try {
        await transaction.getCODFee(account.accountId.toString()).then(
          (value) {
            codfee = value.payload?.disc?.toDouble() ?? 0;
            update();
          },
        );
        isCalculate = false;

        update();
      } catch (e) {
        e.printError();
      }
    }
  }

  Future<void> getOngkir() async {
    isCalculate = isOnline ? true : false;
    try {
      await transaction
          .getTransactionFee(
        DataTransactionFeeModel(
          destinationCode: destination.destinationCode,
          originCode: origin.originCode,
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
    beratKiriman.text = goods?.weight.toString().split('.').first ?? '1';
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
    jenisBarang.text = "PAKET";
    try {
      await transaction
          .getService(
        DataServiceModel(
          accountId: account.accountId,
          originCode: origin.originCode,
          destinationCode: destination.destinationCode,
        ),
      )
          .then((value) {
        serviceList.addAll(value.payload ?? []);
        update();
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
          update();
        }
      });
      getCODfee();
      update();
    } catch (e) {
      e.printError();
      // isOnline = false;
    }
    if (dataEdit != null) {
      jenisBarang.text = dataEdit?.goods?.type ?? '';
      noReference.text = dataEdit?.orderId ?? '';
      namaBarang.text = dataEdit?.goods?.desc ?? '';
      hargaBarang.text = dataEdit?.goods?.amount?.toInt().toCurrency().toString() ?? '';
      jumlahPacking.text = dataEdit?.goods?.quantity.toString() ?? '';
      asuransi = dataEdit?.delivery?.insuranceFlag == "Y";
      intruksiKhusus.text = dataEdit?.delivery?.specialInstruction ?? '';
      packingKayu = dataEdit?.delivery?.woodPackaging == "Y";
      beratKiriman.text = dataEdit?.goods?.weight.toString() ?? '';
      var servicecode = serviceList.where((element) => element.serviceCode == dataEdit?.delivery?.serviceCode);
      var servicrdisplay = serviceList.where((element) => element.serviceDisplay == dataEdit?.delivery?.serviceCode);
      selectedService = servicecode.isNotEmpty ? servicecode.first : servicrdisplay.first;
      update();
      getOngkir();
    }
    if (draft != null) {
      beratKiriman.text = draft?.goods?.weight.toString().split('.').first ?? '';
      update();
    }
    hitungOngkir();

    goods != null ? loadDraft() : null;
    isServiceLoad = false;
    update();
  }

  Future<void> saveDraft() async {
    isLoading = true;
    update();
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
        codFlag: account.accountService == "COD" ? "YES" : "NO",
        codOngkir: codOngkir ? "YES" : "NO",
        insuranceFlag: asuransi ? "Y" : "N",
        insuranceFee: isr,
        flatRate: flatRate,
        codFee: codfee,
        flatRateWithInsurance: flatRateISR,
        freightCharge: freightCharge,
        freightChargeWithInsurance: freightChargeISR,
      ),
      account: Account(
        accountNumber: account.accountNumber,
        accountService: account.accountService,
      ),
      origin: origin,
      destination: destination,
      // destination: Destination(code: destination.destinationCode, desc: destination.cityName),
      goods: Goods(
          type: jenisBarang.text,
          desc: namaBarang.text,
          amount: hargaBarang.text.isNotEmpty ? hargaBarang.text.digitOnly().toInt() : 0,
          quantity: jumlahPacking.text.toInt(),
          weight: berat != 0 ? berat : beratKiriman.text.toInt()),
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
              secondAction: () => Get.delete<DraftTransaksiController>().then((value) => Get.offAll(const DraftTransaksiScreen())),
              thirdButtonTitle: "Buat Transaksi Lainnya".tr,
              thirdAction: () => Get.offAll(const InformasiPengirimScreen(), arguments: {}),
            ),
            arguments: {
              'transaction': true,
            },
          ),
        );

    isLoading = false;
    update();
  }

  Future<void> updateTransaction() async {
    isLoading = true;
    update();

    try {
      await transaction
          .putTransaction(
        DataTransactionModel(
          delivery: Delivery(
            serviceCode: selectedService?.serviceDisplay,
            woodPackaging: packingKayu ? "Y" : "N",
            specialInstruction: intruksiKhusus.text,
            codFlag: account.accountService == "COD" ? "YES" : "NO",
            codOngkir: codOngkir ? "YES" : "NO",
            insuranceFlag: asuransi ? "Y" : "N",
            insuranceFee: isr,
            flatRate: flatRate,
            codFee: codfee,
            flatRateWithInsurance: flatRateISR,
            freightCharge: freightCharge,
            freightChargeWithInsurance: freightChargeISR,
          ),
          account: Account(
            accountNumber: account.accountNumber,
            accountService: account.accountService,
          ),
          origin: origin,
          destination: destination,
          // destination: Destination(code: destination.destinationCode, desc: destination.cityName),
          goods: Goods(
              type: jenisBarang.text,
              desc: namaBarang.text,
              amount: hargaBarang.text.digitOnly().toInt(),
              quantity: jumlahPacking.text.toInt(),
              weight: berat),
          shipper: shipper,
          receiver: receiver,
        ),
        dataEdit?.awb ?? '',
      )
          .then((v) {
        if (v.code == 400) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: warningColor,
              ),
              message: v.message?.tr,
              isDismissible: true,
              margin: const EdgeInsets.only(bottom: 0),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM,
              snackStyle: SnackStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 500),
            ),
          );
        } else {
          Get.to(
            SuccessScreen(
              message: 'Update Berhasil'.tr,
              buttonTitle: "Kembali ke Beranda".tr,
              nextAction: () => Get.offAll(
                const DashboardScreen(),
                arguments: {
                  'awb': v.payload?.awb,
                },
              ),
              thirdButtonTitle: "Lihat Transaksi",
              thirdAction: () => Get.offAll(const RiwayatKirimanScreen()),
            ),
          );
        }
      });
    } catch (e, i) {
      e.printError();
      i.printError();
      saveDraft();
    }
    isLoading = false;
    update();
  }

  Future<void> saveTransaction() async {
    isLoading = true;
    update();

    try {
      await transaction
          .postTransaction(DataTransactionModel(
        delivery: Delivery(
          serviceCode: selectedService?.serviceDisplay,
          woodPackaging: packingKayu ? "Y" : "N",
          specialInstruction: intruksiKhusus.text,
          codFlag: account.accountService == "COD" ? "YES" : "NO",
          codOngkir: codOngkir ? "YES" : "NO",
          insuranceFlag: asuransi ? "Y" : "N",
          insuranceFee: isr,
          flatRate: flatRate,
          codFee: codfee,
          flatRateWithInsurance: flatRateISR,
          freightCharge: freightCharge,
          freightChargeWithInsurance: freightChargeISR,
        ),
        account: Account(
          accountNumber: account.accountNumber,
          accountService: account.accountService,
        ),
        origin: origin,
        destination: destination,
        // destination: Destination(code: destination.destinationCode, desc: destination.cityName),
        goods: Goods(
            type: jenisBarang.text,
            desc: namaBarang.text,
            amount: hargaBarang.text.isNotEmpty ? hargaBarang.text.digitOnly().toInt() : 0,
            quantity: jumlahPacking.text.toInt(),
            weight: berat),
        shipper: shipper,
        receiver: receiver,
      ))
          .then((v) {
        if (goods != null) {
          deleteDraft(draftIndex!);
        }
        if (v.code == 400) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: warningColor,
              ),
              message: v.error?.first.message?.tr,
              isDismissible: true,
              margin: const EdgeInsets.only(bottom: 0),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM,
              snackStyle: SnackStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 500),
            ),
          );
        } else {
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
              thirdAction: () => Get.offAll(const InformasiPengirimScreen(), arguments: {}),
            ),
          );
        }
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
