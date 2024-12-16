import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingListItem extends StatelessWidget {
  final String? title;
  final IconData? leading;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isLoading;

  const SettingListItem({
    super.key,
    this.title,
    this.leading,
    this.onTap,
    this.trailing,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        margin: isLoading
            ? const EdgeInsets.symmetric(vertical: 5)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isLoading ? greyColor : Colors.transparent,
          borderRadius: isLoading ? BorderRadius.circular(8) : null,
        ),
        child: ListTile(
          leading: Icon(
            leading,
            size: 24,
            color: AppConst.isLightTheme(context) ? blueJNE : warningColor,
          ),
          title: Text(
            title?.tr ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          shape: Border(
            bottom: !isLoading
                ? const BorderSide(color: greyColor)
                : const BorderSide(color: Colors.transparent),
          ),
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          trailing: trailing,
        ),
      ),
    );
  }
}
