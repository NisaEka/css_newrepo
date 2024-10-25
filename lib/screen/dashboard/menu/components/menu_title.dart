import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../other_menu_controller.dart';

class MenuTitle extends StatelessWidget {
  final String title;

  const MenuTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherMenuCotroller>(
        init: OtherMenuCotroller(),
        builder: (c) {
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
                            Text(title,
                                style: Theme.of(context).textTheme.titleMedium),
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
                      : Text(title,
                          style: Theme.of(context).textTheme.titleMedium),
                  const Divider(color: greyColor),
                ],
              ),
            ),
          );
        });
  }
}
