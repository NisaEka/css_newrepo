import 'dart:async';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanController extends BaseController {
  String awb = Get.arguments['awb'];

  TransactionModel? transactionModel;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    // Timer(const Duration(seconds: 2), () {
      try {
        transaction.getTransactionByAWB(awb).then(
              (value) => transactionModel = value.payload,
            );
        update();
      } catch (e) {
        e.printError();
      }

      isLoading = false;
      update();
    // });
    update();
  }
}
