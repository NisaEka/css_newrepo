import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

class InvoiceItem extends StatelessWidget {
  final bool isLoading;
  final Function(String)? onTap;
  final InvoiceModel? data;

  const InvoiceItem({
    super.key,
    this.isLoading = false,
    this.onTap,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: GestureDetector(
          onTap: (() => onTap?.call(data?.invoiceNoEncoded ?? '')),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: data?.invoiceStatus == "Posted"
                            ? successColor
                            : greyColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        data?.invoiceStatus ?? '',
                        style: sublistTitleTextStyle.copyWith(
                          color: whiteColor,
                          fontWeight: bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      data?.invoiceDate?.toShortDateFormat() ?? '-',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: primaryColor(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data?.invoiceNo ?? '-',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp ${data?.invoiceTotalAmount.toCurrency() ?? ''}",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: primaryColor(context)
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ]),
              ],
            ),
          )),
    );
  }
}
