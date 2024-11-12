import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/menu_items.dart';
import 'components/menu_title.dart';
import 'other_menu_controller.dart';

class OtherMenuScreen extends StatelessWidget {
  const OtherMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherMenuCotroller>(
      init: OtherMenuCotroller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: blueJNE,
            title: Text('Lihat Semua Layanan'.tr),
            centerTitle: true,
            titleTextStyle: appTitleTextStyle.copyWith(color: whiteColor),
            leading: const CustomBackButton(color: whiteColor),
          ),
          body: _bodyContent(controller, context),
        );
      },
    );
  }

  Widget _bodyContent(OtherMenuCotroller c, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              MenuTitle("Favorit".tr),
              MenuItems(c.favoritList),
              c.paketmuList.isNotEmpty
                  ? MenuTitle("Paketmu".tr)
                  : const SliverPadding(padding: EdgeInsets.zero),
              MenuItems(c.paketmuList),
              c.keuanganmuList.isNotEmpty
                  ? MenuTitle("Keuanganmu".tr)
                  : const SliverPadding(padding: EdgeInsets.zero),
              MenuItems(c.keuanganmuList),
              c.hubungiAkuList.isNotEmpty
                  ? MenuTitle("Hubungi Aku".tr)
                  : const SliverPadding(padding: EdgeInsets.zero),
              MenuItems(c.hubungiAkuList),
              c.otherList.isNotEmpty
                  ? MenuTitle("Lainnya".tr)
                  : const SliverPadding(padding: EdgeInsets.zero),
              MenuItems(c.otherList),
            ],
          ),
        )
      ],
    );
  }
}
