import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';

import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class AccountListItem extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? accountType;
  final String? accountID;
  final VoidCallback? onTap;
  late bool isSelected;
  final int? index;
  final double? width;
  final bool isLoading;
  final Account? data;

  AccountListItem({
    super.key,
    this.accountNumber,
    this.accountName,
    this.accountType,
    this.onTap,
    this.isSelected = false,
    this.index,
    this.width,
    this.accountID,
    this.isLoading = false,
    this.data,
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
      child: Shimmer(
        isLoading: widget.isLoading,
        child: Container(
            width: widget.width ?? Get.width / 1.5,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.isLoading ? greyColor : Colors.transparent,
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
                      widget.data?.accountNumber ?? widget.accountNumber ?? '',
                      style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : redJNE),
                    ),
                    widget.isSelected
                        ? const Icon(Icons.check, color: successColor)
                        : const SizedBox()
                  ],
                ),
                Text(
                  "${widget.data?.accountName?.toUpperCase() ?? ''} / ${widget.data?.accountType ?? widget.data?.accountService}",
                  // widget.data?.accountName ?? widget.accountName ?? '',
                  style: sublistTitleTextStyle.copyWith(
                      color: AppConst.isLightTheme(context)
                          ? greyDarkColor2
                          : greyLightColor2),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.data?.accountType ??
                        widget.data?.accountService ??
                        widget.accountType ??
                        '',
                    style: sublistTitleTextStyle.copyWith(color: whiteColor),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
