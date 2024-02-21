import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/dashboard/menu/other_menu_controller.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
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
            title: Text('Lihat Semua Layanan'.tr),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: List.generate(
              //       controller.filterList.length,
              //       (i) => CustomFilledButton(
              //         color: controller.selectedFilter == controller.filterList[i] ? blueJNE : whiteColor,
              //         borderColor: controller.selectedFilter != controller.filterList[i] ? blueJNE : whiteColor,
              //         fontColor: controller.selectedFilter != controller.filterList[i] ? blueJNE : whiteColor,
              //         title: controller.filterList[i].toString().tr,
              //         width: 150,
              //         radius: 50,
              //         margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              //         onPressed: () {
              //           controller.selectedFilter = controller.filterList[i];
              //           controller.update();
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Favorit".tr, style: listTitleTextStyle),
                                IconButton(
                                  onPressed: () => controller.saveChanges(),
                                  icon: controller.isEdit
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
                            ),
                            const Divider(color: greyColor),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => MenuItem(
                            menuTitle: controller.favoritList[i].title?.tr ?? '',
                            menuImg: controller.favoritList[i].icon,
                            isActive: (controller.favoritList[i].isAuth ?? false) ? controller.isLogin : true,
                            isEdit: controller.isEdit,
                            isFavorite: controller.favoritList[i].isFavorite,
                            onTap: () => controller.isEdit
                                ? controller.removeFavorit(i)
                                : (controller.favoritList[i].isAuth == true && !controller.isLogin)
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => const LoginAlertDialog(),
                                      )
                                    : Get.toNamed(controller.favoritList[i].route.toString(), arguments: {}),
                            onEdit: () => controller.removeFavorit(i),
                          ),
                          childCount: controller.favoritList.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Paketmu".tr, style: listTitleTextStyle),
                            const Divider(color: greyColor),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => MenuItem(
                            menuTitle: controller.paketmuList[i].title?.tr ?? '',
                            menuImg: controller.paketmuList[i].icon,
                            isActive: (controller.paketmuList[i].isAuth ?? false) ? controller.isLogin : true,
                            isEdit: controller.isEdit,
                            onEdit: () => controller.addFavorit(i, controller.paketmuList[i]),
                            isFavorite: controller.paketmuList[i].isFavorite,
                            onTap: () => controller.isEdit
                                ? controller.addFavorit(i, controller.paketmuList[i])
                                : (controller.paketmuList[i].isAuth == true && !controller.isLogin)
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => const LoginAlertDialog(),
                                      )
                                    : Get.toNamed(controller.paketmuList[i].route.toString(), arguments: {}),
                          ),
                          childCount: controller.paketmuList.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Keuanganmu".tr, style: listTitleTextStyle),
                            const Divider(color: greyColor),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => MenuItem(
                            menuTitle: controller.keuanganmuList[i].title?.tr ?? '',
                            menuImg: controller.keuanganmuList[i].icon,
                            isActive: (controller.keuanganmuList[i].isAuth ?? false) ? controller.isLogin : true,
                            isEdit: controller.isEdit,
                            onEdit: () => controller.addFavorit(i, controller.keuanganmuList[i]),
                            isFavorite: controller.keuanganmuList[i].isFavorite,
                            onTap: () => controller.isEdit
                                ? controller.addFavorit(i, controller.keuanganmuList[i])
                                : (controller.keuanganmuList[i].isAuth == true && !controller.isLogin)
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => const LoginAlertDialog(),
                                      )
                                    : Get.toNamed(controller.keuanganmuList[i].route.toString(), arguments: {}),
                          ),
                          childCount: controller.keuanganmuList.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lainnya".tr, style: listTitleTextStyle),
                            const Divider(color: greyColor),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => MenuItem(
                            menuTitle: controller.otherList[i].title?.tr ?? '',
                            menuImg: controller.otherList[i].icon,
                            isActive: (controller.otherList[i].isAuth ?? false) ? controller.isLogin : true,
                            isEdit: controller.isEdit,
                            onEdit: () => controller.addFavorit(i, controller.otherList[i]),
                            isFavorite: controller.otherList[i].isFavorite,
                            onTap: () => controller.isEdit
                                ? controller.addFavorit(i, controller.paketmuList[i])
                                : (controller.otherList[i].isAuth == true && !controller.isLogin)
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => const LoginAlertDialog(),
                                      )
                                    : Get.toNamed(controller.otherList[i].route.toString(), arguments: {}),
                          ),
                          childCount: controller.otherList.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
