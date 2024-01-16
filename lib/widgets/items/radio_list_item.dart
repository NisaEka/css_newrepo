import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class RadioListItem extends StatelessWidget {
  final List groupValue;
  final String value;
  final void Function(dynamic) onChange;
  final bool isSelected;

  const RadioListItem({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChange,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: RadioListTile(
        value: value,
        groupValue: groupValue,
        onChanged: onChange,
        shape: Border.all(color: isSelected ? redJNE : greyColor),
        selectedTileColor: redJNE,
        title: Text('Arif Daryanto', style: listTitleTextStyle),
        subtitle: const Column(
          children: [],
        ),
      ),
    );
  }
}
