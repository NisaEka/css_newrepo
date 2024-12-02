import 'package:css_mobile/const/color_const.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      width: Get.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyLightColor3),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 6),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              chart ?? const SizedBox(),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 6),
          ),
        ],
      ),
    );
  }
}
