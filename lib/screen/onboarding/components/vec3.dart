import 'package:flutter/material.dart';

class Vec3 extends StatelessWidget {
  const Vec3({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
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
      392.5 * widthScaleFactor,
      179.5 * heightScaleFactor,
    );
    path_0.cubicTo(
      416.392 * widthScaleFactor,
      294.5 * heightScaleFactor,
      124.5 * widthScaleFactor,
      502.5 * heightScaleFactor,
      -243.5 * widthScaleFactor,
      484 * heightScaleFactor,
    );
    path_0.cubicTo(
      -592 * widthScaleFactor,
      436 * heightScaleFactor,
      -777 * widthScaleFactor,
      403.5 * heightScaleFactor,
      -817 * widthScaleFactor,
      191 * heightScaleFactor,
    );
    path_0.cubicTo(
      -806.5 * widthScaleFactor,
      41 * heightScaleFactor,
      -754.5 * widthScaleFactor,
      -71.2248 * heightScaleFactor,
      -445.003 * widthScaleFactor,
      55 * heightScaleFactor,
    );
    path_0.cubicTo(
      26.9978 * widthScaleFactor,
      247.5 * heightScaleFactor,
      326 * widthScaleFactor,
      -140.591 * heightScaleFactor,
      392.5 * widthScaleFactor,
      179.5 * heightScaleFactor,
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
