import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_state.dart';
import 'package:css_mobile/screen/pengaturan/edit_profil/edit_profil_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ShipperController extends BaseController {
  final state = ShipperState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      initData(),
    ]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        state.isOnline = value && (result != ConnectivityResult.none);
        if (state.isOnline) {
          // AppSnackBar.success('Online Mode'.tr);
        }
        update();
      });
      update();
    }));
  }

  FutureOr<void> getSelectedDropshipper() async {
    state.shipperName.text = state.dropshipper?.name?.toUpperCase() ?? '';
    state.shipperPhone.text = state.dropshipper?.phone ?? '';
    state.shipperOrigin.text = state.dropshipper?.city?.toUpperCase() ?? '';
    state.shipperAddress.text = state.dropshipper?.address?.toUpperCase() ?? '';
    state.shipperZipCode.text = state.dropshipper?.zipCode ?? '';
    getOriginList(state.dropshipper?.originCode ?? '').then((value) {
      state.selectedOrigin = value
          .where(
              (element) => element.originCode == state.dropshipper?.originCode)
          .first;
      update();
    });
    AppLogger.i("selected dropshipper ${state.selectedOrigin?.toJson()}");

    update();
  }

  bool isSaveDropshipper() {
    if (state.dropshipper?.name != state.shipperName.text &&
        state.dropshipper?.phone != state.shipperPhone.text) {
      return true;
    }
    return false;
  }

  void formValidate() async {
    if (state.isOnline) {
      state.isValidate = state.formKey.currentState?.validate() == true &&
          state.selectedAccount != null &&
          state.selectedOrigin != null;
    } else {
      state.isValidate = state.formKey.currentState?.validate() == true &&
          state.selectedAccount != null;
    }

    update();

    state.locale = await storage.readString(StorageCore.localeApp);
    update();
    ValidationBuilder.setLocale(state.locale!);
  }

  Future<void> initData() async {
    state.accountList = [];
    state.selectedAccount = null;
    state.isLoading = true;
    connection.isOnline().then((value) => state.isOnline = value);
    state.shipper =
        ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
    state.userBasic =
        UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    state.tempData = DataTransactionModel.fromJson(
        await storage.readData(StorageCore.transactionTemp));
    var ccrf = await storage.readData(StorageCore.ccrfProfile);
    if (ccrf == '{}') {
      state.userCcrf = CcrfProfileModel.fromJson(ccrf);
    }

    update();
    try {
      await master
          .getAccounts(QueryModel(limit: 0, sort: [
            {"accountNumber": "asc"}
          ]))
          .then((value) => state.accountList.addAll(value.data ?? []));
      update();

      // var user = CcrfProfileModel.fromJson(await storage.readData(StorageCore.ccrfProfile));
      var resp = await profil.getShipper();
      ShipperModel shipper = resp.data?.isNotEmpty ?? false
          ? resp.data?.first ?? ShipperModel()
          : ShipperModel();
      AppLogger.i("shipper region : ${shipper.origin?.toJson()}");

      await profil.getCcrfProfil().then((ccrf) async {
        if (ccrf.data != null && state.userBasic?.userType == "PEMILIK") {
          state.userCcrf = ccrf.data;
          state.shipper = ShipperModel(
            name: ccrf.data?.generalInfo?.brand,
            region: shipper.origin?.branch?.region,
            origin: shipper.origin,
            zipCode: ccrf.data?.generalInfo?.zipCode,
            address: ccrf.data?.generalInfo?.address,
            phone: ccrf.data?.generalInfo?.phone,
            city: ccrf.data?.generalInfo?.city,
            country: ccrf.data?.generalInfo?.country,
            dropship: state.isDropshipper,
            contact: ccrf.data?.generalInfo?.name,
            address1: ccrf.data?.generalInfo?.address?.substring(
                0,
                (ccrf.data?.generalInfo?.address?.length ?? 0) > 30
                    ? 29
                    : (ccrf.data?.generalInfo?.address?.length ?? 0)),
            address2: (ccrf.data?.generalInfo?.address?.length ?? 0) > 30
                ? ccrf.data?.generalInfo?.address?.substring(
                    30,
                    (ccrf.data?.generalInfo?.address?.length ?? 0) > 60
                        ? 59
                        : (ccrf.data?.generalInfo?.address?.length ?? 0))
                : '',
            address3: (ccrf.data?.generalInfo?.address?.length ?? 0) >= 60
                ? ccrf.data?.generalInfo?.address?.substring(
                    60, (ccrf.data?.generalInfo?.address?.length ?? 0))
                : '',
          );
          state.shipperName.text = ccrf.data?.generalInfo?.brand ?? '';
          state.shipperPhone.text = ccrf.data?.generalInfo?.phone ?? '';
          state.shipperOrigin.text = shipper.origin?.originName ?? '';
          state.shipperZipCode.text = ccrf.data?.generalInfo?.zipCode ?? '';
          state.shipperAddress.text = ccrf.data?.generalInfo?.address ?? '';
          state.selectedOrigin = shipper.origin;
        } else {
          AppLogger.w("shipper ccrf is null");
          await profil.getBasicProfil().then((basic) {
            state.shipper = ShipperModel(
              name: ccrf.data?.generalInfo?.brand ?? basic.data?.user?.brand,
              phone: basic.data?.user?.phone,
              address: basic.data?.user?.address,
              zipCode: basic.data?.user?.zipCode,
              origin: basic.data?.user?.origin,
              region: basic.data?.user?.region?.name != null
                  ? basic.data?.user?.region
                  : basic.data?.user?.branch?.region?.name != null
                      ? basic.data?.user?.branch?.region
                      : basic.data?.user?.origin?.branch?.region,
              contact: basic.data?.user?.name,
              city: basic.data?.user?.origin?.originName,
              country: 'INDONESIA',
              dropship: state.isDropshipper,
              address1: basic.data?.user?.address?.substring(
                  0,
                  (basic.data?.user?.address?.length ?? 0) > 30
                      ? 29
                      : (basic.data?.user?.address?.length ?? 0)),
              address2: (basic.data?.user?.address?.length ?? 0) > 30
                  ? basic.data?.user?.address?.substring(
                      30,
                      (basic.data?.user?.address?.length ?? 0) > 60
                          ? 59
                          : (basic.data?.user?.address?.length ?? 0))
                  : '',
              address3: (basic.data?.user?.address?.length ?? 0) >= 60
                  ? basic.data?.user?.address
                      ?.substring(60, (basic.data?.user?.address?.length ?? 0))
                  : '',
            );
            state.shipperName.text =
                ccrf.data?.generalInfo?.brand ?? basic.data?.user?.brand ?? '';
            state.shipperPhone.text = basic.data?.user?.phone ?? '';
            state.shipperOrigin.text =
                basic.data?.user?.origin?.originName ?? '';
            state.shipperZipCode.text = basic.data?.user?.zipCode ?? '';
            state.shipperAddress.text = basic.data?.user?.address ?? '';
            state.selectedOrigin = basic.data?.user?.origin?.copyWith(
              branch: basic.data?.user?.branch,
            );
          });
        }
      });
      update();
    } catch (e, i) {
      AppLogger.e('error get shipper data $e');
      AppLogger.e('error get shipper data $i');
      AppLogger.w("shipper get from local");
      AppLogger.i("shipper basic local : ${state.userBasic?.toJson()}");

      state.accountList.clear();
      var accounts = BaseResponse<List<Account>>.fromJson(
        await storage.readData(StorageCore.accounts),
        (json) => json is List<dynamic>
            ? json
                .map<Account>(
                  (i) => Account.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
      AppLogger.i('accounts : ${accounts.toJson()}');
      state.accountList.addAll(accounts.data ?? []);
      state.shipperName.text = state.userBasic?.brand ?? '';
      state.shipperPhone.text = state.shipper?.phone ?? '';
      state.shipperOrigin.text = state.userBasic?.origin?.originName ?? '';
      state.shipperZipCode.text = state.shipper?.zipCode ?? '';
      state.shipperAddress.text = state.shipper?.address ?? '';
      state.selectedOrigin = OriginModel(
        originCode: state.userBasic?.origin?.originCode,
        branchCode: state.shipper?.origin?.branchCode,
        originName: state.shipper?.origin?.originName,
        branch: state.shipper?.origin?.branch?.branchCode?.isNotEmpty ?? false
            ? state.shipper?.origin?.branch
            : state.userBasic?.origin?.branch?.branchCode?.isNotEmpty ?? false
                ? state.userBasic?.origin?.branch
                : state.userBasic?.branch
                    ?.copyWith(region: state.userBasic?.region),
      );
    }

    state.isLoading = false;
    update();
    if (state.data != null) {
      state.shipper = state.data?.shipper;
      state.selectedAccount = state.accountList
          .where((element) =>
              element.accountNumber == state.data?.account?.accountNumber)
          .first;
      state.shipperName.text = state.data?.shipper?.name ?? '';
      state.shipperPhone.text = state.data?.shipper?.phone ?? '';
      state.shipperZipCode.text = state.data?.shipper?.zipCode ?? '';
      state.shipperAddress.text = state.data?.shipper?.address ?? '';
      state.isDropshipper = state.data?.shipper?.name != state.shipper?.name;
      getOriginList(state.data?.shipper?.origin?.originCode ?? '')
          .then((value) {
        state.selectedOrigin = value.first;
        state.shipperOrigin.text = value.first.originName ?? '';
        update();

        if (state.isDropshipper) {
          state.dropshipper = DropshipperModel(
            name: state.data?.shipper?.name,
            address: state.data?.shipper?.address,
            city: state.data?.shipper?.city,
            phone: state.data?.shipper?.phone,
            zipCode: state.data?.shipper?.zipCode,
            originCode: state.selectedOrigin?.branchCode,
          );
        } else {
          state.shipper = ShipperModel(
            origin: value.first,
            name: state.data?.shipper?.name,
            address: state.data?.shipper?.address,
            phone: state.data?.shipper?.phone,
            region: state.data?.shipper?.region,
            zipCode: state.data?.shipper?.zipCode,
            address1: state.data?.shipper?.address?.substring(
                0,
                (state.data?.shipper?.address?.length ?? 0) > 30
                    ? 29
                    : (state.data?.shipper?.address?.length ?? 0)),
            address2: (state.data?.shipper?.address?.length ?? 0) > 30
                ? state.data?.shipper?.address?.substring(
                    30,
                    (state.data?.shipper?.address?.length ?? 0) > 60
                        ? 59
                        : (state.data?.shipper?.address?.length ?? 0))
                : '',
            address3: (state.data?.shipper?.address?.length ?? 0) >= 60
                ? state.data?.shipper?.address
                    ?.substring(60, (state.data?.shipper?.address?.length ?? 0))
                : '',
          );
        }

        update();
      });

      state.isValidate = true;
      update();
    }

    _showUpdateProfileDialog();
  }

  void _showUpdateProfileDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AppLogger.i('shipper info : ${state.userCcrf?.toJson()}');
      AppLogger.i('shipper info : ${state.isLoading}');
      if (state.isLoading == false) {
        if (state.shipperZipCode.text.isEmpty ||
            state.shipperAddress.text.isEmpty) {
          await Get.dialog(
            DefaultAlertDialog(
              subtitle:
                  'Profil belum lengkap, silahkan lengkapi profil anda terlebih dahulu'
                      .tr,
              confirmButtonTitle: 'Lengkapi Profil'.tr,
              onConfirm: () {
                Get.off(const EditProfilScreen())?.then((_) => initData());
              },
            ),
          );
        }
      }
    });
  }

  Future<void> saveTemp() async {
    var shipper = ShipperModel(
      name: state.shipperName.text.toUpperCase(),
      address: state.shipperAddress.text.toUpperCase(),
      address1: state.shipperAddress.text.substring(
          0,
          (state.shipperAddress.text.length) > 30
              ? 29
              : (state.shipperAddress.text.length)),
      address2: (state.shipperAddress.text.length) > 30
          ? state.shipperAddress.text.substring(
              30,
              (state.shipperAddress.text.length) > 60
                  ? 59
                  : (state.shipperAddress.text.length))
          : '',
      address3: (state.shipperAddress.text.length) >= 60
          ? state.shipperAddress.text
              .substring(60, (state.shipperAddress.text.length))
          : '',
      city: state.shipperOrigin.text.toUpperCase(),
      zipCode: state.shipperZipCode.text,
      region: state.isDropshipper
          ? state.selectedOrigin?.branch?.region
          : (state.shipper?.region ?? state.data?.shipper?.region),
      //province
      country: "ID",
      contact: state.shipperName.text.toUpperCase(),
      phone: state.shipperPhone.text,
      dropship: state.isDropshipper,
      origin: state.selectedOrigin ?? state.shipper?.origin,
    );

    var temp = state.tempData?.copyWith(
      shipper: shipper,
      origin: state.selectedOrigin,
      account: state.selectedAccount,
      dataAccount: state.selectedAccount,
      dropshipper: state.dropshipper,
    );

    await storage.saveData(StorageCore.transactionTemp, temp);
  }

  Future<List<OriginModel>> getOriginList(String keyword) async {
    state.isLoadOrigin = true;
    BaseResponse<List<OriginModel>>? response;
    try {
      response = await master.getOrigins(QueryModel(
          search: keyword.toUpperCase(), relation: true, table: true));
    } catch (e) {
      AppLogger.e('error getOriginList $e');
    }

    state.isLoadOrigin = false;
    update();
    return response?.data?.toList() ?? [];
  }

  Future<void> nextStep() async {
    var shipper = ShipperModel(
      name: state.shipperName.text.toUpperCase(),
      address: state.shipperAddress.text.toUpperCase(),
      address1: state.shipperAddress.text.substring(
          0,
          (state.shipperAddress.text.length) > 30
              ? 29
              : (state.shipperAddress.text.length)),
      address2: (state.shipperAddress.text.length) > 30
          ? state.shipperAddress.text.substring(
              30,
              (state.shipperAddress.text.length) > 60
                  ? 59
                  : (state.shipperAddress.text.length))
          : '',
      address3: (state.shipperAddress.text.length) >= 60
          ? state.shipperAddress.text
              .substring(60, (state.shipperAddress.text.length))
          : '',
      city: state.shipperOrigin.text.toUpperCase(),
      zipCode: state.shipperZipCode.text,
      region: state.isDropshipper
          ? state.selectedOrigin?.branch?.region
          : (state.shipper?.region ?? state.data?.shipper?.region),
      //province
      country: "ID",
      contact: state.shipperName.text.toUpperCase(),
      phone: state.shipperPhone.text,
      dropship: state.isDropshipper,
      origin: state.selectedOrigin ?? state.shipper?.origin,
    );

    var trans = DataTransactionModel(
      shipper: shipper,
      origin: state.selectedOrigin,
      account: state.selectedAccount,
      dataAccount: state.selectedAccount,
      dropshipper: state.dropshipper,
    );

    saveTemp();

    Get.to(() => const ReceiverScreen(),
            arguments: {
              "isEdit": state.isEdit,
              "cod_ongkir": state.codOgkir,
              "account": state.selectedAccount,
              "origin": state.selectedOrigin ?? state.shipper?.origin,
              "dropship": state.isDropshipper,
              "dropshipper": state.dropshipper,
              "shipper": shipper,
              "data": state.data ?? trans,
            },
            transition: Transition.rightToLeft)
        ?.then(
      (value) async {
        state.tempData = DataTransactionModel.fromJson(
            await storage.readData(StorageCore.transactionTemp));
        update();
      },
    );
  }

  Future<void> saveDropshipper() async {
    state.isLoadSave = true;
    update();
    try {
      await master
          .postDropshipper(DropshipperModel(
            name: state.shipperName.text,
            phone: state.shipperPhone.text,
            originCode: state.selectedOrigin?.originCode,
            zipCode: state.shipperZipCode.text,
            address: state.shipperAddress.text,
            city: state.selectedOrigin?.originName,
          ))
          .then(
            (value) =>
                AppSnackBar.success('Data dropshipper telah disimpan'.tr),
          );
    } catch (e) {
      AppLogger.e('error save dropshipper $e');
    }

    state.isLoadSave = false;
    update();
  }

  selectAccount(Account e) {
    if (state.selectedAccount == e && state.selectedAccount != null) {
      state.selectedAccount = null;
      update();
    } else {
      state.selectedAccount = e;
      state.codOgkir = false;
      update();
    }
    formValidate();
    update();
    AppLogger.i("selected account : ${state.selectedAccount?.toJson()}");
  }

  sendAsDropshipper(bool? value) {
    state.isDropshipper = value!;

    if (value == true) {
      if (state.dropshipper != null && state.data != null) {
        state.shipperName.text = state.dropshipper?.name ?? '';
        state.shipperPhone.text = state.dropshipper?.phone ?? '';
        state.shipperOrigin.text = state.dropshipper?.city ?? '';
        state.shipperZipCode.text = state.dropshipper?.zipCode ?? '';
        state.shipperAddress.text = state.dropshipper?.address ?? '';
        getOriginList(state.dropshipper?.originCode ?? '')
            .then((value) => state.selectedOrigin = value.first);

        state.isValidate = true;
      } else {
        state.shipperName.clear();
        state.shipperPhone.clear();
        state.shipperOrigin.clear();
        state.shipperZipCode.clear();
        state.shipperAddress.clear();
        state.selectedOrigin = null;
        state.isValidate = false;
      }
    } else {
      state.shipperName.text = state.shipper?.name ?? '';
      state.shipperPhone.text = state.shipper?.phone ?? '';
      state.shipperOrigin.text = state.shipper?.origin?.originName ?? '';
      state.shipperZipCode.text = state.shipper?.zipCode ?? '';
      state.shipperAddress.text = state.shipper?.address ?? '';
      state.selectedOrigin = OriginModel(
        originCode: state.shipper?.origin?.originCode,
        branchCode: state.shipper?.origin?.branchCode,
        originName: state.shipper?.origin?.originName,
        branch: BranchModel(region: state.shipper?.region),
      );

      state.isValidate = state.selectedAccount != null;
    }
    update();
  }
}
