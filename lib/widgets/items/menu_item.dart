import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  final String? menuTitle;
  final String? menuImg;
  final Icon? menuIcon;
  final VoidCallback? onTap;
  final bool isActive;
  final bool? isFavorite;
  final bool isEdit;
  final bool isLogin;
  final VoidCallback? onEdit;
  final Items? data;
  final bool isLoading;

  const MenuItem({
    super.key,
    this.menuTitle,
    this.menuImg,
    this.onTap,
    this.menuIcon,
    this.isActive = true,
    this.isFavorite,
    this.isEdit = false,
    this.onEdit,
    this.data,
    this.isLogin = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isActive
                          ? (AppConst.isLightTheme(context)
                              ? blueJNE
                              : bgDarkColor)
                          : AppConst.isLightTheme(context)
                              ? blueJNEna
                              : greyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignInside,
                        color: (AppConst.isDarkTheme(context)
                            ? infoColor
                            : Colors.transparent),
                      ),
                    ),
                    child: menuIcon ??
                        Stack(
                          children: [
                            Icon(
                              CupertinoIcons.cube,
                              size: 50,
                              color: AppConst.isLightTheme(context)
                                  ? whiteColor
                                  : infoColor,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 25,
                                color: isActive
                                    ? (AppConst.isLightTheme(context)
                                        ? blueJNE
                                        : bgDarkColor)
                                    : AppConst.isLightTheme(context)
                                        ? blueJNEna
                                        : greyColor,
                                child: SvgPicture.asset(
                                  data?.icon ?? '_',
                                  //   IconData( int.parse('0xE04F'), fontFamily: 'MaterialIcons'),
                                  color: AppConst.isLightTheme(context)
                                      ? whiteColor
                                      : infoColor,
                                ),
                              ),
                            )
                          ],
                        ),
                    // child: menuIcon ??
                    //     Image.asset(
                    //       data?.icon ?? menuImg ?? '',
                    //       height: Get.width / 9,
                    //     ),
                  ),
                  SizedBox(
                    // width: 65,
                    child: Text(
                      isLoading
                          ? ""
                          : data?.title?.tr
                                  .splitMapJoin(' ', onMatch: (p0) => '\n')
                                  .splitMapJoin('_', onMatch: (p0) => ' ') ??
                              menuTitle
                                  ?.splitMapJoin(' ', onMatch: (p0) => '\n')
                                  .splitMapJoin('_', onMatch: (p0) => ' ') ??
                              '',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isEdit
            ? Positioned(
                top: -14,
                right: 3,
                child: IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    isFavorite == true || (data?.isFavorite ?? false)
                        ? Icons.remove_circle
                        : Icons.add_circle_rounded,
                    color: isFavorite == true || (data?.isFavorite ?? false)
                        ? errorColor
                        : successColor,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
