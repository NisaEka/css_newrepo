import 'dart:convert';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';

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
      await master
          .getAccounts(QueryModel(limit: 0, sort: [
        {"accountNumber": "asc"}
      ]))
          .then((value) {
        accountList.addAll(value.data ?? []);
        update();
      });
    } catch (e, i) {
      AppLogger.e('error initData no akun $e, $i');
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
      await profil
          .getCcrfActivity(QueryParamModel(
              limit: 0,
              sort: jsonEncode([
                {'activityCreateDate': 'desc'}
              ])))
          .then((value) {
        logActivityList.addAll(value.data ?? []);
        update();
      });
    } catch (e, i) {
      AppLogger.e('error loadActivity no akun $e, $i');
    }
  }
}
