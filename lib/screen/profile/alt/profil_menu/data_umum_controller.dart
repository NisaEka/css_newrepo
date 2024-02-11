import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/model/profile/get_basic_profil_model.dart';
import '../../../../data/model/profile/get_ccrf_profil_model.dart';
import '../../../../data/model/transaction/get_account_number_model.dart';

class DataUmumController extends BaseController {
  bool isLogin = false;
  List<AccountNumberModel> accountList = [];
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

}
