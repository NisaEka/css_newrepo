import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final double? percentage;
  final int count;
  final String subtitle;
  final Color? color;
  final IconData? icon;
  final Color? statusColor;
  final Widget? suffixChart;
  final Widget? prefixChart;
  final bool isLoading;
  final double? innerPadding;
  final double? countFontSize;
  final String? notificationLabel;
  final int? notificationCount;
  final Color? notificationColor;

  const TransactionCard({
    Key? key,
    required this.title,
    required this.count,
    required this.subtitle,
    this.color,
    this.icon,
    this.percentage,
    this.statusColor,
    this.suffixChart,
    this.isLoading = false,
    this.prefixChart,
    this.innerPadding,
    this.countFontSize,
    this.notificationLabel,
    this.notificationCount,
    this.notificationColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer(
          isLoading: isLoading,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            width: Get.width * 0.28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppConst.isLightTheme(context)
                      ? greyLightColor3
                      : greyDarkColor1),
              color: AppConst.isLightTheme(context) ? whiteColor : bgDarkColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: color ??
                            (AppConst.isLightTheme(context)
                                ? blueJNE
                                : warningColor),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              color: statusColor ?? whiteColor, size: 6),
                          const SizedBox(width: 5),
                          Text(
                            title,
                            style: const TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 7),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: innerPadding ?? 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    prefixChart ?? const SizedBox(),
                    prefixChart != null ? const Spacer() : const SizedBox(),
                    Text(
                      count.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: countFontSize ?? 22),
                    ),
                    suffixChart != null ? const Spacer() : const SizedBox(),
                    suffixChart ?? const SizedBox(),
                  ],
                ),
                SizedBox(height: innerPadding ?? 13),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 8),
                ),
              ],
            ),
          ),
        ),
        (notificationLabel?.isNotEmpty ?? false)
            ? Shimmer(
                isLoading: isLoading,
                child: Container(
                  width: Get.width * 0.28,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: primaryColor(context),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppConst.isLightTheme(context)
                              ? greyLightColor3
                              : greyDarkColor1,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              width: Get.width * 0.21,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: notificationColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    notificationLabel ?? '',
                                    style: TextStyle(
                                        color: AppConst.isLightTheme(context)
                                            ? blueJNE
                                            : warningColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 7),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                              color: AppConst.isLightTheme(context)
                                  ? whiteColor
                                  : whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 9),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
