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
  final Color color;
  final IconData? icon;
  final Color? statusColor;
  final Widget? chart;
  final bool isLoading;

  const TransactionCard({
    Key? key,
    required this.title,
    required this.count,
    required this.subtitle,
    required this.color,
    this.icon,
    this.percentage,
    this.statusColor,
    this.chart,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: blueJNE,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: statusColor, size: 6),
                      const SizedBox(width: 5),
                      Text(
                        title,
                        style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                chart ?? const SizedBox(),
              ],
            ),
            const SizedBox(height: 13),
            Text(
              subtitle,
              style:
                  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 6),
            ),
          ],
        ),
      ),
    );
  }
}
