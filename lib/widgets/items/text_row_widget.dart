import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  final String title;
  final String? value;
  final bool isLoading;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const TextRowWidget({
    Key? key,
    required this.title,
    this.value,
    required this.isLoading,
    this.titleStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return Container();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer(
                isLoading: isLoading,
                child: Container(
                  decoration: BoxDecoration(
                      color: isLoading ? Colors.grey : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    title,
                    style: titleStyle ??
                        Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Shimmer(
                isLoading: isLoading,
                child: Container(
                  decoration: BoxDecoration(
                      color: isLoading ? Colors.grey : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    value!,
                    style: valueStyle ??
                        Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.normal),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
