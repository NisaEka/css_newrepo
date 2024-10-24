import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextColItem extends StatelessWidget {
  final String title;
  final String? value;
  final bool lastItem;

  const TextColItem(
      {super.key,
      required this.title,
      required this.value,
      this.lastItem = false});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return Container();
    }

    double paddingBottom = lastItem ? 0 : 16;

    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            value!,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
