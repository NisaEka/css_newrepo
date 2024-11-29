import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OngoingTransactionCard extends StatelessWidget {
  final String title;
  final double percentage;
  final int count;
  final String subtitle;
  final String notificationLabel;
  final int notificationCount;

  const OngoingTransactionCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.count,
    required this.subtitle,
    required this.notificationLabel,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          width: Get.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyLightColor3),
            color: whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dalam Peninjauan
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: redJNE,
                      borderRadius: BorderRadius.circular(5),
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
                              fontSize: 6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              // Circular Indicator
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: percentage,
                      backgroundColor: Colors.grey[300],
                      color: redJNE,
                      strokeWidth: 4,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: greyDarkColor1, fontSize: 6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: greyLightColor3,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: blueJNE,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 8, right: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.circle,
                              size: 8, color: Colors.orange),
                          const SizedBox(width: 10),
                          Text(
                            notificationLabel,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 3, bottom: 3),
                child: Text(
                  '$notificationCount',
                  style: const TextStyle(
                      color: redJNE, fontWeight: FontWeight.bold, fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
