import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDropshipper;
  final bool isOnline;
  final VoidCallback? onAdd;
  final String? title;

  const ContactAppbar({
    super.key,
    this.isDropshipper = true,
    this.isOnline = true,
    this.onAdd,
    this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      leading: const CustomBackButton(),
      title: Text(
        title ?? (isDropshipper ? 'Pilih Data Dropshipper'.tr : 'Pilih Data Penerima'.tr),
        style: appTitleTextStyle.copyWith(color: AppConst.isLightTheme(context) ? blueJNE : whiteColor),
      ),
      actions: [
        isOnline && (title?.isEmpty ?? true)
            ? IconButton(
                onPressed: onAdd,
                icon: Icon(
                  Icons.add,
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
