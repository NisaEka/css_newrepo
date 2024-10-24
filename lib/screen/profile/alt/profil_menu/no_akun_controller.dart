import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';

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
      await master.getAccounts().then((value) {
        accountList.addAll(value.data ?? []);
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();
      accountList = [];
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
      accountList.addAll(accounts.data ?? []);
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
    } catch (e, i) {
      e.printError();
      i.printError(info: "Error info:");
    }
  }
}
