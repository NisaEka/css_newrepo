import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/informasi_penerima_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputKirimanController extends BaseController {
  int currentStep = 0;

  List<Step> steps = [
    const Step(
      title: Text(''),
      content: InformasiPengirimScreen(),
      isActive: true,
      // label: Text('Informasi\nPengirim'.tr),
    ),
    const Step(
      title: Text(''),
      content: InformasiPenerimaScreen(),
      isActive: false,
      // label: Text('Informasi\nPenerima'.tr)
    ),
    const Step(
      title: Text(''),
      content: InformasiKirimanScreen(),
      isActive: false,
      // label: Text('Informasi\nKiriman'.tr),
    ),
  ];
}
