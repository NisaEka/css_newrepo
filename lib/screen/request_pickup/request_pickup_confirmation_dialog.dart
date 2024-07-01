import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupConfirmationDialog extends StatelessWidget {

  final String pickupTime;
  final Function onConfirmAction;
  final Function onCancelAction;

  const RequestPickupConfirmationDialog({
    super.key,
    required this.pickupTime,
    required this.onConfirmAction,
    required this.onCancelAction
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Apakah kamu sudah yakin untuk melakukan penjemputan di jam $pickupTime".tr,
            style: sublistTitleTextStyle.copyWith(
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24,),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onCancelAction(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 1,
                      color: blueJNE
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  child: Text(
                    "Batal".tr,
                  )
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () => onConfirmAction(),
                  child: Text(
                    "Ya".tr,
                    style: const TextStyle(color: whiteColor),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}