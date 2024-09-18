import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class LaporankuListItem extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final TicketModel? data;
  final int? index;

  const LaporankuListItem({
    super.key,
    this.isLoading = false,
    this.onTap,
    this.data,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Slidable(
        key: ValueKey(index ?? 0),
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => Get.to(const LacakKirimanScreen(), arguments: {
                'nomor_resi': data?.cnote ?? '',
              }),
              foregroundColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
              icon: Icons.search,
              label: 'Lacak'.tr,
            )
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Card(
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
                              data?.cnote ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              data?.createdAt?.toShortDateTimeFormat() ?? '-',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Text(
                          data?.category?.description ?? '-',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: data?.status == "Closed" ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            data?.status == "Closed" ? "Selesai".tr : "Masih Diproses".tr,
                            style: sublistTitleTextStyle.copyWith(color: whiteColor, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
