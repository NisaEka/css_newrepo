import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DraftTransactionListItem extends StatelessWidget {
  final TransactionDataModel data;
  final VoidCallback? onDelete;
  final VoidCallback? onValidate;

  const DraftTransactionListItem({
    super.key,
    required this.data,
    this.onDelete,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Account ID'),
              Text(data.dataAccount?.accountId ?? '', style: listTitleTextStyle),
            ],
          ), Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Account Number'),
              Text(data.dataAccount?.accountNumber ?? '', style: listTitleTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Account Name'),
              Text(data.dataAccount?.accountName ?? '', style: listTitleTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Account Service'),
              Text(data.dataAccount?.accountService ?? '', style: listTitleTextStyle),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('nama barang'),
              Text(data.goods?.desc ?? '', style: listTitleTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('shipper'),
              Text(data.shipper?.name ?? '', style: listTitleTextStyle),
            ],
          ),
          Row(
            children: [
              CustomFilledButton(
                color: errorColor,
                title: 'Delete',
                width: Get.width / 5,
                onPressed: onDelete,
              ),
              CustomFilledButton(
                color: successColor,
                title: 'Validate',
                width: Get.width / 5,
                onPressed: onValidate,
              ),
            ],
          )
        ],
      ),
    );
  }
}
