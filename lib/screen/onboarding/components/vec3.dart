import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Vec3 extends StatelessWidget {
  const Vec3({super.key});

  @override
  Widget build(BuildContext context) {
    // return ClipPath(
    //   clipper: CustomShapeClipper(),
    //   child: Container(
    //     width: Get.width,
    //     height: Get.width + 250,
    //     color: Colors.red,
    //   ),
    // );
    return CustomPaint(
      size: Size(Get.width, Get.width),
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(392.5, 179.5);
    path_0.cubicTo(416.392, 294.5, 124.5, 502.5, -243.5, 484);
    path_0.cubicTo(-592, 436, -777, 403.5, -817, 191);
    path_0.cubicTo(-806.5, 41, -754.5, -71.2248, -445.003, 55);
    path_0.cubicTo(26.9978, 247.5, 326, -140.591, 392.5, 179.5);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffFB4141).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(702.906, 185.237);
    path_0.cubicTo(702.906, 305.083, 899.906, 588.239, 622.406, 486.239);
    path_0.cubicTo(502.007, 486.239, 54.0574, 438.239, 8.4059, 240.239);
    path_0.cubicTo(-34.5941, 53.7392, 93.6541, -43.8532, 250.112, 19.0854);
    path_0.cubicTo(470.112, 107.585, 514.112, 66.0854, 702.906, 185.237);
    path_0.close(); // Close the path
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
