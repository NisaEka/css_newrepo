import 'dart:async';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanController extends BaseController {
  String awb = Get.arguments['awb'];
  TransactionModel? transactionData = Get.arguments['data'];

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
      transStatus.text = transactionData?.statusAwb ?? '';
      pickupStatus.text = transactionData?.pickupStatus ?? '';
      update();

      try {
        transaction.getTransactionByAWB(awb).then((value) {
          transactionModel = value.data?.copyWith(
            accountNumber: transactionData?.accountNumber,
            accountService: transactionData?.accountService,
            accountName: transactionData?.accountName,
            accountType: transactionData?.accountType,
            statusAwb: transactionData?.statusAwb,
          );
          // transStatus.text = transactionModel?.statusAwb ?? '';
          // pickupStatus.text = transactionModel?.pickupStatus ?? '';
          update();
        });
      } catch (e, i) {
        AppLogger.e('error initData detail riwayat kiriman $e, $i');
      }

      isLoading = false;
      update();
    });
  }
}
