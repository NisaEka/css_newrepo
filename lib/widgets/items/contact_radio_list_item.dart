import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class ContactRadioListItem extends StatelessWidget {
  final dynamic groupValue;
  final dynamic value;
  final void Function(dynamic) onChanged;
  final bool isSelected;
  final String? name;
  final String? phone;
  final String? city;
  final String? address;

  const ContactRadioListItem({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.isSelected = false,
    this.name,
    this.phone,
    this.city,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: RadioListTile(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        shape: Border.all(color: isSelected ? redJNE : greyColor),
        selectedTileColor: redJNE,
        title: Text(name ?? '', style: listTitleTextStyle),
        subtitle: Text(
          '$phone \n$city \n$address',
          style: subTitleTextStyle,
        ),
      ),
    );
  }
}
