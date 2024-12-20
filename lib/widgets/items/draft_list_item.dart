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

  const DraftTransactionListItem({
    super.key,
    required this.data,
    this.onDelete,
    this.onValidate,
    required this.index,
  });

  @override
  State<DraftTransactionListItem> createState() =>
      _DraftTransactionListItemState();
}

class _DraftTransactionListItemState extends State<DraftTransactionListItem> {
  bool showDetail = false; // Moved the state to the State class

  void toggleDetail() {
    setState(() {
      showDetail = !showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDetail,
      child: Slidable(
        key: ValueKey(widget.index),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          dragDismissible: true,
          dismissible: DismissiblePane(
            onDismissed: widget.onDelete ?? () {},
          ),
          children: [
            SlidableAction(
              onPressed: (_) => widget.onDelete?.call(),
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
                padding: const EdgeInsets.only(
                    top: 5, right: 5, left: 20, bottom: 2),
                decoration: BoxDecoration(
                  color: widget.data.delivery?.freightCharge == 0
                      ? infoColor
                      : successColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  widget.data.delivery?.freightCharge == 0
                      ? 'Draft'
                      : 'Ready to Upload',
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
                    children: [
                      Text(
                        widget.data.createAt?.toDateTimeFormat() ?? '',
                        style: sublistTitleTextStyle,
                      ),
                      Icon(
                        showDetail
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        title: 'Account Number'.tr,
                        value: widget.data.dataAccount?.accountNumber ??
                            widget.data.account?.accountNumber ??
                            '',
                      ),
                      CustomLabelText(
                        title: 'Account Name'.tr,
                        value: widget.data.dataAccount?.accountName ??
                            widget.data.account?.accountName ??
                            '',
                        alignment: 'end',
                      ),
                    ],
                  ),
                  if (showDetail) ...[
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
                          width: Get.width * 0.4,
                          title: 'Origin'.tr,
                          value: widget.data.origin?.originName ?? '',
                          valueMaxline: 3,
                        ),
                        CustomLabelText(
                          alignment: 'end',
                          width: Get.width * 0.4,
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
                      color: primaryColor(context),
                      title: 'Validasi'.tr,
                      onPressed: widget.onValidate,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
