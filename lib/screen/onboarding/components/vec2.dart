import 'package:flutter/material.dart';

class Vec2 extends StatelessWidget {
  const Vec2({super.key});

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
      // size: Size(Get.width, Get.width),
      // painter: RPSCustomPainter(),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: RPSCustomPainter(scaleWidth: 3, scaleHeight: 1.0),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final double scaleWidth;
  final double scaleHeight;

  RPSCustomPainter({required this.scaleWidth, required this.scaleHeight});

  @override
  void paint(Canvas canvas, Size size) {
    double scaledWidth = size.width * scaleWidth;
    double scaledHeight = size.height * scaleHeight;

    double widthScaleFactor = scaledWidth / 1234.5;
    double heightScaleFactor = scaledHeight / 483.645;

    Path path_0 = Path();
    path_0.moveTo(
      824.5 * widthScaleFactor,
      172.145 * heightScaleFactor,
    );
    path_0.cubicTo(
      824.5 * widthScaleFactor,
      297.976 * heightScaleFactor,
      531.5 * widthScaleFactor,
      502.145 * heightScaleFactor,
      163.5 * widthScaleFactor,
      483.645 * heightScaleFactor,
    );
    path_0.cubicTo(
      -185 * widthScaleFactor,
      435.645 * heightScaleFactor,
      -370 * widthScaleFactor,
      403.145 * heightScaleFactor,
      -410 * widthScaleFactor,
      190.645 * heightScaleFactor,
    );
    path_0.cubicTo(
      -399.5 * widthScaleFactor,
      40.6454 * heightScaleFactor,
      -347.5 * widthScaleFactor,
      -71.5795 * heightScaleFactor,
      -38.0029 * widthScaleFactor,
      54.6454 * heightScaleFactor,
    );
    path_0.cubicTo(
      433.998 * widthScaleFactor,
      247.145 * heightScaleFactor,
      758 * widthScaleFactor,
      -147.946 * heightScaleFactor,
      824.5 * widthScaleFactor,
      172.145 * heightScaleFactor,
    );
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffFB4141).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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
