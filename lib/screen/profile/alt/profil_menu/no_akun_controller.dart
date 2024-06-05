import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class NoAkunController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  List<Account> accountList = [];
  List<CcrfActivityModel> logActivityList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData(), loadActivity()]);
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
      accountList = [];
      var accounts = GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts));
      accountList.addAll(accounts.payload ?? []);
    }

    isLoading = false;
    update();
  }

  Future<void> loadActivity() async {
    try {
      await profil.getCcrfActivity().then((value) {
        logActivityList.addAll(value.payload ?? []);
        update();
      });
    } catch (e) {
      e.printError();
    }
  }
}
