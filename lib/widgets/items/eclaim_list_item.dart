import 'package:css_mobile/const/color_const.dart'; // Warna khusus aplikasi Anda
import 'package:flutter/material.dart';

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
                  color: blueJNE,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  claimType ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const Spacer(),
              Text(
                date ?? '',
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
                    color: isSuccess ? Colors.green : Colors.red,
                    size: 18,
                  ),
                  Text(
                    'Rp. ${amount?.toString() ?? '0'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSuccess ? Colors.green : Colors.red,
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
