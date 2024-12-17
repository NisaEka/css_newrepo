import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class AkunTranasksiController extends BaseController {
  Account? currentAccount = Get.arguments['account'];
  List<Account> accountList = [];
  Account? selectedAccount;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
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
    update();
  }
}
