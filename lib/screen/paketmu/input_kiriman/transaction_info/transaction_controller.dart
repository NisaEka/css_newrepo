import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/routes/route_page.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_controller.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_state.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/items/package_info_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends BaseController {
  final state = TransactionState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      initData(),
    ]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        AppLogger.i('isOnline : $value $result');
        state.isOnline = value && (result != ConnectivityResult.none);
        if (state.isOnline) {
          // AppSnackBar.success('Online Mode'.tr);
        }
      });

      update();
    }));
  }

  void hitungBerat(double p, double l, double t) {
    state.isCalculate = true;
    state.berat = 0;
    update();

    if (state.dimension) {
      if (state.selectedService?.serviceCode?.contains("JTR") == true) {
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
        state.flatRateISR = state.flatRate + state.isr;
        state.freightChargeISR = state.freightCharge + state.isr;
        update();
        bool prefix3 = state.account.accountNumber?.substring(0, 1) != "3";
        state.isCOD = state.account.accountService?.toUpperCase() == 'COD';

        try {
          await transaction
              .postCalcOngkir(
            DataTransactionOngkirModel(
              goodsAmount: goodsAmount == 0 ? 0 : goodsAmount,
              isIsr: state.insurance,
              ongkir: state.freightCharge,
              accountNumber: state.account.accountNumber,
              isCod: state.isCOD,
              codFee: state.codfee,
              isCongkir: state.codOngkir,
              isPrefix3: prefix3,
            ),
          )
              .then((value) {
            AppLogger.d('transaction ongkir : ${value.data?.toJson()}');
            state.getCodAmountMinimum = state.isCOD ? value.data?.codAmountMinimum ?? 0 : 0;
            state.codAmount = state.isCOD ? value.data?.codAmountMinimum ?? 0 : 0;
            state.getCodAmount = state.isCOD ? value.data?.codAmountMinimum ?? 0 : 0;
            state.getCodFee = value.data?.codFee ?? 0;
            state.congkirAmount = value.data?.codOngkirAmount ?? 0;
            state.codAmountText.text = state.isCOD ? value.data?.codAmountMinimum?.toInt().toCurrency().toString() ?? '0' : '0';
            state.totalOngkir = state.codOngkir && state.account.accountService == "JLC" ? state.congkirAmount.toInt() : value.data?.totalOngkir ?? 0;
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
      state.isShowDialog = (state.totalOngkir > 1000000) && state.codOngkir;
      update();

      isValidate();
      state.isCalculate = false;
      update();
    }

    state.formValidate = state.formKey.currentState?.validate() ?? false;
    update();
  }

  bool isValidate() {
    if (state.formValidate && (state.selectedService?.serviceDisplay?.isNotEmpty ?? false) && !state.isCalculate) {
      if ((state.totalOngkir > 1000000) && state.codOngkir) {
        AppLogger.w('total ongkir : ${state.totalOngkir}');
        return false;
      }

      return true;
    }
    AppLogger.w('form validate : ${state.formValidate}');
    AppLogger.w('selected service : ${state.selectedService?.serviceDisplay?.isNotEmpty ?? false}');

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
    try {
      var value = await master.getServices(
        DataServiceModel(
          accountNumber: state.account.accountNumber,
          originCode: state.origin.originCode,
          destinationCode: state.destination.destinationCode,
          weight: state.weight.text.isNotEmpty ? state.weight.text.toDouble() : 1,
        ),
      );

      if (state.selectedService?.serviceDisplay?.substring(0, 3) == "JTR") {
        state.freightCharge = value.data?.resultJtr?.where((e) => e.serviceCode == state.selectedService?.serviceCode).first.price?.toInt() ?? 0;
      } else {
        state.freightCharge = value.data?.resultExpress?.where((e) => e.serviceCode == state.selectedService?.serviceCode).first.price?.toInt() ?? 0;
      }
      update();
    } catch (e, i) {
      AppLogger.e('error get ongkir $e, $i');
      if (state.selectedService == null && state.isOnline) {
        AppSnackBar.custom(
          message: 'Service harus diisi'.tr,
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
          margin: const EdgeInsets.only(bottom: 0),
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
        accountNumber: state.account.accountNumber,
        originCode: state.origin.originCode,
        destinationCode: state.destination.destinationCode,
      ))
          .then((value) {
        state.serviceList.addAll(value.data?.resultExpress ?? []);
        state.serviceList.addAll(value.data?.resultJtr ?? []);
        update();
        if ((value.data?.resultExpress?.isEmpty ?? false) && (value.data?.resultJtr?.isEmpty ?? false)) {
          AppSnackBar.error('Service tidak tersedia'.tr);
        }
        if (value.code != 200) {
          if (value.code == 400) {
            AppSnackBar.error("Service tidak tersedia".tr);
          } else {
            AppSnackBar.error(value.message.toString());
            state.isOnline = false;
            update();
          }
          update();
        }
      });
      getCODfee();
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }
    if (state.data != null) {
      state.goodType.text = state.data?.goods?.type ?? '';
      state.goodName.text = state.data?.goods?.desc ?? '';
      state.noReference.text = state.data?.orderId ?? '';
      state.goodAmount.text = state.data?.goods?.amount?.toInt().toCurrency().toString() ?? '';
      state.goodQty.text = state.data?.goods?.quantity.toString() ?? '';
      state.insurance = state.data?.delivery?.insuranceFlag == "Y";
      state.specialInstruction.text = state.data?.delivery?.specialInstruction ?? '';
      state.woodPacking = state.data?.delivery?.woodPackaging == "Y";
      state.weight.text = state.data?.goods?.weight.toString() ?? '';
      state.berat = state.data?.goods?.weight?.toDouble() ?? 0;
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

    loadTemp();
  }

  Future<void> loadTemp() async {
    state.tempData = DataTransactionModel.fromJson(await storage.readData(StorageCore.transactionTemp));
    if (state.tempData?.goods != null) {
      state.goodName.text = state.tempData?.goods?.desc ?? '';
      state.goodType.text = state.tempData?.goods?.type ?? 'PAKET';
      state.goodAmount.text = state.tempData?.goods?.amount?.toInt().toCurrency().toString() ?? '';
      state.goodQty.text = state.tempData?.goods?.quantity?.toString() ?? '';
      state.insurance = state.tempData?.delivery?.insuranceFlag == "Y" ? true : false;
      state.specialInstruction.text = state.tempData?.delivery?.specialInstruction ?? '';
      state.woodPacking = state.tempData?.delivery?.woodPackaging == "Y" ? true : false;
      state.weight.text = state.tempData?.goods?.weight?.toString().split('.').first ?? '';
      update();
    }
  }

  Future<void> saveDraft() async {
    state.isLoading = true;
    update();
    state.draftList = [];
    DraftTransactionModel temp = DraftTransactionModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    state.draftList.addAll(temp.draft);
    var draftItem = DataTransactionModel(
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
        codFee: state.isCOD || state.codOngkir ? state.codAmountText.text.digitOnly().toInt() : null,
        flatRateWithInsurance: state.flatRateISR,
        freightCharge: state.freightCharge,
        freightChargeWithInsurance: state.freightChargeISR,
      ),
      account: state.account,
      dataAccount: state.account,
      dataDestination: state.destination,
      origin: state.origin,
      destination: state.destination,
      goods: Goods(
        type: state.goodType.text,
        desc: state.goodName.text,
        amount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : 0,
        quantity: state.goodQty.text.toInt(),
        weight: state.berat,
      ),
      shipper: state.shipper,
      receiver: state.receiver,
    );
    state.draftList.add(draftItem);

    var data = '{"draft" : ${jsonEncode(state.draftList)}}';
    state.draftData = DraftTransactionModel.fromJson(jsonDecode(data));

    state.goods != null ? deleteDraft(state.draftIndex!) : null;

    await storage.saveData(StorageCore.draftTransaction, state.draftData).then(
          (_) => Get.offAll(
            _successScreen(
              isDraft: true,
              lottie: ImageConstant.warningLottie,
              message: 'Transaksi di simpan ke draft'.tr,
              iconMargin: 150,
              iconHeight: 400,
              data: TransactionModel(
                awb: draftItem.awb,
                goodsDesc: draftItem.goods?.desc,
                weight: draftItem.goods?.weight,
                originDesc: draftItem.origin?.originName,
                destinationDesc: draftItem.destination?.cityName,
              ),
            ),
          ),
        );

    state.isLoading = false;
    update();
  }

  Future<void> saveTemp() async {
    state.formKey.currentState?.validate();
    state.formValidate = state.formKey.currentState?.validate() ?? false;

    update();
    var delivery = Delivery(
      serviceCode: state.selectedService?.serviceCode,
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
    );

    var goods = Goods(
      type: state.goodType.text,
      desc: state.goodName.text,
      amount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : null,
      quantity: state.goodQty.text.isNotEmpty ? state.goodQty.text.toInt() : null,
      weight: state.weight.text.isNotEmpty ? state.weight.text.toInt() : null,
    );

    var temp = state.tempData?.copyWith(
      delivery: delivery,
      goods: goods,
    );
    await storage.saveData(StorageCore.transactionTemp, temp);
  }

  Future<void> updateTransaction() async {
    state.isLoading = true;
    update();

    try {
      await transaction
          .putTransaction(
        TransactionModel(
          apiType: state.account.accountService,
          serviceCode: state.selectedService?.serviceDisplay,
          packingkayuFlag: state.woodPacking ? "Y" : "N",
          specialIns: state.specialIns,
          codFlag: state.account.accountService == "COD"
              ? "YES"
              : state.codOngkir
                  ? "YES"
                  : "NO",
          codOngkir: state.codOngkir ? "YES" : "NO",
          insuranceFlag: state.insurance ? "Y" : "N",
          insuranceAmount: state.insurance ? state.isr : 0,
          deliveryPrice: state.freightCharge,
          deliveryPricePublish: state.freightCharge,
          codAmount: state.isCOD || state.codOngkir ? state.codAmountText.text.digitOnly().toInt() : null,
          custId: state.account.accountNumber,
          originCode: state.origin.originCode,
          originDesc: state.origin.originName,
          branch: state.origin.branchCode ?? state.origin.branch?.branchCode,
          destinationCode: state.destination.destinationCode,
          type: state.goodType.text,
          goodsDesc: state.goodName.text,
          goodsAmount: state.goodAmount.text.digitOnly().toInt(),
          qty: state.goodQty.text.toInt(),
          weight: state.berat,
          orderId: state.noReference.text,
          shipperName: state.shipper.name,
          shipperPhone: state.shipper.phone,
          shipperAddr: state.shipper.address,
          shipperAddr1: state.shipper.address1,
          shipperAddr2: state.shipper.address2,
          shipperAddr3: state.shipper.address3,
          shipperCity: state.shipper.city,
          shipperContact: state.shipper.contact,
          shipperCountry: state.shipper.country,
          shipperRegion: state.shipper.region?.name,
          shipperZip: state.shipper.zipCode,
          receiverName: state.receiver.name,
          receiverPhone: state.receiver.phone,
          receiverContact: state.receiver.contact,
          receiverAddr: state.receiver.address,
          receiverZip: state.receiver.zipCode,
          receiverRegion: state.receiver.region,
          receiverCity: state.receiver.city,
          receiverDistrict: state.receiver.district,
          receiverSubdistrict: state.receiver.subDistrict,
          receiverCountry: state.receiver.country,
          goodsType: state.goodType.text.isNotEmpty ? state.goodType.text : "PAKET",
        ),
        state.data?.awb ?? '',
      )
          .then((v) {
        if (v.code != 200) {
          AppSnackBar.error(v.message);
        } else {
          Get.offAll(_successScreen(
            data: v.data,
            message: 'Update Berhasil'.tr,
          ));
        }
      });
    } catch (e, i) {
      e.printError();
      i.printError();
    }
    state.isLoading = false;
    update();
  }

  Future<void> saveTransaction() async {
    state.isLoading = true;
    update();

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
      account: state.account,
      origin: state.origin,
      destination: state.destination,
      goods: Goods(
          type: state.goodType.text,
          desc: state.goodName.text,
          amount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : null,
          quantity: state.goodQty.text.toInt(),
          weight: state.berat),
      shipper: state.shipper,
      receiver: state.receiver,
    );
    try {
      await transaction
          .postTransaction(
        TransactionModel(
          orderId: state.noReference.text.isNotEmpty ? state.noReference.text : null,
          apiType: trans.account?.accountService,
          custId: state.account.accountNumber,
          branch: trans.origin?.branchCode ?? trans.origin?.branch?.branchCode,
          codAmount: state.isCOD || state.codOngkir ? state.codAmountText.text.digitOnly().toInt() : null,
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
          deliveryPrice: state.freightCharge,
          deliveryPricePublish: state.freightCharge,
          destinationCode: trans.receiver?.destinationCode,
          goodsAmount: state.goodAmount.text.isNotEmpty ? state.goodAmount.text.digitOnly().toInt() : null,
          goodsDesc: state.goodName.text,
          goodsType: state.goodType.text.isNotEmpty ? state.goodType.text : "PAKET",
          qty: state.goodQty.text.toDouble(),
          insuranceAmount: state.insurance ? state.isr : 0,
          insuranceFlag: state.insurance ? "Y" : "N",
          originCode: trans.origin?.originCode,
          originDesc: trans.origin?.originName,
          packingkayuFlag: state.woodPacking ? "Y" : "N",
          receiverAddr: trans.receiver?.address,
          receiverCity: trans.receiver?.city,
          receiverCountry: trans.receiver?.country,
          receiverDistrict: trans.receiver?.district,
          receiverSubdistrict: trans.receiver?.subDistrict,
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
          shipperName: (trans.shipper?.name?.length ?? 0) > 20 ? trans.shipper?.name?.substring(0, 20) : trans.shipper?.name,
          shipperPhone: trans.shipper?.phone,
          shipperAddr: trans.shipper?.address,
          shipperCity: trans.shipper?.city,
          shipperZip: trans.shipper?.zipCode,
          shipperContact: (trans.shipper?.contact?.length ?? 0) > 20 ? trans.shipper?.contact?.substring(0, 20) : trans.shipper?.contact,
          shipperRegion: trans.shipper?.region?.name ?? trans.origin?.branch?.region?.name,
          shipperCountry: trans.shipper?.country,
          shipperAddr1: trans.shipper?.address1,
          shipperAddr2: trans.shipper?.address2,
          shipperAddr3: trans.shipper?.address3,
          specialIns: state.specialIns,
          weight: state.berat,
        ),
      )
          .then((v) {
        if (state.goods != null) {
          deleteDraft(state.draftIndex!);
        }
        if (v.code == 400 || v.code == 500) {
          AppSnackBar.error(v.error?.first ?? v.message);
        } else {
          Get.offAll(_successScreen(
            data: v.data ?? TransactionModel(),
            message: 'Transaksi Berhasil'.tr,
          ));
        }
      });
    } catch (e, i) {
      e.printError();
      i.printError(info: "error post transaction");
      AppLogger.e("anda telah offline, transaksi akan disimpan ke draft");
      saveDraft();
    }
    state.isLoading = false;
    update();
  }

  onChangeAccount(TransAccountModel result) {
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

  Future<void> onSaved() async {
    if ((state.codAmountText.text.digitOnly().toInt() < state.getCodAmountMinimum)) {
      Get.dialog(StatefulBuilder(
        builder: (context, setState) => DefaultAlertDialog(
          icon: const Icon(
            Icons.dangerous_outlined,
            color: errorColor,
            size: 100,
          ),
          subtitle: "${'Harga COD tidak boleh kurang dari'.tr} Rp.${state.getCodAmountMinimum.toInt().toCurrency()}",
          confirmButtonTitle: "OK",
          onConfirm: Get.back,
        ),
      ));
    } else if ((state.goodQty.text.digitOnly().toInt() > 1) && state.selectedService?.serviceDisplay == "INTL") {
      Get.dialog(StatefulBuilder(
        builder: (context, setState) => DefaultAlertDialog(
          icon: const Icon(
            Icons.dangerous_outlined,
            color: errorColor,
            size: 100,
          ),
          subtitle: "${'Maksimal Jumlah Packing adalah 1'.tr} ",
          confirmButtonTitle: "OK",
          onConfirm: Get.back,
        ),
      ));
    } else if ((state.codAmountText.text.digitOnly().toInt() > 10000000)) {
      Get.dialog(StatefulBuilder(
        builder: (context, setState) => DefaultAlertDialog(
          icon: const Icon(
            Icons.dangerous_outlined,
            color: errorColor,
            size: 100,
          ),
          subtitle: "${'Harga COD tidak boleh lebih dari'.tr} Rp.10.000.000",
          confirmButtonTitle: "OK",
          onConfirm: Get.back,
        ),
      ));
    } else {
      if (isValidate()) {
        storage.deleteString(StorageCore.transactionTemp);
        (state.isEdit ?? false) ? updateTransaction() : saveTransaction();
      }
    }
  }

  void onSelectService(int index) {
    state.selectedService = state.serviceList[index];
    if (state.selectedService?.serviceDisplay == 'INTL') {
      state.isSelectGoodsType = true;
      state.goodType.text = state.selectedService?.goodsType == 'Paket' ? 'PAKET' : 'DOKUMEN';
    }

    getOngkir();
    state.formValidate = state.formKey.currentState?.validate() ?? false;
    update();
  }

  Widget _successScreen({
    TransactionModel? data,
    bool? isDraft,
    String? lottie,
    double? iconMargin,
    double? iconHeight,
    String? message,
  }) {
    return SuccessScreen(
      lottie: lottie ?? ImageConstant.successLottie,
      iconMargin: iconMargin ?? 100,
      customInfo: PackageInfoItem(
        data: data ?? TransactionModel(),
        message: message ?? "Transaksi Berhasil".tr,
      ),
      iconHeight: iconHeight ?? Get.width * 0.3,
      customAction: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomFilledButton(
              color: blueJNE,
              title: (isDraft ?? false) ? "Lihat Draft".tr : "Lihat Detail".tr,
              suffixIcon: Icons.qr_code_rounded,
              width: Get.width / 2,
              height: 50,
              fontSize: 15,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              onPressed: () {
                Get.to(() => (isDraft ?? false) ? const DraftTransaksiScreen() : const DetailTransactionScreen(), arguments: {
                  'awb': data?.awb,
                  'data': data?.copyWith(statusAwb: 'MASIH DI KAMU'),
                  'fromMenu': false,
                })?.then((_) => Get.offAll(() => const DashboardScreen()));
              }),
          CustomFilledButton(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            color: successColor,
            isTransparent: true,
            prefixIcon: Icons.add_circle,
            width: 50,
            height: 50,
            fontSize: 23,
            onPressed: () => Get.delete<ShipperController>().then((_) => Get.offAllNamed(Routes.inputKiriman)),
          ),
          CustomFilledButton(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            color: infoColor,
            isTransparent: true,
            prefixIcon: Icons.home,
            width: 50,
            height: 50,
            fontSize: 23,
            onPressed: () => Get.offAll(() => const DashboardScreen()),
          ),
        ],
      ),
    );
  }
}
