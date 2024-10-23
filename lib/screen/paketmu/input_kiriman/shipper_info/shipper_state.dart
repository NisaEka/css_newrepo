import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShipperState {
  final DataTransactionModel? data = Get.arguments['data'];

  final formKey = GlobalKey<FormState>();
  final accountNumber = TextEditingController();
  final shipperName = TextEditingController();
  final shipperPhone = TextEditingController();
  final shipperOrigin = TextEditingController();
  final shipperZipCode = TextEditingController();
  final shipperAddress = TextEditingController();

  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();

  bool isDropshipper = false;
  bool codOgkir = false;
  bool isLoading = false;
  bool isLoadOrigin = false;
  bool isValidate = false;
  bool isOnline = true;
  bool isLoadSave = false;

  List<Account> accountList = [];
  List<Origin> originList = [];

  Account? selectedAccount;

  // GetOriginModel? originModel;
  Origin? selectedOrigin;
  UserModel? shipper;
  DropshipperModel? dropshipper;
  String? locale;

}