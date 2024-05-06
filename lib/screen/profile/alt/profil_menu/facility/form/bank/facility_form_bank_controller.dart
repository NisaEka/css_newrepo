import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FacilityFormBankController extends BaseController {

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final bankName = TextEditingController();
  final accountNumber = TextEditingController();
  final accountName = TextEditingController();
  final accountUrl = TextEditingController();

}