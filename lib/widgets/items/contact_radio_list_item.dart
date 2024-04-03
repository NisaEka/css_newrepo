import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ContactRadioListItem extends StatelessWidget {
  final dynamic groupValue;
  final dynamic value;
  final void Function(dynamic) onChanged;
  final bool isSelected;
  final String? name;
  final String? phone;
  final String? city;
  final String? address;
  final int index;
  final void Function(BuildContext)? onDelete;
  final bool isLoading;

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
    required this.index,
    this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      startActionPane: ActionPane(
        dragDismissible: false,
        // dismissible: DismissiblePane(onDismissed: onDelete ?? () {}),
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            // backgroundColor: errorColor,
            foregroundColor: errorColor,
            icon: Icons.delete,
            label: 'Hapus'.tr,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: Shimmer(
        isLoading: isLoading,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isLoading ? greyColor : Colors.transparent,
          ),
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
        ),
      ),
    );
  }
}
