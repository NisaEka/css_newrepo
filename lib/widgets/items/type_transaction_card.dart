import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

class TypeTransactionCard extends StatelessWidget {
  final String value1;
  final String? value2;
  final String description;
  final Color lineColor;
  final bool isLoading;
  final String? prefixVal1;
  final String? prefixVal2;
  final String? suffixVal1;
  final String? suffixVal2;
  final double? width;
  final VoidCallback? onTap;

  const TypeTransactionCard({
    Key? key,
    required this.value1,
    this.value2,
    required this.description,
    required this.lineColor,
    this.isLoading = false,
    this.prefixVal1,
    this.prefixVal2,
    this.suffixVal1,
    this.suffixVal2,
    this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          width: width,
          decoration: BoxDecoration(
            color: isLoading ? greyColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 45,
                color: lineColor,
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${prefixVal1 ?? ''}$value1 ${suffixVal1 ?? ''} ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (value2?.isNotEmpty ?? false)
                        ? "${prefixVal2 ?? ''}$value2 ${suffixVal2 ?? ''} "
                        : "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
