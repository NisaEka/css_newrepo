import 'dart:convert';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/model/profile/profil_list_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  bool isLogin = false;
  List<Account> accountList = [];
  BasicProfilModel? basicProfil;
  CcrfProfilModel? ccrfProfil;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      String? token = await storage.readToken();
      debugPrint("token : $token");
      isLogin = token != null;

      var accounts = GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts));
      accountList.addAll(accounts.payload ?? []);

      basicProfil = BasicProfilModel.fromJson(
        await storage.readData(StorageCore.userProfil),
      );

      await profil.getCcrfProfil().then(
            (value) => ccrfProfil = value.payload,
          );
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    update();
  }

  List<ProfilListModel> profilList = [
    ProfilListModel(
      leading: IconsConstant.openAccount,
      title: 'Lihat Akun'.tr,
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.dataUser,
      title: 'Data Umum'.tr,
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.addressBook,
      title: 'Alamat Pengiriman'.tr,
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.addressBook,
      title: 'Data Rekening'.tr,
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.documentInfo,
      title: 'Dokumen'.tr,
      isShow: false,
    ),
  ];

  void doLogout() async {
    storage.deleteToken();

    Get.offAll(const LoginScreen());
  }
}
