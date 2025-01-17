import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiverState {
  DataTransactionModel? data = Get.arguments['data'];
  bool? isEdit = Get.arguments['isEdit'];
  DataTransactionModel? dataEdit = Get.arguments['dataEdit'];
  ShipperModel shipper = Get.arguments?['shipper'];
  bool dropship = Get.arguments['dropship'];
  DropshipperModel? dropshipper = Get.arguments['dropshipper'];
  bool codOngkir = Get.arguments['cod_ongkir'];
  OriginModel origin = Get.arguments['origin'];
  TransAccountModel account = Get.arguments['account'];

  final GlobalKey<TooltipState> offlineTooltipKey = GlobalKey<TooltipState>();
  final formKey = GlobalKey<FormState>();
  final receiverName = TextEditingController();
  final receiverPhone = TextEditingController();
  final receiverDest = TextEditingController();
  final receiverAddress = TextEditingController();

  bool isLoading = false;
  bool isOnline = true;
  bool isLoadSave = false;
  bool isValidate = false;
  bool isSaveReceiver = true;

  DestinationModel? selectedDestination;
  ReceiverModel? receiver;
  DataTransactionModel? tempData;
}
