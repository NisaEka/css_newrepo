import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageInfoDialog extends StatelessWidget {
  final String message;
  final Function onClickAction;

  const MessageInfoDialog(
      {super.key, required this.message, required this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.tr,
            style: sublistTitleTextStyle.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: () => onClickAction(),
                child: Text(
                  "OK".tr,
                  style: const TextStyle(color: whiteColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
