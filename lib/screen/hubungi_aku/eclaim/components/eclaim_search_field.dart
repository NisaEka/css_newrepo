import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EclaimSearchField extends StatelessWidget {
  const EclaimSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EclaimController>(
        init: EclaimController(),
        builder: (c) {
          return CustomSearchField(
            controller: c.state.searchField,
            hintText: 'Cari Berdasarkan AWB'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? whiteColor
                  : blueJNE,
            ),
            margin: EdgeInsets.zero,
            onChanged: (value) {
              c.state.searchField.text = value;
              c.update();
              c.state.pagingController.refresh();
            },
            onClear: () {
              c.state.searchField.clear();
              c.state.pagingController.refresh();
            },
          );
        });
  }
}
