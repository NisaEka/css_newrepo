import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
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
    this.isSuccess=true,
    this.isLoading=false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.grey, // Warna garis pemisah
              thickness: 1.0, // Ketebalan garis
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: blueJNE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    claimType??'',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const Spacer(),
                Text(
                  date??'',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  awb??'',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
                      color: isSuccess ? Colors.green : Colors.red,
                      size: 18,
                    ),
                    Text(
                      amount??'',
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
      ),
    );
  }
}
