import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/keuanganmu/minus/aggregasi_minus_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggminus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/report_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AggregasiMinusScreen extends StatelessWidget {
  const AggregasiMinusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggregasiMinusController>(
        init: AggregasiMinusController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Aggregasi Minus'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                children: [
                  const AggMinusBox(),
                  CustomSearchField(
                    controller: TextEditingController(),
                    hintText: 'Cari Data Aggregasi Minus'.tr,
                    prefixIcon: SvgPicture.asset(
                      IconsConstant.search,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ReportListItem(),
                        ReportListItem(),
                        ReportListItem(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
