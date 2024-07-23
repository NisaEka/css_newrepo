import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporankuListItem extends StatelessWidget {
  final bool isLoading;

  const LaporankuListItem({
    super.key,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: const Icon(
                CupertinoIcons.chat_bubble_text,
                color: redJNE,
                size: 35,
              ),
            ),
            SizedBox(
              width: Get.width / 1.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CSS0221001862909",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateTime.now().toString().toShortDateTimeFormat(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Text(
                    "Permintaan Kirim Ulang",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Selesai'.tr,
                      style: sublistTitleTextStyle.copyWith(color: whiteColor, fontSize: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
