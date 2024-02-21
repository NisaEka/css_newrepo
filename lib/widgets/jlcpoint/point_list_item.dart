import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointListItem extends StatelessWidget {
  final Widget? item;
  final String dateTime;
  final double point;
  final String title;
  final String subtitle;
  final String? status;
  final String? amount;
  final String? rewards;

  const PointListItem({
    super.key,
    this.item,
    required this.dateTime,
    required this.point,
    required this.title,
    required this.subtitle,
    this.status,
    this.amount,
    this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      border: Border.all(color: blueJNE, width: 2),
                    ),
                    child: const Icon(
                      Icons.playlist_add_check_rounded,
                      color: blueJNE,
                    ),
                  ),
                  Text(dateTime),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: point > 0 ? successLightColor2 : errorLightColor2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${point < 1 ? point : point.toStringAsFixed(0)} ${'Poin'.tr}",
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
                      Row(
                        children: [
                          Text("$title   ".toUpperCase()),
                          Text(
                            subtitle,
                            style: listTitleTextStyle.copyWith(color: blueJNE),
                          ),
                        ],
                      ),
                      Text(
                        amount ?? '',
                        style: listTitleTextStyle,
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
                          ? Text(
                              "Jumlah Hadiah".tr.toUpperCase(),
                              style: listTitleTextStyle.copyWith(fontSize: 11),
                            )
                          : SizedBox(),
                ],
              ),
        ],
      ),
    );
  }
}
