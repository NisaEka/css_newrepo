import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class BottomMenuItem2 extends StatelessWidget {
  final IconData icon;
  final String? title;
  final Color? color;
  final VoidCallback? onTap;
  final bool isSelected;

  const BottomMenuItem2({
    super.key,
    required this.icon,
    this.title,
    this.color,
    this.onTap,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(
          left: isSelected ? 4 : 0,
          right: !isSelected ? 10 : 4,
        ),
        height: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? color : greyColor,
            ),
            (title?.isNotEmpty ?? false) && isSelected
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                        color: isSelected ? color : greyColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                    child: Text(
                      title ?? '',
                      style: const TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
