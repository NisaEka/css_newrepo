import 'dart:async';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanController extends BaseController {
  String awb = Get.arguments['awb'];

  TransactionModel? transactionModel;
  final pickupStatus = TextEditingController();
  final transStatus = TextEditingController();

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    update();
    Timer(const Duration(seconds: 1), () {
      try {
        transaction.getTransactionByAWB(awb).then((value) {
          transactionModel = value.data;
          transStatus.text = transactionModel?.statusDesc ?? '';
          pickupStatus.text = transactionModel?.responsePickup ?? '';
          update();
        });
      } catch (e) {
        e.printError();
      }

      isLoading = false;
      update();
    });
  }
}
