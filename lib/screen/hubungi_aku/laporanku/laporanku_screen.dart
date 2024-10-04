import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/components/laporanku_body.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/input/input_laporanku_screen.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/laporanku_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'components/laporanku_appbar.dart';
import 'components/laporanku_status.dart';
import 'detail/detail_laporanku_screen.dart';

class LaporankuScreen extends StatelessWidget {
  const LaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
        init: LaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: LaporankuAppbar(),
            body: const LaporankuBody(),
            floatingActionButton: CustomFilledButton(
              color: redJNE,
              title: "Buat Laporan".tr,
              width: Get.width / 3,
              icon: Icons.add,
              radius: 30,
              height: 50,
              onPressed: () => Get.to(const InputLaporankuScreen())?.then(
                (_) {
                  controller.state.pagingController.refresh();
                  controller.initData();
                },
              ),
            ),
          );
        });
  }






}
