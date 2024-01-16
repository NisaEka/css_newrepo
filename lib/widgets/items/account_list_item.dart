import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatefulWidget {
  final String accountNumber;
  final String accountName;
  final String accountType;
  final VoidCallback? onTap;
  late bool isSelected;
  final int? index;

  AccountListItem({
    super.key,
    required this.accountNumber,
    required this.accountName,
    required this.accountType,
    this.onTap,
    this.isSelected = false,
    this.index,
  });

  @override
  State<AccountListItem> createState() => _AccountListItemState();
}

class _AccountListItemState extends State<AccountListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ??
          () => setState(() {
                widget.isSelected = widget.isSelected == false ? true : false;
              }),
      child: Container(
          width: 180,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: widget.isSelected ? redJNE : greyColor,
              width: widget.isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.accountNumber,
                    style: listTitleTextStyle.copyWith(color: blueJNE),
                  ),
                  widget.isSelected ? const Icon(Icons.check, color: successColor) : SizedBox()
                ],
              ),
              Text(
                widget.accountName,
                style: sublistTitleTextStyle,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.accountType,
                  style: sublistTitleTextStyle.copyWith(color: whiteColor),
                ),
              )
            ],
          )),
    );
  }
}
