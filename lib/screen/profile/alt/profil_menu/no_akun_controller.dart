import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoAkunController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  List<Account> accountList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    accountList = [];
    try {
      await transaction.getAccountNumber().then((value) {
        accountList.addAll(value.payload ?? []);
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();
      var accounts = GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts));
      accountList.addAll(accounts.payload ?? []);
    }

    isLoading = false;
    update();
  }
}
