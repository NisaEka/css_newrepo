import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/storage_core.dart';

class AkunTranasksiController extends BaseController {
  List<Account> accountList = [];
  Account? selectedAccount;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    accountList = [];
    var accounts = GetAccountNumberModel.fromJson(await storage.readData(StorageCore.accounts));
    accountList.addAll(accounts.payload ?? []);
    update();
  }
}
