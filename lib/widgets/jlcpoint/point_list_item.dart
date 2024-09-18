import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointListItem extends StatelessWidget {
  final Widget? item;
  final String? dateTime;
  final double? point;
  final String? title;
  final String? subtitle;
  final String? status;
  final String? amount;
  final String? rewards;
  final bool isLoading;

  const PointListItem({
    super.key,
    this.item,
    this.dateTime,
    this.point,
    this.title,
    this.subtitle,
    this.status,
    this.amount,
    this.rewards,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: greyDarkColor1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: AppConst.isLightTheme(context) ? blueJNE : redJNE, width: 2),
                      ),
                      child: Icon(
                        Icons.playlist_add_check_rounded,
                        color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                      ),
                    ),
                    Container(
                      height: isLoading ? 20 : null,
                      width: isLoading ? Get.width / 2 : null,
                      color: isLoading ? greyColor : null,
                      child: Text(dateTime ?? ''),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: status == "Valid" ? successLightColor2 : errorLightColor2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${(point ?? 0) < 1 ? point : point?.toStringAsFixed(0)} ${'Poin'.tr}",
                    style: listTitleTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
            const Divider(thickness: 0.5),
            item ??
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: isLoading ? 20 : null,
                          width: isLoading ? Get.width / 2 : null,
                          color: isLoading ? greyColor : null,
                          child: Row(
                            children: [
                              Text("$title   ".toUpperCase()),
                              Text(
                                subtitle ?? '',
                                style: listTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: isLoading ? 20 : null,
                          width: isLoading ? Get.width / 4 : null,
                          color: isLoading ? greyColor : null,
                          child: Text(
                            amount?.toInt().toCurrency() ?? '',
                            style: listTitleTextStyle,
                          ),
                        )
                      ],
                    ),
                    status != null
                        ? CustomFilledButton(
                            color: greyLightColor3,
                            width: 84,
                            height: 20,
                            fontSize: 10,
                            fontColor: status == 'Valid' ? successColor : errorColor,
                            title: status?.toUpperCase(),
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(top: 10),
                          )
                        : rewards != null
                            ? Container(
                                height: isLoading ? 20 : null,
                                width: isLoading ? Get.width / 4 : null,
                                color: isLoading ? greyColor : null,
                                margin: isLoading ? const EdgeInsets.only(top: 2) : null,
                                child: RichText(
                                  text: TextSpan(
                                      text: "Jumlah Hadiah".tr.toUpperCase(),
                                      style: Theme.of(context).textTheme.titleMedium,
                                      children: [TextSpan(text: ' $rewards')]),
                                ),
                              )
                            : const SizedBox(),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
