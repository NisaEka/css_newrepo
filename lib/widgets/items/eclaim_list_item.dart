import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EclaimListItem extends StatelessWidget {
  final String? claimType;
  final String? awb;
  final String? date;
  final String? amount;
  final bool isSuccess;
  final bool isLoading;

  const EclaimListItem({
    this.claimType,
    this.awb,
    this.date,
    this.amount,
    this.isSuccess = true,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 1.0,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: primaryColor(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  claimType ?? '',
                  style: const TextStyle(color: whiteColor, fontSize: 12),
                ),
              ),
              const Spacer(),
              Text(
                date?.toLongDateFormat() ?? '',
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                awb ?? '',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    isSuccess
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    color: isSuccess ? successColor : errorColor,
                    size: 18,
                  ),
                  Text(
                    'Rp. ${amount != null ? NumberFormat('#,##0', 'id').format(int.parse(amount!)) : '0'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSuccess ? successColor : errorColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
