import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:flutter/material.dart';

class InvoiceItem extends StatelessWidget {
  final InvoiceModel? invoice;
  final Function(String) onTap;

  const InvoiceItem({super.key, required this.invoice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (() => onTap(invoice?.invoiceNoEncoded ?? '')),
      child:  Container(
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
                  invoice?.invoiceNo ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Rp ${invoice?.invoiceTotalAmount.toCurrency() ?? ''}",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  invoice?.invoiceDate ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  invoice?.invoiceStatus ?? '',
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
