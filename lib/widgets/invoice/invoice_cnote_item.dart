import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

import '../../const/color_const.dart';

class InvoiceCnoteItem extends StatelessWidget {
  final bool isLoading;
  final InvoiceCnoteModel? invoice;
  final Function(String)? onTap;

  const InvoiceCnoteItem({
    super.key,
    this.isLoading = false,
    this.invoice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: (() => onTap?.call(invoice?.awbNumber ?? '')),
        child: Card(
          elevation: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(invoice?.awbNumber ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: primaryColor(context))),
                  Text(
                    invoice?.awbDate?.toLongDateTimeFormat() ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Rp ${invoice?.originalAmountNumber?.toCurrency() ?? ''}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: fourthColor(context)),
                ),
                Text(
                  invoice?.consigneeName ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
