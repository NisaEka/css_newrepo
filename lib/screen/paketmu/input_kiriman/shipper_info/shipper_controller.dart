import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
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
    getOriginList(state.dropshipper?.city?.split(',').first ?? '', state.selectedAccount?.accountId ?? '').then((value) {
      state.selectedOrigin = value.where((element) => element.originName == state.dropshipper?.city).first;
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
      await profil.getBasicProfil().then((value) {
        state.shipper = value.data?.user;
        state.shipperName.text = value.data?.user?.name ?? '';
        state.shipperPhone.text = value.data?.user?.phone ?? '';
        state.shipperOrigin.text = value.data?.user?.origin?.originName ?? '';
        state.shipperZipCode.text = value.data?.user?.zipCode ?? '';
        state.shipperAddress.text = value.data?.user?.address ?? '';
        state.selectedOrigin = Origin(
            originCode: state.shipper?.origin?.originCode,
            branchCode: state.shipper?.origin?.branchCode,
            originName: state.shipper?.origin?.originName,
            region: state.shipper?.origin?.region);
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
      state.shipper = UserModel.fromJson(await storage.readData(StorageCore.shipper));
      state.shipperName.text = state.shipper?.name ?? '';
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
      state.selectedAccount = state.accountList.where((element) => element.accountNumber == state.data?.account?.accountNumber).first;
      state.shipperName.text = state.data?.shipper?.name ?? '';
      state.shipperPhone.text = state.data?.shipper?.phone ?? '';
      state.shipperZipCode.text = state.data?.shipper?.zip ?? '';
      state.shipperAddress.text = state.data?.shipper?.address ?? '';
      state.isDropshipper = state.data?.shipper?.name != state.shipper?.name;

      getOriginList(state.data?.shipper?.city ?? '', state.selectedAccount?.accountId ?? '').then((value) {
        state.selectedOrigin = value.first;
        state.shipperOrigin.text = value.first.originName ?? '';
        update();

        if (state.isDropshipper) {
          state.dropshipper = DropshipperModel(
            name: state.data?.shipper?.name,
            address: state.data?.shipper?.address,
            city: state.data?.shipper?.city,
            phone: state.data?.shipper?.phone,
            zipCode: state.data?.shipper?.zip,
            origin: state.selectedOrigin?.branchCode,
          );
        } else {
          state.shipper = UserModel(
            origin: value.first,
            name: state.data?.shipper?.name,
            address: state.data?.shipper?.address,
            phone: state.data?.shipper?.phone,
            region: Region(
              name: state.data?.shipper?.region,
            ),
            zipCode: state.data?.shipper?.zip,
          );
        }

        update();
      });

      state.isValidate = true;
      update();
    }
  }

  Future<List<Origin>> getOriginList(String keyword, String id) async {
    state.originList = [];
    state.isLoadOrigin = true;
    BaseResponse<List<Origin>>? response;
    try {
      String accountId = '{"accountId":"$id"}';
      response = await master.getOrigins(QueryParamModel(search: keyword.toUpperCase(), where: accountId));
    } catch (e) {
      e.printError();
    }

    state.isLoadOrigin = false;
    update();
    return response?.data?.toList() ?? [];
    // return [];
  }

  void nextStep() {
    Get.to(const ReceiverScreen(),
        arguments: {
          "cod_ongkir": state.codOgkir,
          "account": state.selectedAccount,
          "origin": state.selectedOrigin ?? state.shipper?.origin,
          "dropship": state.isDropshipper,
          "dropshipper": state.dropshipper,
          "shipper": Shipper(
            name: state.shipperName.text.toUpperCase(),
            address: state.shipperAddress.text.toUpperCase(),
            address1: state.shipperAddress.text.length <= 30 ? state.shipperAddress.text.substring(0, state.shipperAddress.text.length) : '',
            address2: state.shipperAddress.text.length >= 31 ? state.shipperAddress.text.substring(31, state.shipperAddress.text.length) : '',
            address3: state.shipperAddress.text.length >= 60 ? state.shipperAddress.text.substring(60, state.shipperAddress.text.length) : '',
            city: state.shipperOrigin.text.toUpperCase(),
            zip: state.shipperZipCode.text,
            region: state.isDropshipper ? state.selectedOrigin?.region?.name : state.shipper?.region?.name,
            //province
            country: "ID",
            contact: state.shipperName.text.toUpperCase(),
            phone: state.shipperPhone.text,
            dropship: state.isDropshipper,
          ),
          "data": state.data,
        },
        transition: Transition.rightToLeft);
  }

  Future<void> saveDropshipper() async {
    state.isLoadSave = true;
    update();
    try {
      await transaction
          .postDropshipper(DropshipperModel(
            name: state.shipperName.text,
            phone: state.shipperPhone.text,
            origin: state.selectedOrigin?.originCode,
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
                message: "Data state.dropshipper telah disimpan".tr,
                isDismissible: true,
                duration: const Duration(seconds: 3),
                backgroundColor: value.code == 201 ? successColor : errorColor,
              ),
            ),
          );
    } catch (e) {
      e.printError();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.info,
            color: whiteColor,
          ),
          message: 'Tidak dapat menyimpan data'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
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
    getOriginList('', e.accountId.toString());
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
        getOriginList(state.dropshipper?.city ?? '', state.selectedAccount?.accountId ?? '').then((value) => state.selectedOrigin = value.first);

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
          region: state.shipper?.region);
      state.isValidate = true;
    }
    update();
  }
}
