import 'package:collection/collection.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/screen/dashboard/menu/other_menu_controller.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItems extends StatelessWidget {
  final List<Items> items;

  const MenuItems(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherMenuCotroller>(
        init: OtherMenuCotroller(),
        builder: (c) {
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
        });
  }
}
