import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_state.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ShipperController extends BaseController {
  final state = ShipperState();

  @override
  void onInit() {
    super.onInit();
    print('edit transaksi : ${state.data?.shipper?.region?.name}');
    Future.wait([
      initData(),
    ]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        state.isOnline = value && (result != ConnectivityResult.none);
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
      state.selectedOrigin = value.where((element) => element.originCode == state.dropshipper?.originCode).first;
      update();
    });

    update();
    // return state.dropshipper;
  }

  bool isSaveDropshipper() {
    if (state.dropshipper?.name != state.shipperName.text && state.dropshipper?.phone != state.shipperPhone.text) {
      return true;
    }
    return false;
  }

  void formValidate() async {
    if (state.isOnline) {
      state.isValidate = state.formKey.currentState?.validate() == true && state.selectedAccount != null && state.selectedOrigin != null;
    } else {
      state.isValidate = state.formKey.currentState?.validate() == true && state.selectedAccount != null;
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

    try {
      await master.getAccounts().then((value) => state.accountList.addAll(value.data ?? []));
      update();

      var user = CcrfProfileModel.fromJson(await storage.readData(StorageCore.ccrfProfile));

      await profil.getBasicProfil().then((value) async {
        if (value.data != null) {
          state.shipper = ShipperModel(
            name: value.data?.user?.brand,
            region: value.data?.user?.region,
            origin: value.data?.user?.origin,
            zipCode: value.data?.user?.zipCode,
            address: value.data?.user?.address,
            phone: value.data?.user?.phone,
            city: user.generalInfo?.city,
            country: user.generalInfo?.country,
            dropship: state.isDropshipper,
            contact: user.generalInfo?.name,
            address1: value.data?.user?.address
                ?.substring(0, (value.data?.user?.address?.length ?? 0) > 30 ? 29 : (value.data?.user?.address?.length ?? 0)),
            address2: (value.data?.user?.address?.length ?? 0) > 30
                ? value.data?.user?.address
                    ?.substring(30, (value.data?.user?.address?.length ?? 0) > 60 ? 59 : (value.data?.user?.address?.length ?? 0))
                : '',
            address3: (value.data?.user?.address?.length ?? 0) >= 60
                ? value.data?.user?.address?.substring(60, (value.data?.user?.address?.length ?? 0))
                : '',
          );
          state.shipperName.text = value.data?.user?.brand ?? '';
          state.shipperPhone.text = value.data?.user?.phone ?? '';
          state.shipperOrigin.text = value.data?.user?.origin?.originName ?? '';
          state.shipperZipCode.text = value.data?.user?.zipCode ?? '';
          state.shipperAddress.text = value.data?.user?.address ?? '';
          state.selectedOrigin = value.data?.user?.origin;
        } else {
          await profil.getBasicProfil().then((value) {
            state.shipper = ShipperModel(
              name: value.data?.user?.brand,
              phone: value.data?.user?.phone,
              address: value.data?.user?.address,
              zipCode: value.data?.user?.zipCode,
              origin: value.data?.user?.origin,
              region: value.data?.user?.region,
              contact: value.data?.user?.name,
              city: value.data?.user?.origin?.originName,
              country: 'INDONESIA',
              dropship: state.isDropshipper,
              address1: value.data?.user?.address
                  ?.substring(0, (value.data?.user?.address?.length ?? 0) > 30 ? 29 : (value.data?.user?.address?.length ?? 0)),
              address2: (value.data?.user?.address?.length ?? 0) > 30
                  ? value.data?.user?.address
                      ?.substring(30, (value.data?.user?.address?.length ?? 0) > 60 ? 59 : (value.data?.user?.address?.length ?? 0))
                  : '',
              address3: (value.data?.user?.address?.length ?? 0) >= 60
                  ? value.data?.user?.address?.substring(60, (value.data?.user?.address?.length ?? 0))
                  : '',
            );
            state.shipperName.text = value.data?.user?.brand ?? '';
            state.shipperPhone.text = value.data?.user?.phone ?? '';
            state.shipperOrigin.text = value.data?.user?.origin?.originName ?? '';
            state.shipperZipCode.text = value.data?.user?.zipCode ?? '';
            state.shipperAddress.text = value.data?.user?.address ?? '';
            state.selectedOrigin = value.data?.user?.origin;
          });
        }
      });
      update();
    } catch (e) {
      e.printError();
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
      state.accountList.addAll(accounts.data ?? []);
      // state.accountList.addAll(GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts)) );
      state.shipper = ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
      state.userBasic = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
      state.shipperName.text = state.userBasic?.brand ?? '';
      state.shipperPhone.text = state.shipper?.phone ?? '';
      state.shipperOrigin.text = state.shipper?.origin?.originName ?? '';
      state.shipperZipCode.text = state.shipper?.zipCode ?? '';
      state.shipperAddress.text = state.shipper?.address ?? '';
      state.selectedOrigin = Origin(
          originCode: state.shipper?.origin?.originCode,
          branchCode: state.shipper?.origin?.branchCode,
          originName: state.shipper?.origin?.originName);
    }

    state.isLoading = false;
    update();

    if (state.data != null) {
      state.shipper = state.data?.shipper;
      state.selectedAccount = state.accountList.where((element) => element.accountNumber == state.data?.account?.accountNumber).first;
      state.shipperName.text = state.data?.shipper?.name ?? '';
      state.shipperPhone.text = state.data?.shipper?.phone ?? '';
      state.shipperZipCode.text = state.data?.shipper?.zipCode ?? '';
      state.shipperAddress.text = state.data?.shipper?.address ?? '';
      state.isDropshipper = state.data?.shipper?.name != state.shipper?.name;
      getOriginList(state.data?.shipper?.origin?.originCode ?? '').then((value) {
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
            address1: state.data?.shipper?.address
                ?.substring(0, (state.data?.shipper?.address?.length ?? 0) > 30 ? 29 : (state.data?.shipper?.address?.length ?? 0)),
            address2: (state.data?.shipper?.address?.length ?? 0) > 30
                ? state.data?.shipper?.address
                    ?.substring(30, (state.data?.shipper?.address?.length ?? 0) > 60 ? 59 : (state.data?.shipper?.address?.length ?? 0))
                : '',
            address3: (state.data?.shipper?.address?.length ?? 0) >= 60
                ? state.data?.shipper?.address?.substring(60, (state.data?.shipper?.address?.length ?? 0))
                : '',
          );
        }

        update();
      });

      state.isValidate = true;
      update();
    }
  }

  Future<List<Origin>> getOriginList(String keyword) async {
    state.isLoadOrigin = true;
    BaseResponse<List<Origin>>? response;
    try {
      response = await master.getOrigins(QueryParamModel(search: keyword.toUpperCase()));
    } catch (e) {
      e.printError();
    }

    state.isLoadOrigin = false;
    update();
    return response?.data?.toList() ?? [];
    // return [];
  }

  void nextStep() {
    var shipper = ShipperModel(
      name: state.shipperName.text.toUpperCase(),
      address: state.shipperAddress.text.toUpperCase(),
      address1: state.shipperAddress.text.substring(0, (state.shipperAddress.text.length) > 30 ? 29 : (state.shipperAddress.text.length)),
      address2: (state.shipperAddress.text.length) > 30
          ? state.shipperAddress.text.substring(30, (state.shipperAddress.text.length) > 60 ? 59 : (state.shipperAddress.text.length))
          : '',
      address3: (state.shipperAddress.text.length) >= 60 ? state.shipperAddress.text.substring(60, (state.shipperAddress.text.length)) : '',
      city: state.shipperOrigin.text.toUpperCase(),
      zipCode: state.shipperZipCode.text,
      region: state.isDropshipper ? state.selectedOrigin?.region : (state.shipper?.region ?? state.data?.shipper?.region),
      //province
      country: "ID",
      contact: state.shipperName.text.toUpperCase(),
      phone: state.shipperPhone.text,
      dropship: state.isDropshipper,
      origin: state.selectedOrigin ?? state.shipper?.origin,
    );

    var trans = DataTransactionModel(
      shipper: state.shipper,
      origin: state.selectedOrigin,
      account: state.selectedAccount,
      dataAccount: state.selectedAccount,
      dropshipper: state.dropshipper,
    );

    Get.to(const ReceiverScreen(),
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
        transition: Transition.rightToLeft);
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
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: const Icon(
                  Icons.info,
                  color: whiteColor,
                ),
                message: value.code == 201 ? "Data dropshipper telah disimpan".tr : value.error[0].toString(),
                isDismissible: true,
                duration: const Duration(seconds: 3),
                backgroundColor: value.code == 201 ? successColor : errorColor,
              ),
            ),
          );
    } catch (e) {
      e.printError();
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
        getOriginList(state.dropshipper?.originCode ?? '').then((value) => state.selectedOrigin = value.first);

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
      state.selectedOrigin = Origin(
        originCode: state.shipper?.origin?.originCode,
        branchCode: state.shipper?.origin?.branchCode,
        originName: state.shipper?.origin?.originName,
        region: state.shipper?.region,
      );
      state.isValidate = true;
    }
    update();
  }
}
