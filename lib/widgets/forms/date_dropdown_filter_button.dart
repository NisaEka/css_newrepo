import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class DateDropdownFilterButton extends StatelessWidget {
  const DateDropdownFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: greyLightColor3, borderRadius: BorderRadius.circular(8)),
      child: const Row(
        children: [Text('1 Agt - 2 Agt'), Icon(Icons.arrow_drop_down)],
      ),
    );
  }
}
