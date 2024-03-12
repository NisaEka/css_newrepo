import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class PetugasListItem extends StatelessWidget {
  final int index;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget icon;
  final void Function(BuildContext)? onDelete;

  const PetugasListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.icon,
    required this.index,
    this.onDelete,
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: icon,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: listTitleTextStyle),
                Text(subtitle ?? '', style: sublistTitleTextStyle),
              ],
            )
          ],
        ),
      ),
    );
  }
}
