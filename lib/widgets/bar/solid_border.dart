import 'package:flutter/material.dart';

class SolidBorder extends StatelessWidget {
  final double? width;
  final double? height;
  const SolidBorder({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      width: width,
      color: Colors.black,
    );
  }
}
