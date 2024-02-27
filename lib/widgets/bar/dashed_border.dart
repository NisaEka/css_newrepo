import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashedBorder extends StatelessWidget {
  const DashedBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            Get.width ~/ 5,
            (_) => Container(
              width: 2,
                height: 1,
              color: Colors.black,
              margin: const EdgeInsets.only(left: 2, right: 2),
            ),
          ),
        ),
      ),
    );
  }
}
