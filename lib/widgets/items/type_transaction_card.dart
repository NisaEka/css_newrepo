import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

class TypeTransactionCard extends StatelessWidget {
  final String count;
  final String? amount;
  final String description;
  final Color lineColor;
  final bool isLoading;

  const TypeTransactionCard({
    Key? key,
    required this.count,
    this.amount,
    required this.description,
    required this.lineColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 30,
              color: lineColor,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  amount ?? '',
                  style: TextStyle(
                    fontSize: 8,
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 8,
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
