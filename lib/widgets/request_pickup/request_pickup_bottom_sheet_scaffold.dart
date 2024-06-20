import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupBottomSheetScaffold extends StatelessWidget {

  final Widget content;
  final String title;

  const RequestPickupBottomSheetScaffold({
    super.key,
    required this.content,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.all(16),
              ),
              Expanded(child:Text(
                title.tr,
                style: listTitleTextStyle,
                textAlign: TextAlign.center,
              )),
              IconButton(
                onPressed: () { Get.back(); },
                icon: const Icon(Icons.close),
                alignment: Alignment.centerRight,
              )
            ],
          ),
          const Divider(
            height: 1,
            color: greyColor,
          ),
          content
        ],
      ),
    );
  }}