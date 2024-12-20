import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
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
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) =>
                  Get.to(() => const LacakKirimanScreen(), arguments: {
                'nomor_resi': data?.cnote ?? '',
              }),
              foregroundColor: primaryColor(context),
              icon: Icons.search,
              label: 'Lacak'.tr,
            )
          ],
        ),
        child: GestureDetector(
            onTap: onTap,
            child: Card(
                elevation: 0,
                child: Column(
                  children: [
                    // const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 160,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: data?.status == "Closed"
                                ? successColor
                                : data?.status == "Reply CS"
                                    ? warningColor
                                    : greyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            // data?.status ?? '',
                            data?.status == "Closed"
                                ? "Selesai".tr
                                : data?.status == "Reply CS"
                                    ? "Masih Diproses".tr
                                    : "Belum Diproses".tr,
                            style: sublistTitleTextStyle.copyWith(
                              color: whiteColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Text(
                          data?.createdDate?.toShortDateTimeFormat() ?? '-',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? blueJNE
                                      : warningColor),
                        ),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(
                        data?.cnote ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data?.category?.categoryDescription ?? '-',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terakhir Update: ${data?.updatedDate?.toLongDateTimeFormat() ?? '-'}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 9, fontStyle: FontStyle.italic),
                        ),
                        if (data?.isUnread == true)
                          const Icon(
                            Icons.message,
                            color: redJNE,
                            size: 20,
                          ),
                      ],
                    )
                  ],
                ))),
      ),
    );
  }
}
