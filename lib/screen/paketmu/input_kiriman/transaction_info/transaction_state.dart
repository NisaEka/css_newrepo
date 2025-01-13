import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_service_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/draft_transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionState {
  DataTransactionModel? data = Get.arguments['data'];
  bool? isEdit = Get.arguments['isEdit'];
  DataTransactionModel? dataEdit = Get.arguments['dataEdit'];
  ShipperModel shipper = Get.arguments?['shipper'];
  bool dropship = Get.arguments['dropship'];
  bool codOngkir = Get.arguments['cod_ongkir'];
  OriginModel origin = Get.arguments['origin'];
  Account account = Get.arguments['account'];
  ReceiverModel receiver = Get.arguments['receiver'];
  Destination destination = Get.arguments['destination'];
  Delivery? delivery = Get.arguments['delivery'];
  Goods? goods = Get.arguments['goods'];
  int? draftIndex = Get.arguments['index'];
  DataTransactionModel? draft = Get.arguments['draft'];
  DropshipperModel? dropshipper = Get.arguments['dropshipper'];

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();
  final formKey = GlobalKey<FormState>();
  final codKey = GlobalKey<FormFieldState>();
  final service = TextEditingController();
  final weight = TextEditingController();
  final goodLength = TextEditingController();
  final goodWidth = TextEditingController();
  final goodHeight = TextEditingController();
  final goodQty = TextEditingController();
  final goodType = TextEditingController();
  final goodName = TextEditingController();
  final noReference = TextEditingController();
  final specialInstruction = TextEditingController();
  final goodAmount = TextEditingController();
  final codAmountText = TextEditingController();

  String specialIns = '';
  bool insurance = false;
  bool woodPacking = false;
  bool isServiceLoad = false;
  bool isCalculate = false;
  bool isLoading = false;
  bool dimension = false;
  bool formValidate = false;
  bool isOnline = true;
  bool isShowDialog = false;
  bool isCOD = false;

  List<String> steps = [
    'Data Pengirim'.tr,
    'Data Penerima'.tr,
    'Data Kiriman'.tr
  ];
  List<ServiceModel> serviceList = [];
  List<DataTransactionModel> draftList = [];

  ServiceModel? selectedService;
  DraftTransactionModel? draftData;
  DataTransactionModel? tempData;

  num totalOngkir = 0;
  num flatRate = 0;
  num flatRateISR = 0;
  num freightCharge = 0;
  num freightChargeISR = 0;
  double isr = 0;
  double berat = 0;
  num codAmount = 0;
  num congkirAmount = 0;
  num congkirAmountISR = 0;
  double codfee = 0;
  num getCodFeeMinimum = 0;
  num getCodAmountMinimum = 0;
  num getCodFee = 0;
  num getCodAmount = 0;
  num getInsurance = 0;

  bool isSelectGoodsType = false;
}
