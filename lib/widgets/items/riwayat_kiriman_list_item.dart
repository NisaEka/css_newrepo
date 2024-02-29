import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class RiwayatKirimanListItem extends StatelessWidget {
  final String tanggalEntry;
  final String service;
  final String noResi;
  final String apiType;
  final String penerima;
  final String status;
  final String orderID;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final int index;
  final void Function(BuildContext)? onDelete;

  const RiwayatKirimanListItem({
    super.key,
    required this.tanggalEntry,
    required this.service,
    required this.noResi,
    required this.apiType,
    required this.penerima,
    required this.status,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    required this.orderID,
    required this.index, this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      startActionPane: ActionPane(
        dragDismissible: false,
        // dismissible: DismissiblePane(onDismissed: onDelete ?? () {}),
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            // backgroundColor: errorColor,
            foregroundColor: errorColor,
            icon: Icons.delete,
            label: 'Hapus'.tr,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order ID : $orderID', style: sublistTitleTextStyle),
                  Text(tanggalEntry, style: sublistTitleTextStyle),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: apiType == "COD" ? successColor : errorColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          apiType,
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
                      Text(noResi, style: listTitleTextStyle),
                      Text(penerima, style: sublistTitleTextStyle),
                      Text(service, style: sublistTitleTextStyle),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: apiType == "MASIH DI KAMU" ? successLightColor2 : errorLightColor2,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              status,
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
          // child: Column(
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           tanggalEntry.toLongDateFormat(),
          //           style: sublistTitleTextStyle,
          //         ),
          //         Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          //           decoration: BoxDecoration(
          //             color: errorColor,
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           child: Text(
          //             status,
          //             style: sublistTitleTextStyle.copyWith(
          //               color: whiteColor,
          //               fontSize: 8,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Order ID'.tr,
          //               style: sublistTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //             Text(
          //               'No Resi'.tr,
          //               style: sublistTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //             Text(
          //               'Petugas Entry'.tr,
          //               style: sublistTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //             Text(
          //               'Penerima'.tr,
          //               style: sublistTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(width: 10),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               ': $orderID',
          //               style: listTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //             Text(
          //               ': $noResi',
          //               style: listTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //             Text(
          //               ': $petugas',
          //               style: listTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //             Text(
          //               ': $penerima',
          //               style: listTitleTextStyle.copyWith(fontSize: 10),
          //             ),
          //           ],
          //         ),
          //       ],
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
