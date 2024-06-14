import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class DraftTransactionListItem extends StatefulWidget {
  final DataTransactionModel data;
  final VoidCallback? onDelete;
  final VoidCallback? onValidate;
  final int index;
  bool showDetail = false;

  DraftTransactionListItem({
    super.key,
    required this.data,
    this.onDelete,
    this.onValidate,
    required this.index,
  });

  @override
  State<DraftTransactionListItem> createState() => _DraftTransactionListItemState();
}

class _DraftTransactionListItemState extends State<DraftTransactionListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.showDetail = (widget.showDetail == true)
              ? false
              : (widget.showDetail == false)
                  ? true
                  : false;
        });
      },
      child: Slidable(
        key: ValueKey(widget.index),
        startActionPane: ActionPane(
          dragDismissible: true,
          dismissible: DismissiblePane(onDismissed: widget.onDelete ?? () {}),
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => widget.onDelete,
              backgroundColor: Colors.transparent,
              foregroundColor: errorColor,
              icon: Icons.delete,
              label: 'Hapus'.tr,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 5,
              child: Container(
                padding: const EdgeInsets.only(top: 5, right: 5, left: 20, bottom: 2),
                decoration: BoxDecoration(
                    color: widget.data.delivery?.freightCharge == 0 ? infoColor : successColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(20),
                    )),
                child: Text(
                  widget.data.delivery?.freightCharge == 0 ? 'Draft' : 'Ready to Upload',
                  style: listTitleTextStyle.copyWith(color: whiteColor),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: greyColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.data.createAt!.toDateTimeFormat().toString(), style: sublistTitleTextStyle),
                      !widget.showDetail ? const Icon(Icons.keyboard_arrow_down) : const Icon(Icons.keyboard_arrow_up),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        title: 'Account Number'.tr,
                        value: widget.data.dataAccount?.accountNumber ?? '',
                      ),
                      CustomLabelText(
                        title: 'Account Name'.tr,
                        value: widget.data.dataAccount?.accountName ?? '',
                        alignment: 'end',
                      ),
                    ],
                  ),
                  widget.showDetail
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomLabelText(
                                  title: 'Shipper'.tr,
                                  value: widget.data.shipper?.name ?? '',
                                ),
                                CustomLabelText(
                                  alignment: 'end',
                                  title: 'Receiver'.tr,
                                  value: widget.data.receiver?.name ?? '',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabelText(
                                  width: Get.width / 2,
                                  title: 'Origin'.tr,
                                  value: widget.data.origin?.originName ?? '',
                                  valueMaxline: 3,
                                ),
                                CustomLabelText(
                                  alignment: 'end',
                                  title: 'Destination'.tr,
                                  value: widget.data.dataDestination?.cityName ?? '',
                                  valueMaxline: 3,
                                ),
                              ],
                            ),
                            const Divider(),
                            CustomLabelText(
                              title: 'Nama Barang'.tr,
                              value: widget.data.goods?.desc ?? '',
                            ),
                            CustomFilledButton(
                              color: blueJNE,
                              title: 'Validasi'.tr,
                              onPressed: widget.onValidate,
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
