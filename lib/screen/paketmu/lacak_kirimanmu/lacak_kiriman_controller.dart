import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class LacakKirimanController extends BaseController {
  List<Step> steps = [
    Step(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '16-10-2023 18:40',
            style: sublistTitleTextStyle.copyWith(color: redJNE),
          ),
          Text(
            'DELIVERED TO [PAK BUDI | 21-10-2023 | BANDUNG]',
            style: listTitleTextStyle.copyWith(color: redJNE),
          ),
        ],
      ),
      content: SizedBox(),
      isActive: true,
      // label: Text('Informasi\nPengirim'.tr),
    ),
    const Step(
      title: Text(''),
      content: SizedBox(),
      isActive: false,
      // label: Text('Informasi\nPenerima'.tr)
    ),
    const Step(
      title: Text(''),
      content: SizedBox(),
      isActive: false,
      // label: Text('Informasi\nKiriman'.tr),
    ),
  ];
}
