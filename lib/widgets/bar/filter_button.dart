import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isFiltered;
  final bool isApplyFilter;
  final VoidCallback? onResetFilter;
  final VoidCallback? onApplyFilter;
  final Widget filterContent;
  final VoidCallback onCloseFilter;

  const FilterButton({
    super.key,
    this.onPressed,
    this.isFiltered = false,
    required this.onResetFilter,
    required this.filterContent,
    this.isApplyFilter = false,
    this.onApplyFilter,
    required this.onCloseFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: isFiltered ? redJNE : Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          Get.bottomSheet(
            enableDrag: true,
            isDismissible: false,
            // isScrollControlled: true,
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? greyLightColor2
                        : greyDarkColor2,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter',
                          style: appTitleTextStyle.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? blueJNE
                                    : warningColor,
                          ),
                        ),
                        IconButton(
                          onPressed: onCloseFilter,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    // const Divider(color: greyColor),
                    const SizedBox(height: 10),
                    filterContent,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isFiltered
                            ? CustomFilledButton(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? blueJNE
                                    : warningColor,
                                isTransparent: true,
                                fontColor: blueJNE,
                                borderColor: blueJNE,
                                width: Get.width / 2.5,
                                title: 'Reset Filter'.tr,
                                onPressed: onResetFilter,
                              )
                            : const SizedBox(),
                        CustomFilledButton(
                          color: Theme.of(context).brightness == Brightness.light
                              ? blueJNE
                              : warningColor,
                          width: isFiltered ? Get.width / 2.5 : Get.width - 40,
                          title: 'Terapkan'.tr,
                          onPressed: onApplyFilter,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
            backgroundColor: whiteColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
        icon: Icon(
          Icons.filter_list_rounded,
          color: isFiltered ? whiteColor : Colors.lightBlueAccent,
        ),
        color: isFiltered ? whiteColor : Colors.lightBlueAccent,
        tooltip: 'filter',
      ),
    );
  }
}
