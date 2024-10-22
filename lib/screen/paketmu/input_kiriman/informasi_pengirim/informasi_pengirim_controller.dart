import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class InformasiPengirimController extends BaseController {
  final DataTransactionModel? data = Get.arguments['data'];

  final formKey = GlobalKey<FormState>();
  final nomorAkun = TextEditingController();
  final namaPengirim = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaPengirim = TextEditingController();
  final kodePos = TextEditingController();
  final alamatLengkap = TextEditingController();

  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();

  bool isDropshipper = false;
  bool codOgkir = false;
  bool isLoading = false;
  bool isLoadOrigin = false;
  bool isValidate = false;
  bool isOnline = true;
  bool isLoadSave = false;

  List<String> steps = ['Data Pengirim'.tr, 'Data Penerima'.tr, 'Data Kiriman'.tr];
  List<Account> accountList = [];
  List<Origin> originList = [];

  Account? selectedAccount;
  // GetOriginModel? originModel;
  Origin? selectedOrigin;
  UserModel? shipper;
  DropshipperModel? dropshipper;
  String? locale;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      initData(),
    ]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        isOnline = value && (result != ConnectivityResult.none);
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

        update();
      });
      update();
    }));
  }

  FutureOr<void> getSelectedDropshipper() async {
    namaPengirim.text = dropshipper?.name?.toUpperCase() ?? '';
    nomorTelpon.text = dropshipper?.phone ?? '';
    kotaPengirim.text = dropshipper?.city?.toUpperCase() ?? '';
    alamatLengkap.text = dropshipper?.address?.toUpperCase() ?? '';
    kodePos.text = dropshipper?.zipCode ?? '';
    getOriginList(dropshipper?.city?.split(',').first ?? '', selectedAccount?.accountId ?? '').then((value) {
      selectedOrigin = value.where((element) => element.originName == dropshipper?.city).first;
      update();
    });
    update();
    // return dropshipper;
  }

  bool isSaveDropshipper() {
    if (dropshipper?.name != namaPengirim.text && dropshipper?.phone != nomorTelpon.text) {
      return true;
    }
    return false;
  }

  void formValidate() async {
    if (isOnline) {
      isValidate = formKey.currentState?.validate() == true && selectedAccount != null && selectedOrigin != null;
    } else {
      isValidate = formKey.currentState?.validate() == true && selectedAccount != null;
    }

    update();

    locale = await storage.readString(StorageCore.localeApp);
    update();
    ValidationBuilder.setLocale(locale!);
  }

  Future<void> initData() async {
    accountList = [];
    selectedAccount = null;
    isLoading = true;
    connection.isOnline().then((value) => isOnline = value);

    try {
      await transaction.getAccountNumber().then((value) => accountList.addAll(value.payload ?? []));
      update();
      await profil.getBasicProfil().then((value) {
        shipper = value.data?.user;
        namaPengirim.text = value.data?.user?.name ?? '';
        nomorTelpon.text = value.data?.user?.phone ?? '';
        kotaPengirim.text = value.data?.user?.origin?.originName ?? '';
        kodePos.text = value.data?.user?.zipCode ?? '';
        alamatLengkap.text = value.data?.user?.address ?? '';
        selectedOrigin = Origin(
            originCode: shipper?.origin?.originCode,
            branchCode: shipper?.origin?.branchCode,
            originName: shipper?.origin?.originName,
            region: shipper?.origin?.region);
      });
      update();
    } catch (e) {
      e.printError();
      var accounts = GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts));
      accountList.addAll(accounts.payload ?? []);
      // accountList.addAll(GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts)) );
      shipper = UserModel.fromJson(await storage.readData(StorageCore.shipper));
      namaPengirim.text = shipper?.name ?? '';
      nomorTelpon.text = shipper?.phone ?? '';
      kotaPengirim.text = shipper?.origin?.originName ?? '';
      kodePos.text = shipper?.zipCode ?? '';
      alamatLengkap.text = shipper?.address ?? '';
      selectedOrigin =
          Origin(originCode: shipper?.origin?.originCode, branchCode: shipper?.origin?.branchCode, originName: shipper?.origin?.originName);
    }

    isLoading = false;
    update();

    if (data != null) {
      selectedAccount = accountList.where((element) => element.accountNumber == data?.account?.accountNumber).first;
      namaPengirim.text = data?.shipper?.name ?? '';
      nomorTelpon.text = data?.shipper?.phone ?? '';
      kodePos.text = data?.shipper?.zip ?? '';
      alamatLengkap.text = data?.shipper?.address ?? '';
      isDropshipper = data?.shipper?.name != shipper?.name;

      getOriginList(data?.shipper?.city ?? '', selectedAccount?.accountId ?? '').then((value) {
        selectedOrigin = value.first;
        kotaPengirim.text = value.first.originName ?? '';
        update();

        if (isDropshipper) {
          dropshipper = DropshipperModel(
            name: data?.shipper?.name,
            address: data?.shipper?.address,
            city: data?.shipper?.city,
            phone: data?.shipper?.phone,
            zipCode: data?.shipper?.zip,
            origin: selectedOrigin?.branchCode,
          );
        } else {
          shipper = UserModel(
            origin: value.first,
            name: data?.shipper?.name,
            address: data?.shipper?.address,
            phone: data?.shipper?.phone,
            region: Region(
              name: data?.shipper?.region,
            ),
            zipCode: data?.shipper?.zip,
          );
        }

        update();
      });

      isValidate = true;
      update();

      // Get.showSnackbar(
      //   GetSnackBar(
      //     icon: const Icon(
      //       Icons.info,
      //       color: whiteColor,
      //     ),
      //     message: selectedAccount.toString(),
      //     isDismissible: true,
      //     duration: const Duration(seconds: 3),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  Future<List<Origin>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    try {
      // var response = await transaction.getOrigin(keyword, accountID);
      // originModel = response;
    } catch (e) {
      e.printError();
    }

    isLoadOrigin = false;
    update();
    // return originModel?.payload?.toList() ?? [];
    return [];
  }

  void nextStep() {
    Get.to(const InformasiPenerimaScreen(),
        arguments: {
          "cod_ongkir": codOgkir,
          "account": selectedAccount,
          "origin": selectedOrigin ?? shipper?.origin,
          "dropship": isDropshipper,
          "dropshipper": dropshipper,
          "shipper": Shipper(
            name: namaPengirim.text.toUpperCase(),
            address: alamatLengkap.text.toUpperCase(),
            address1: alamatLengkap.text.length <= 30 ? alamatLengkap.text.substring(0, alamatLengkap.text.length) : '',
            address2: alamatLengkap.text.length >= 31 ? alamatLengkap.text.substring(31, alamatLengkap.text.length) : '',
            address3: alamatLengkap.text.length >= 60 ? alamatLengkap.text.substring(60, alamatLengkap.text.length) : '',
            city: kotaPengirim.text.toUpperCase(),
            zip: kodePos.text,
            region: isDropshipper ? selectedOrigin?.region?.name : shipper?.region?.name,
            //province
            country: "ID",
            contact: namaPengirim.text.toUpperCase(),
            phone: nomorTelpon.text,
            dropship: isDropshipper,
          ),
          "data": data,
        },
        transition: Transition.rightToLeft);
  }

  Future<void> saveDropshipper() async {
    isLoadSave = true;
    update();
    try {
      await transaction
          .postDropshipper(DropshipperModel(
            name: namaPengirim.text,
            phone: nomorTelpon.text,
            origin: selectedOrigin?.originCode,
            zipCode: kodePos.text,
            address: alamatLengkap.text,
            city: selectedOrigin?.originName,
          ))
          .then(
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: const Icon(
                  Icons.info,
                  color: whiteColor,
                ),
                message: "Data dropshipper telah disimpan".tr,
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

    isLoadSave = false;
    update();
  }

  selectAccount(Account e) {
    if (selectedAccount == e && selectedAccount != null) {
      selectedAccount = null;
      update();
    } else {
      selectedAccount = e;
      codOgkir = false;
      update();
    }
    getOriginList('', e.accountId.toString());
    formValidate();
    update();
  }

  sendAsDropshipper(bool? value) {
    isDropshipper = value!;

    if (value == true) {
      if (dropshipper != null && data != null) {
        namaPengirim.text = dropshipper?.name ?? '';
        nomorTelpon.text = dropshipper?.phone ?? '';
        kotaPengirim.text = dropshipper?.city ?? '';
        kodePos.text = dropshipper?.zipCode ?? '';
        alamatLengkap.text = dropshipper?.address ?? '';
        getOriginList(dropshipper?.city ?? '', selectedAccount?.accountId ?? '').then((value) => selectedOrigin = value.first);

        isValidate = true;
      } else {
        namaPengirim.clear();
        nomorTelpon.clear();
        kotaPengirim.clear();
        kodePos.clear();
        alamatLengkap.clear();
        selectedOrigin = null;
        isValidate = false;
      }
    } else {
      namaPengirim.text = shipper?.name ?? '';
      nomorTelpon.text = shipper?.phone ?? '';
      kotaPengirim.text = shipper?.origin?.originName ?? '';
      kodePos.text = shipper?.zipCode ?? '';
      alamatLengkap.text = shipper?.address ?? '';
      selectedOrigin = Origin(
          originCode: shipper?.origin?.originCode,
          branchCode: shipper?.origin?.branchCode,
          originName: shipper?.origin?.originName,
          region: shipper?.region);
      isValidate = true;
    }
    update();
  }
}
