import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTransactionState {
  String awb = Get.arguments['awb'];
  TransactionModel? data = Get.arguments['data'];
  String? locale;

  DataTransactionModel? transactionData;
  TransactionModel? transactionModel;
  final pickupStatus = TextEditingController();
  final transStatus = TextEditingController();

  MenuModel? allow;

  bool isLoading = false;
}
