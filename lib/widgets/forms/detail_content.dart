import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class DetailContent extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const DetailContent({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: regular),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
