import 'package:flutter/material.dart';

class TitleTextItem extends StatelessWidget {
  final String title;
  final bool showDivider;

  const TitleTextItem(
      {super.key, required this.title, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.grey,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
