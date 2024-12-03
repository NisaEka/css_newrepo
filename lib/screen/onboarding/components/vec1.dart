import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Vec1 extends StatelessWidget {
  const Vec1({super.key});

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
    path_0.moveTo(1234.5, 172.145);
    path_0.cubicTo(1234.5, 297.975, 941.501, 502.145, 573.5, 483.645);
    path_0.cubicTo(225, 435.645, 53.0004, 412, 13.0004, 199.5);
    path_0.cubicTo(6.50123, 45.5, 62.5003, -71.5794, 371.998, 54.6454);
    path_0.cubicTo(843.998, 247.145, 1168, -147.946, 1234.5, 172.145);
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
