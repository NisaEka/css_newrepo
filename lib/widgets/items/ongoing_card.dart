import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OngoingTransactionCard extends StatelessWidget {
  final String title;
  final double percentage;
  final int count;
  final String subtitle;
  final String? notificationLabel;
  final int? notificationCount;
  final bool isLoading;

  const OngoingTransactionCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.count,
    required this.subtitle,
    this.notificationLabel,
    this.notificationCount,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: Get.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppConst.isLightTheme(context)
                    ? greyLightColor3
                    : greyDarkColor1,
              ),
              color: AppConst.isLightTheme(context) ? whiteColor : bgDarkColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dalam Peninjauan
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: redJNE,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, color: whiteColor, size: 6),
                          const SizedBox(width: 5),
                          Text(
                            title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 7),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Circular Indicator
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.grey[300],
                        color: redJNE,
                        strokeWidth: 4,
                      ),
                    ),
                    const Spacer(),
                    Text('$count',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  style:
                  Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          (notificationLabel?.isNotEmpty ?? false)
              ? Container(
                  decoration: BoxDecoration(
                    color: AppConst.isLightTheme(context)
                        ? blueJNE
                        : warningColor,
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
                              // width: Get.width * 0.25,
                              child: Row(
                                children: [
                                  const Icon(Icons.circle,
                                      size: 8, color: Colors.orange),
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
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
