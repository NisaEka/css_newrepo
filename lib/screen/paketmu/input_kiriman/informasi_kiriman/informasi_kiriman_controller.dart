import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
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
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
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
  final codAmountText = TextEditingController();

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
        if (isOnline) {
          Get.showSnackbar(
            GetSnackBar(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              margin: const EdgeInsets.only(top: 195),
              snackPosition: SnackPosition.TOP,
              messageText: Center(
                child: Text(
                  'Online Mode'.tr,
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor.withOpacity(0.7),
            ),
          );
        }
      });
      initData();
      update();
    }));
  }

  num totalOngkir = 0;
  num flatRate = 0;
  num flatRateISR = 0;
  num freightCharge = 0;
  num freightChargeISR = 0;
  double isr = 0;
  double berat = 0;
  num hargacod = 0;
  num hargacCODOngkir = 0;
  num hargacCODOngkirISR = 0;
  double codfee = 0;
  num getCodFeeMinimum = 0;
  num getCodAmountMinimum = 0;
  num getCodFee = 0;
  num getCodAmount = 0;
  num getInsurance = 0;

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
    double vat = (1.1 / 100);
    isr = (0.002 * (hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt())) + 5000;
    flatRateISR = flatRate + isr;
    freightChargeISR = freightCharge + isr;
    getInsurance = asuransi ? isr : 0;
    update();
    int goodsAmount = hargaBarang.text == '' ? 0 : hargaBarang.text.digitOnly().toInt();

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
        print("select account : ${account.toJson()}");
        bool prefix3 = account.accountNumber?.substring(0, 0) != "3";
        bool isCOD = account.accountService?.toUpperCase() == 'COD';
        print("isCOD: $isCOD");
        print("isPrefix3: $prefix3");
        num getVat = isCOD && prefix3 ? freightCharge * vat : 0;

        getCodFeeMinimum = (freightCharge + goodsAmount) * codfee;
        getCodAmountMinimum = goodsAmount + freightCharge + getCodFeeMinimum + getVat;

        //cod amount text >= cod amount minimum
        /*tanpa harga barang
        * 1. codAmountMinimum = ongkir + (ongkir *vat) + (ongkir * codfee)
        * 2. codAmount = HB + ongkir + (ongkir * vat) + (ongkir + harga barang * fee)
        */

        getCodFee = (goodsAmount + freightCharge) * codfee;
        getCodAmount = (goodsAmount + getCodFee + getVat);
        // getCodAmount = goodsAmount + getVat + getCodFee;

        // hargacod = (codfee * (goodsAmount) + (goodsAmount) + totalOngkir);
        hargacod = isCOD ? getCodAmount : 0;
        codAmountText.text = isCOD ? getCodAmountMinimum.toInt().toCurrency().toString() : '0';
        hargacCODOngkir = freightCharge + (asuransi ? isr : 0) + 1000;
        hargacCODOngkirISR = freightCharge + isr;
        update();

        totalOngkir = codOngkir && account.accountService == "JLC"
            ? hargacCODOngkir.toInt()
            : asuransi
                ? (freightChargeISR.toInt() + hargacod)
                : (freightCharge.toInt() + hargacod);

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
        //   )
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
    update();
    // print("freightCharge${freightCharge}");
    try {
      var value = await transaction.getTransactionFee(
        DataTransactionFeeModel(
            destinationCode: destination.destinationCode,
            originCode: origin.originCode,
            serviceCode: selectedService?.serviceCode,
            weight: beratKiriman.text == '' ? 1 : beratKiriman.text.split('.').first.toInt(),
            custNo: account.accountNumber,
            type: jenisBarang.text == "PAKET" ? "PAKET" : "DOCUMENT"),
      );

      flatRate = value.payload?.flatRate?.toInt() ?? 0;
      freightCharge = value.payload?.freightCharge?.toInt() ?? 0;
      print("freightCharge${freightCharge}");
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
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
    connection.isOnline().then((value) => isOnline = value);
    jenisBarang.text = "PAKET";
    update();
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
    } catch (e, i) {
      e.printError();
      i.printError();
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
      berat = dataEdit?.goods?.weight?.toDouble() ?? 0;
      // ServiceModel servicecode = serviceList.where((element) => element.serviceCode == dataEdit?.delivery?.serviceCode).first;
      ServiceModel? servicedisplay = serviceList.where((element) => element.serviceDisplay == dataEdit?.delivery?.serviceCode).isNotEmpty
          ? serviceList.where((element) => element.serviceDisplay == dataEdit?.delivery?.serviceCode).first
          : ServiceModel();
      selectedService = servicedisplay;

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
        codFlag: account.accountService == "COD"
            ? "YES"
            : codOngkir
                ? "YES"
                : "NO",
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
            transition: Transition.rightToLeft,
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
            codFlag: account.accountService == "COD"
                ? "YES"
                : codOngkir
                    ? "YES"
                    : "NO",
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
        if (v.code != 200) {
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
                transition: Transition.rightToLeft,
                arguments: {
                  'awb': v.payload?.awb,
                },
              ),
              thirdButtonTitle: "Lihat Transaksi",
              thirdAction: () => Get.offAll(const RiwayatKirimanScreen(), arguments: {"isLastScreen": true}),
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

    // muncul popup kalo coud amount text <= cod amount minimum
    try {
      await transaction
          .postTransaction(DataTransactionModel(
        delivery: Delivery(
          serviceCode: selectedService?.serviceDisplay,
          woodPackaging: packingKayu ? "Y" : "N",
          specialInstruction: intruksiKhusus.text,
          codFlag: account.accountService == "COD"
              ? "YES"
              : codOngkir
                  ? "YES"
                  : "NO",
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
        if (v.code == 400 || v.code == 500) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: warningColor,
              ),
              message: v.error?.first.message?.tr ?? v.message,
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
                transition: Transition.rightToLeft,
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

  onChangeAccount(Account result) {
    account = result;
    selectedService = null;
    update();
    initData();
    update();
    getOngkir();
    account.accountNumber.printInfo(info: "account number");

    print("origin: ${origin.originCode}");
    print("destination: ${destination.destinationCode}");
  }

  onChangeCodAmountText(String value) {
    if (value.toInt() <= getCodAmountMinimum) {}
  }

  void onSaved() {
    if (codAmountText.text.digitOnly().toInt() < getCodAmountMinimum) {
      Get.dialog(StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          scrollable: false,
          title: const Icon(
            Icons.dangerous_outlined,
            color: errorColor,
            size: 100,
          ),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Error".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "${'Harga COD tidak boleh kurang dari'.tr} Rp.${getCodAmountMinimum.toInt().toCurrency()}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              CustomFilledButton(
                color: blueJNE,
                width: Get.width / 3,
                title: "OK".tr,
                onPressed: () => Get.back(),
              )
            ],
          ),
        ),
      ));
    } else {
      isValidate()
          ? dataEdit == null
              ? saveTransaction()
              : updateTransaction()
          : null;
    }
  }
}
