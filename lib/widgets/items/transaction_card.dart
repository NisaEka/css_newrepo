import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_mini_count.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionCard extends StatelessWidget {
  final String? title;
  final double? percentage;
  final String count;
  final String? countValue;
  final String? lineChartCountValue;
  final String subtitle;
  final Color? color;
  final IconData? icon;
  final Color? statusColor;
  final Widget? suffixChart;
  final Widget? prefixChart;
  final Widget? countValueChart;
  final bool isLoading;
  final double? innerPadding;
  final double? countFontSize;
  final String? notificationLabel;
  final int? notificationCount;
  final Color? notificationColor;
  final Widget? customTitle;
  final double? titleWidth;
  final double? height;
  final double? sizedBox;
  final VoidCallback? onTap;
  final VoidCallback? onTapNotification;

  const TransactionCard({
    Key? key,
    this.title,
    required this.count,
    required this.subtitle,
    this.color,
    this.icon,
    this.percentage,
    this.statusColor,
    this.suffixChart,
    this.isLoading = false,
    this.prefixChart,
    this.countValueChart,
    this.innerPadding,
    this.countFontSize,
    this.notificationLabel,
    this.notificationCount,
    this.notificationColor,
    this.customTitle,
    this.countValue,
    this.titleWidth,
    this.height,
    this.lineChartCountValue,
    this.onTap,
    this.onTapNotification,
    this.sizedBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Shimmer(
          isLoading: isLoading,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              width: screenWidth < 400 ? Get.width * 0.27 : Get.width * 0.28,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppConst.isLightTheme(context)
                        ? greyLightColor3
                        : greyDarkColor1),
                color:
                    AppConst.isLightTheme(context) ? whiteColor : bgDarkColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customTitle ??
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
                                SizedBox(
                                  width: titleWidth,
                                  child: Text(
                                    title ?? '',
                                    style: const TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ],
                  ),
                  count.toString().length >= 5
                      ? SizedBox(height: innerPadding ?? 17)
                      : SizedBox(height: innerPadding ?? 13),
                  lineChartCountValue != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              lineChartCountValue ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            countValueChart != null
                                ? const Spacer()
                                : const SizedBox(),
                            countValueChart ?? const SizedBox(),
                          ],
                        )
                      : const SizedBox(),
                  screenWidth < 400 || screenWidth >= 400 && screenWidth > 500
                      ? SizedBox(height: sizedBox)
                      : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      prefixChart ?? const SizedBox(),
                      prefixChart != null ? const Spacer() : const SizedBox(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: countValue,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: count.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: count.toString().length >= 5
                                          ? 16 - (count.toString().length - 5)
                                          : (countFontSize ?? 22)),
                            ),
                          ],
                        ),
                      ),
                      suffixChart != null ? const Spacer() : const SizedBox(),
                      suffixChart ?? const SizedBox(),
                    ],
                  ),
                  count.toString().length >= 5
                      ? SizedBox(height: innerPadding ?? 17)
                      : SizedBox(height: innerPadding ?? 13),
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
        ),
        (notificationLabel?.isNotEmpty ?? false)
            ? DashboardMiniCount(
                color: notificationColor,
                label: notificationLabel,
                value: notificationCount.toString(),
                isLoading: isLoading,
                onTap: onTapNotification,
              )
            : const SizedBox(),
      ],
    );
  }
}
