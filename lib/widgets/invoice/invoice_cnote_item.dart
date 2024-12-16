import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';

class InvoiceCnoteItem extends StatelessWidget {
  final InvoiceCnoteModel invoice;
  final Function(String) onTap;

  const InvoiceCnoteItem({
    super.key,
    required this.invoice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (() => onTap(invoice.awbNumber ?? '')),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.awbNumber ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Rp ${invoice.originalAmountNumber?.toCurrency() ?? ''}",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (invoice.awbDate ?? '').toLongDateTimeFormat(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  invoice.consigneeName ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
