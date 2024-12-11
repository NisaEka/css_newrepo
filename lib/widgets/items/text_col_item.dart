import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextColItem extends StatelessWidget {
  final String title;
  final String? value;
  final bool lastItem;
  final bool isLoading;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const TextColItem(
      {super.key,
      required this.title,
      required this.value,
      this.lastItem = false,
      this.isLoading = false,
      this.titleStyle,
      this.valueStyle});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Spread the columns
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // Ensures that the title takes up only as much space as it needs
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              color: isLoading ? greyColor : Colors.transparent,
              child: Text(
                title.tr,
                style: titleStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // Makes the value take the rest of the space in the row
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              color: isLoading ? greyColor : Colors.transparent,
              child: Text(
                value ?? '',
                style: valueStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
                textAlign: TextAlign.start, // Align the value to the right
              ),
            ),
          ),
        ),
      ],
    );
  }
}
