import 'package:flutter/material.dart';

class Vec1 extends StatelessWidget {
  const Vec1({super.key});

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
      // 1234.5, 172.145
      1234.5 * widthScaleFactor,
      172.145 * heightScaleFactor,
    );
    path_0.cubicTo(
      // 1234.5, 297.975, 941.501, 502.145, 573.5, 483.645
      1234.5 * widthScaleFactor,
      297.975 * heightScaleFactor,
      941.501 * widthScaleFactor,
      502.145 * heightScaleFactor,
      573.5 * widthScaleFactor,
      483.645 * heightScaleFactor,
    );
    path_0.cubicTo(
        // 225, 435.645, 53.0004, 412, 13.0004, 199.5
        225 * widthScaleFactor,
        435.645 * heightScaleFactor,
        53.0004 * widthScaleFactor,
        412 * heightScaleFactor,
        13.0004 * widthScaleFactor,
        199.5 * heightScaleFactor);
    path_0.cubicTo(
      // 6.50123, 45.5, 62.5003, -71.5794, 371.998, 54.6454
      6.50123 * widthScaleFactor,
      45.5 * heightScaleFactor,
      62.5003 * widthScaleFactor,
      -71.5794 * heightScaleFactor,
      371.998 * widthScaleFactor,
      54.6454 * heightScaleFactor,
    );
    path_0.cubicTo(
      // 843.998, 247.145, 1168, -147.946, 1234.5, 172.145
      843.998 * widthScaleFactor,
      247.145 * heightScaleFactor,
      1168 * widthScaleFactor,
      -147.946 * heightScaleFactor,
      1234.5 * widthScaleFactor,
      172.145 * heightScaleFactor,
    );
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
