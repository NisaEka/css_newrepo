import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';

class BottomMenuItem extends StatelessWidget {
  final Widget icon;
  final String? title;
  final Color? color;
  final VoidCallback? onTap;

  const BottomMenuItem({super.key, required this.icon, this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            title?.isNotEmpty ?? false
                ? Text(
                    title ?? '',
                    style: TextStyle(color: color),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
