import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupConfirmationDialog extends StatelessWidget {
  const RequestPickupConfirmationDialog({ super.key });

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
            "Apakah kamu sudah yakin untuk melakukan penjemputan di jam 14:30".tr,
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
                  onPressed: () { Get.back(); },
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
                  onPressed: () { Get.back(); },
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