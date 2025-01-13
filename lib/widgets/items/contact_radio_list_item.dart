import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ContactRadioListItem extends StatelessWidget {
  final dynamic groupValue;
  final dynamic value;
  final void Function(dynamic)? onChanged;
  final bool isSelected;
  final String? name;
  final String? phone;
  final String? city;
  final String? address;
  final int index;
  final void Function(BuildContext)? onDelete;
  final bool isLoading;
  final VoidCallback? onTap;

  const ContactRadioListItem({
    super.key,
    required this.groupValue,
    required this.value,
    this.onChanged,
    this.isSelected = false,
    this.name,
    this.phone,
    this.city,
    this.address,
    required this.index,
    this.onDelete,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      startActionPane: ActionPane(
        dragDismissible: false,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.transparent,
            foregroundColor: errorColor,
            icon: Icons.delete,
            label: 'Hapus'.tr,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: Shimmer(
        isLoading: isLoading,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isLoading ? greyColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: isSelected ? secondaryColor(context) : greyColor),
            ),
            child: RadioListTile(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (states) => groupValue == value
                    ? primaryColor(context)
                    : secondaryColor(context),
              ),
              selectedTileColor: primaryColor(context),
              title: Text(name ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(
                '$phone \n$city \n$address',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
