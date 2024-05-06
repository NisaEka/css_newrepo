import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FacilityFormInfoController extends BaseController {

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final brand = TextEditingController();
  final idCardUrl = TextEditingController();
  final fullName = TextEditingController();
  final idCardNumber = TextEditingController();
  final fullAddress = TextEditingController();
  final phone = TextEditingController();
  final whatsAppPhone = TextEditingController();
  final email = TextEditingController();

}