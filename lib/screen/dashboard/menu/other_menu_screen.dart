import 'package:collection/collection.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/screen/dashboard/menu/other_menu_controller.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              _menu("Favorit".tr, c),
              _menuItems(c.favoritList, c),
              c.paketmuList.isNotEmpty ? _menu("Paketmu".tr, c) : const SliverPadding(padding: EdgeInsets.zero),
              _menuItems(c.paketmuList, c),
              c.keuanganmuList.isNotEmpty ? _menu("Keuanganmu".tr, c) : const SliverPadding(padding: EdgeInsets.zero),
              _menuItems(c.keuanganmuList, c),
              c.otherList.isNotEmpty ? _menu("Lainnya".tr, c) : const SliverPadding(padding: EdgeInsets.zero),
              _menuItems(c.otherList, c),
            ],
          ),
        )
      ],
    );
  }

  SliverPadding _menu(String title, OtherMenuCotroller c) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == "Favorit".tr
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: listTitleTextStyle),
                      IconButton(
                        onPressed: () => c.saveChanges(),
                        icon: c.isEdit
                            ? const Icon(
                                Icons.check_circle,
                                color: successColor,
                              )
                            : const Icon(
                                Icons.change_circle,
                                color: greyColor,
                              ),
                      ),
                    ],
                  )
                : Text(title, style: listTitleTextStyle),
            const Divider(color: greyColor),
          ],
        ),
      ),
    );
  }

  SliverPadding _menuItems(List<Items> items, OtherMenuCotroller c) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, i) => MenuItem(
            data: items[i],
            isActive: (items[i].isAuth ?? false) ? c.isLogin : true,
            isEdit: c.isEdit,
            onEdit: () => !items.equals(c.favoritList) ? c.addFavorit(i, items[i]) : c.removeFavorit(i),
            onTap: () => c.isEdit ? c.addFavorit(i, items[i]) : c.routeToMenu(items[i], context),
          ),
          childCount: items.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
        ),
      ),
    );
  }
}
