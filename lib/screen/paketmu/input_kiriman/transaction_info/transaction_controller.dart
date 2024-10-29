import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_controller.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_state.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends BaseController {
  final state = TransactionState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        state.isOnline = value && (result != ConnectivityResult.none);
        update();
        if (state.isOnline) {
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

  void hitungBerat(double p, double l, double t) {
    state.isCalculate = true;
    state.berat = 0;
    update();

    if (state.dimension) {
      if (state.selectedService?.serviceCode?.contains("JTR") == true) {
        // if (state.selectedService?.serviceCode == "JTR23" ||
        //     state.selectedService?.serviceCode == "JTR<130" ||
        //     state.selectedService?.serviceCode == "JTR250" ||
        //     state.selectedService?.serviceCode == "JTR>250") {

        state.berat = (p * l * t) / 5000;
      } else {
        state.berat = (p * l * t) / 6000;
      }

      String b = "0.${state.berat.toStringAsFixed(2).split('.').last}";

      if (state.berat < 1) {
        state.weight.text = '1';
      } else if (b.toDouble() >= 0.31) {
        state.weight.text = state.berat.ceil().toString();
      } else {
        state.weight.text = state.berat.truncate().toString();
      }
      // state.state.beratKiriman.text = state.berat!.toStringAsFixed(2);
    }
    update();
    getOngkir();

    update();
  }

  void hitungOngkir() async {
    state.totalOngkir = 0;
    state.isr = 0;
    double vat = (1.1 / 100);
    state.isr = (0.002 * (state.goodAmount.text == '' ? 0 : state.goodAmount.text.digitOnly().toInt())) + 5000;
    state.flatRateISR = state.flatRate + state.isr;
    state.freightChargeISR = state.freightCharge + state.isr;
    state.getInsurance = state.insurance ? state.isr : 0;
    update();
    int goodsAmount = state.goodAmount.text == '' ? 0 : state.goodAmount.text.digitOnly().toInt();

    if (state.isOnline) {
      state.isCalculate = true;
      update();
      if (state.isOnline) {
        // if (state.asuransi) {
        // state.isr = (0.002 * (state.hargaBarang.text == '' ? 0 : state.hargaBarang.text.digitOnly().toInt())) + 5000;
        state.flatRateISR = state.flatRate + state.isr;
        state.freightChargeISR = state.freightCharge + state.isr;
        update();
        // }
        bool prefix3 = state.account.accountNumber?.substring(0, 1) != "3";
        state.isCOD = state.account.accountService?.toUpperCase() == 'COD';

        try {
          await transaction
              .postCalcOngkir(DataTransactionOngkirModel(
            goodsAmount: goodsAmount,
            isIsr: state.insurance,
            ongkir: state.freightCharge,
            accountNumber: state.account.accountNumber,
            isCod: state.isCOD,
            codFee: state.codfee,
            isCongkir: state.codOngkir,
            isPrefix3: prefix3,
          ))
              .then((value) {
            print('transaction ongkir : ${value.toJson()}');
            state.getCodAmountMinimum = value.data?.codAmountMinimum ?? 0;
            state.congkirAmount = value.data?.codOngkirAmount ?? 0;
            state.codAmount = value.data?.codAmountMinimum ?? 0;
            state.totalOngkir = state.codOngkir && state.account.accountService == "JLC" ? state.congkirAmount.toInt() : value.data?.totalOngkir ?? 0;
            state.getCodAmount = value.data?.codAmountMinimum ?? 0;
            state.codAmountText.text = value.data?.codAmountMinimum?.toInt().toCurrency().toString() ?? '0';
            state.getCodFee = value.data?.codFee ?? 0;
          });
        } catch (e) {
          num getVat = state.isCOD && prefix3 ? state.freightCharge * vat : 0;
          state.getCodFeeMinimum = (state.freightCharge + goodsAmount) * state.codfee;
          state.getCodAmountMinimum = goodsAmount + state.freightCharge + state.getCodFeeMinimum + getVat;

          //cod amount text >= cod amount minimum
          /*tanpa harga barang
        * 1. codAmountMinimum = ongkir + (ongkir *vat) + (ongkir * codfee)
        * 2. codAmount = HB + ongkir + (ongkir * vat) + (ongkir + harga barang * fee)
        */

          state.getCodFee = (goodsAmount + state.freightCharge) * state.codfee;
          state.getCodAmount = (goodsAmount + state.getCodFee + getVat);
          // state.getCodAmount = goodsAmount + getVat + state.getCodFee;

          // state.hargacod = (codfee * (goodsAmount) + (goodsAmount) + state.totalOngkir);
          state.codAmount = state.isCOD ? state.getCodAmount : 0;
          state.codAmountText.text = state.isCOD ? state.getCodAmountMinimum.toInt().toCurrency().toString() : '0';
          state.congkirAmount = state.freightCharge + (state.insurance ? state.isr : 0) + 1000;
          state.congkirAmountISR = state.freightCharge + state.isr;
          update();
          state.totalOngkir = state.codOngkir && state.account.accountService == "JLC"
              ? state.congkirAmount.toInt()
              : state.insurance
                  ? (state.freightChargeISR.toInt() + state.codAmount)
                  : (state.freightCharge.toInt() + state.codAmount);
        }

        update();
      }
      state.isShowDialog = (state.totalOngkir > 1000000);
      update();

      isValidate();

      state.isCalculate = false;
      update();
    }
  }

  bool isValidate() {
    if (state.formValidate && state.selectedService != null && !state.isCalculate && state.totalOngkir <= 1000000) {
      return true;
    }

    return false;
  }

  Future<void> getCODfee() async {
    if (state.isOnline && state.account.accountService == "COD") {
      state.isCalculate = true;
      try {
        await transaction.getCODFee(state.account.accountId.toString()).then(
          (value) {
            state.codfee = value.data?.disc?.toDouble() ?? 0;
            update();
          },
        );
        state.isCalculate = false;

        update();
      } catch (e) {
        e.printError();
      }
    }
  }

  Future<void> getOngkir() async {
    state.isCalculate = state.isOnline ? true : false;
    update();
    // print("state.freightCharge${state.freightCharge}");
    try {
      var value = await master.getServices(
        DataServiceModel(
          destinationCode: state.destination.destinationCode,
          originCode: state.origin.originCode,
          // serviceCode: state.selectedService?.serviceCode,
          weight: state.weight.text.isNotEmpty ? state.weight.text.toDouble() : 1,
          accountId: state.account.accountNumber,
          // custNo: state.account.accountNumber,
          // type: state.goodType.text == "PAKET" ? "PAKET" : "DOCUMENT"),
        ),
      );

      // state.flatRate = value.data?.where((e)=> e == state.selectedService).first.price?.toInt() ?? 0;
      state.freightCharge = value.data?.where((e) => e.serviceCode == state.selectedService?.serviceCode).first.price?.toInt() ?? 0;
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
      String message;
      if (state.selectedService == null && state.isOnline) {
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
    state.draftList = [];
    DraftTransactionModel temp = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    state.draftList.addAll(temp.draft);

    state.goodName.text = state.goods?.desc ?? '';
    state.goodType.text = state.goods?.type ?? '';
    state.goodAmount.text = state.goods?.amount?.toInt().toCurrency().toString() ?? '';
    state.goodQty.text = state.goods?.quantity.toString() ?? '';
    state.insurance = state.delivery?.insuranceFlag == "Y" ? true : false;
    state.specialInstruction.text = state.delivery?.specialInstruction ?? '';
    state.woodPacking = state.delivery?.woodPackaging == "Y" ? true : false;
    state.weight.text = state.goods?.weight.toString().split('.').first ?? '1';
    state.selectedService = state.serviceList.where((e) => e.serviceCode == state.delivery?.serviceCode).first;

    if (state.delivery?.flatRate != null) {
      getOngkir();
    }
    update();
  }

  void deleteDraft(int index) async {
    state.draftList.removeAt(index);
    var data = '{"draft" : ${jsonEncode(state.draftList)}}';
    state.draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    await storage.saveData(StorageCore.draftTransaction, state.draftData).then(
          (_) => update(),
        );
    // initData();

    update();
  }

  Future<void> initData() async {
    state.isServiceLoad = true;
    state.serviceList = [];
    connection.isOnline().then((value) => state.isOnline = value);
    state.goodType.text = "PAKET";
    update();
    try {
      await master
          .getServices(DataServiceModel(
        accountId: state.account.accountNumber,
        originCode: state.origin.originCode,
        destinationCode: state.destination.destinationCode,
      ))
          .then((value) {
        state.serviceList.addAll(value.data ?? []);
        update();
        if (value.data?.isEmpty ?? false) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.error,
                color: whiteColor,
              ),
              message: 'Service tidak tersedia'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: errorColor,
            ),
          );
        }
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
          // state.isOnline = false;
          update();
        }
      });
      getCODfee();
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
      // state.isOnline = false;
    }
    if (state.data != null) {
      state.goodType.text = state.data?.goods?.type ?? '';
      state.noReference.text = state.data?.orderId ?? '';
      state.noReference.text = state.data?.goods?.desc ?? '';
      state.goodAmount.text = state.data?.goods?.amount?.toInt().toCurrency().toString() ?? '';
      state.goodQty.text = state.data?.goods?.quantity.toString() ?? '';
      state.insurance = state.data?.delivery?.insuranceFlag == "Y";
      state.specialInstruction.text = state.data?.delivery?.specialInstruction ?? '';
      state.woodPacking = state.data?.delivery?.woodPackaging == "Y";
      state.weight.text = state.data?.goods?.weight.toString() ?? '';
      state.berat = state.data?.goods?.weight?.toDouble() ?? 0;
      // ServiceModel servicecode = state.serviceList.where((element) => element.serviceCode == state.dataEdit?.delivery?.serviceCode).first;
      ServiceModel? servicedisplay = state.serviceList.where((element) => element.serviceDisplay == state.data?.delivery?.serviceCode).isNotEmpty
          ? state.serviceList.where((element) => element.serviceDisplay == state.data?.delivery?.serviceCode).first
          : ServiceModel();
      state.selectedService = servicedisplay;

      update();
      getOngkir();
    }
    if (state.draft != null) {
      state.weight.text = state.draft?.goods?.weight.toString().split('.').first ?? '';
      update();
    }
    hitungOngkir();

    state.goods != null ? loadDraft() : null;
    state.isServiceLoad = false;
    update();
  }

  Future<void> saveDraft() async {
    state.isLoading = true;
    update();
    state.draftList = [];
    DraftTransactionModel temp = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    state.draftList.addAll(temp.draft);
    state.draftList.add(DataTransactionModel(
      createAt: state.goods == null ? DateTime.now().toString() : state.draft?.createAt,
      updateAt: DateTime.now().toString(),
      delivery: Delivery(
        serviceCode: state.selectedService?.serviceCode,
        woodPackaging: state.woodPacking ? "Y" : "N",
        specialInstruction: state.specialInstruction.text,
        codFlag: state.account.accountService == "COD"
            ? "YES"
            : state.codOngkir
                ? "YES"
                : "NO",
        codOngkir: state.codOngkir ? "YES" : "NO",
        insuranceFlag: state.insurance ? "Y" : "N",
        insuranceFee: state.isr,
        flatRate: state.flatRate,
        codFee: state.codfee,
        flatRateWithInsurance: state.flatRateISR,
        freightCharge: state.freightCharge,
        freightChargeWithInsurance: state.freightChargeISR,
      ),
      account: Account(
        accountNumber: state.account.accountNumber,
        accountService: state.account.accountService,
      ),
      origin: state.origin,
      destination: state.destination,
      // destination: Destination(code: state.destination.destinationCode, desc: state.destination.cityName),
      goods: Goods(
          type: state.goodType.text,
          desc: state.goodName.text,
          amount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : 0,
          quantity: state.goodQty.text.toInt(),
          weight: state.berat != 0 ? state.berat : state.weight.text.toInt()),
      shipper: state.shipper,
      receiver: state.receiver,
      dataAccount: state.account,
      dataDestination: state.destination,
    ));

    var data = '{"draft" : ${jsonEncode(state.draftList)}}';
    state.draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    state.goods != null ? deleteDraft(state.draftIndex!) : null;

    await storage.saveData(StorageCore.draftTransaction, state.draftData).then(
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

    state.isLoading = false;
    update();
  }

  Future<void> updateTransaction() async {
    state.isLoading = true;
    update();

    try {
      await transaction
          .putTransaction(
        DataTransactionModel(
          delivery: Delivery(
            serviceCode: state.selectedService?.serviceDisplay,
            woodPackaging: state.woodPacking ? "Y" : "N",
            specialInstruction: state.specialInstruction.text,
            codFlag: state.account.accountService == "COD"
                ? "YES"
                : state.codOngkir
                    ? "YES"
                    : "NO",
            codOngkir: state.codOngkir ? "YES" : "NO",
            insuranceFlag: state.insurance ? "Y" : "N",
            insuranceFee: state.isr,
            flatRate: state.flatRate,
            codFee: state.codfee,
            flatRateWithInsurance: state.flatRateISR,
            freightCharge: state.freightCharge,
            freightChargeWithInsurance: state.freightChargeISR,
          ),
          account: Account(
            accountNumber: state.account.accountNumber,
            accountService: state.account.accountService,
          ),
          origin: state.origin,
          destination: state.destination,
          // destination: Destination(code: state.destination.destinationCode, desc: state.destination.cityName),
          goods: Goods(
              type: state.goodType.text,
              desc: state.goodName.text,
              amount: state.goodAmount.text.digitOnly().toInt(),
              quantity: state.goodQty.text.toInt(),
              weight: state.berat),
          shipper: state.shipper,
          receiver: state.receiver,
        ),
        state.data?.awb ?? '',
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
    state.isLoading = false;
    update();
  }

  Future<void> saveTransaction() async {
    state.isLoading = true;
    update();

    // muncul popup kalo coud amount text <= cod amount minimum
    var trans = DataTransactionModel(
      delivery: Delivery(
        serviceCode: state.selectedService?.serviceDisplay,
        woodPackaging: state.woodPacking ? "Y" : "N",
        specialInstruction: state.specialInstruction.text,
        codFlag: state.account.accountService == "COD"
            ? "YES"
            : state.codOngkir
                ? "YES"
                : "NO",
        codOngkir: state.selectedService?.serviceDisplay == 'INTL'
            ? 'NO'
            : state.codOngkir
                ? "YES"
                : "NO",
        insuranceFlag: state.insurance ? "Y" : "N",
        insuranceFee: state.isr,
        flatRate: state.flatRate,
        codFee: state.codfee,
        flatRateWithInsurance: state.flatRateISR,
        freightCharge: state.freightCharge,
        freightChargeWithInsurance: state.freightChargeISR,
      ),
      account: Account(
        accountNumber: state.account.accountNumber,
        accountService: state.account.accountService,
      ),
      origin: state.origin,
      destination: state.destination,
      // destination: Destination(code: state.destination.destinationCode, desc: state.destination.cityName),
      goods: Goods(
          type: state.goodType.text,
          desc: state.goodName.text,
          amount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : 0,
          quantity: state.goodQty.text.toInt(),
          weight: state.berat),
      shipper: state.shipper,
      receiver: state.receiver,
    );
    try {
      await transaction
          .postTransaction(TransactionModel(
        apiType: trans.account?.accountService,
        custId: state.account.accountNumber,
        branch: state.account.accountBranch,
        codAmount: state.isCOD ? state.codAmountText.text.digitOnly().toInt() : null,
        codFlag: state.account.accountService == "COD"
            ? "YES"
            : state.codOngkir
                ? "YES"
                : "NO",
        codOngkir: state.selectedService?.serviceDisplay == 'INTL'
            ? 'NO'
            : state.codOngkir
                ? "YES"
                : "NO",
        // custId:
        deliveryPrice: state.freightCharge,
        deliveryPricePublish: state.freightCharge,
        destinationCode: trans.receiver?.destinationCode,
        goodsAmount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : 0,
        goodsDesc: state.goodName.text,
        goodsType: state.goodType.text,
        qty: state.goodQty.text.toDouble(),
        insuranceAmount: state.isr,
        insuranceFlag: state.insurance ? "Y" : "N",
        originCode: trans.origin?.originCode,
        originDesc: trans.origin?.originName,
        packingkayuFlag: state.woodPacking ? "Y" : "N",
        receiverAddr: trans.receiver?.address,
        receiverCity: trans.receiver?.city,
        receiverCountry: trans.receiver?.country,
        receiverDistrict: trans.receiver?.district,
        receiverSubdistrict: trans.receiver?.subdistrict,
        receiverRegion: trans.receiver?.region,
        receiverZip: trans.receiver?.zipCode,
        receiverAddr1:
            trans.receiver?.address?.substring(0, (trans.receiver?.address?.length ?? 0) > 30 ? 29 : (trans.receiver?.address?.length ?? 0)),
        receiverAddr2: (trans.receiver?.address?.length ?? 0) > 30
            ? trans.receiver?.address?.substring(30, (trans.receiver?.address?.length ?? 0) > 60 ? 59 : (trans.receiver?.address?.length ?? 0))
            : '',
        receiverAddr3:
            (trans.receiver?.address?.length ?? 0) >= 60 ? trans.receiver?.address?.substring(60, (trans.receiver?.address?.length ?? 0)) : '',
        receiverName: trans.receiver?.name,
        receiverPhone: trans.receiver?.phone,
        receiverContact: trans.receiver?.contact,
        serviceCode: state.selectedService?.serviceDisplay,
        shipperName: trans.shipper?.name,
        shipperPhone: trans.shipper?.phone,
        shipperAddr: trans.shipper?.address,
        shipperCity: trans.shipper?.city,
        shipperZip: trans.shipper?.zipCode,
        shipperContact: trans.shipper?.contact,
        shipperRegion: trans.shipper?.region?.name,
        shipperCountry: trans.shipper?.country,
        shipperAddr1: trans.shipper?.address1,
        shipperAddr2: trans.shipper?.address2,
        shipperAddr3: trans.shipper?.address3,
        specialIns: state.specialInstruction.text,
        weight: state.berat,
      ))
          .then((v) {
        if (state.goods != null) {
          deleteDraft(state.draftIndex!);
        }
        if (v.code == 400 || v.code == 500) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: warningColor,
              ),
              message: v.error?[0] ?? v.message,
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
              message: "${'Transaksi Berhasil'.tr}\n${v.data?.awb}",
              buttonTitle: "Kembali ke Beranda".tr,
              nextAction: () => Get.offAll(
                const DashboardScreen(),
                transition: Transition.rightToLeft,
                arguments: {
                  'awb': v.data?.awb,
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
      // saveDraft();
    }
    state.isLoading = false;
    update();
  }

  onChangeAccount(Account result) {
    state.account = result;
    state.selectedService = null;
    update();
    initData();
    update();
    getOngkir();
    state.account.accountNumber.printInfo(info: "account number");
  }

  onChangeCodAmountText(String value) {
    if (value.toInt() <= state.getCodAmountMinimum) {}
  }

  void onSaved() {
    if (state.codAmountText.text.digitOnly().toInt() < state.getCodAmountMinimum) {
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
                "${'Harga COD tidak boleh kurang dari'.tr} Rp.${state.getCodAmountMinimum.toInt().toCurrency()}",
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
          ? state.dataEdit == null
              ? saveTransaction()
              : updateTransaction()
          : null;
    }
  }
}
