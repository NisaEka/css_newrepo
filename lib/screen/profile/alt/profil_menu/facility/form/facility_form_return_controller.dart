import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FacilityFormReturnController extends BaseController {

  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final returnAddress = TextEditingController();
  final returnPhone = TextEditingController();
  final returnWhatsAppNumber = TextEditingController();
  final returnResponsibleName = TextEditingController();
  final npwpNumber = TextEditingController();
  final npwpType = TextEditingController();
  final npwpName = TextEditingController();
  final npwpImageUrl = TextEditingController();

  @override
  void onInit() {
    npwpType.text = 'PRIBADI';
    super.onInit();
  }
}