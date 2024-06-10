import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class RiwayatKirimanListItem extends StatelessWidget {
  final String? tanggalEntry;
  final String? service;
  final String? noResi;
  final String? apiType;
  final String? penerima;
  final String? status;
  final String? orderID;
  final TransactionModel? data;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final int? index;
  final void Function(BuildContext)? onDelete;
  final bool isLoading;
  final bool isDelete;

  const RiwayatKirimanListItem({
    super.key,
    this.tanggalEntry,
    this.service,
    this.noResi,
    this.apiType,
    this.penerima,
    this.status,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.orderID,
    this.index,
    this.onDelete,
    this.isLoading = false,
    this.data,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index ?? 0),
      startActionPane: isDelete
          ? ActionPane(
              dragDismissible: false,
              // dismissible: DismissiblePane(onDismissed: onDelete ?? () {}),
              motion: const DrawerMotion(),
              children: [
                isDelete
                    ? SlidableAction(
                        onPressed: onDelete,
                        // backgroundColor: errorColor,
                        foregroundColor: errorColor,
                        icon: Icons.delete,
                        label: 'Hapus'.tr,
                        borderRadius: BorderRadius.circular(8),
                      )
                    : const SizedBox(),
              ],
            )
          : null,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? redJNE : greyDarkColor1,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Shimmer(
            isLoading: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: isLoading ? greyLightColor3 : Colors.transparent,
                      width: isLoading ? Get.width / 3 : null,
                      child: Text('Order ID : ${data?.orderId ?? orderID ?? ''}', style: sublistTitleTextStyle),
                    ),
                    Container(
                      color: isLoading ? greyLightColor3 : Colors.transparent,
                      width: isLoading ? Get.width / 5 : null,
                      child: Text(data?.createdDate?.toDateTimeFormat() ?? tanggalEntry?.toDateTimeFormat() ?? '', style: sublistTitleTextStyle),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: isLoading ? 50 : null,
                          decoration: BoxDecoration(
                            color: apiType == "COD" ? successColor : errorColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            data?.type ?? apiType ?? '',
                            style: sublistTitleTextStyle.copyWith(
                              color: whiteColor,
                              fontSize: 8,
                            ),
                          ),
                        ),
                        // Text(ImageConstant.paket),
                        // Image.asset(IconsConstant.paket),
                        CachedNetworkImage(
                          imageUrl: IconsConstant.paket,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: isLoading ? greyLightColor3 : Colors.transparent,
                          width: isLoading ? Get.width / 3 : null,
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(data?.awb ?? noResi ?? '', style: listTitleTextStyle),
                        ),
                        Container(
                          color: isLoading ? greyLightColor3 : Colors.transparent,
                          width: isLoading ? Get.width / 5 : null,
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(data?.receiver?.name ?? penerima ?? '', style: sublistTitleTextStyle),
                        ),
                        Container(
                          color: isLoading ? greyLightColor3 : Colors.transparent,
                          width: isLoading ? Get.width / 10 : null,
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(data?.service ?? service ?? '', style: sublistTitleTextStyle),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              margin: const EdgeInsets.only(bottom: 10),
                              width: isLoading ? Get.width / 5 : null,
                              decoration: BoxDecoration(
                                color: apiType == "MASIH DI KAMU" ? successLightColor2 : errorLightColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                data?.status?.tr ?? status?.tr ?? '',
                                style: sublistTitleTextStyle.copyWith(
                                  color: whiteColor,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
