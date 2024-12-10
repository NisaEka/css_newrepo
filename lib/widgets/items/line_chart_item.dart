import 'package:flutter/material.dart';

class LineChart extends CustomPainter {
  final List<double> data;
  final double maxValue; // Nilai maksimal pada Y-axis untuk normalisasi

  LineChart(this.data, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (data.isNotEmpty) {
      // Hitung skala untuk data (normalisasi)
      final double xStep =
          size.width / (data.length - 1); // Jarak antar titik di X-axis
      final double yScale = size.height / maxValue;

      // Mulai menggambar dari titik pertama
      path.moveTo(0, size.height - (data[0] * yScale)); // Data pertama

      // Iterasi setiap titik dan buat cubic bezier untuk menghubungkan titik
      for (int i = 1; i < data.length - 1; i++) {
        double x1 = i * xStep;
        double y1 = size.height - (data[i] * yScale);
        double x2 = (i + 1) * xStep;
        double y2 = size.height - (data[i + 1] * yScale);

        // Menambahkan cubic bezier curve
        double controlX = (x1 + x2) / 2;
        double controlY = (y1 + y2) / 2;
        path.quadraticBezierTo(x1, y1, controlX, controlY);
      }

      // Untuk titik terakhir, gunakan lineTo untuk menyambung
      double lastX = (data.length - 1) * xStep;
      double lastY = size.height - (data[data.length - 1] * yScale);
      path.lineTo(lastX, lastY);

      // Gambar path garis
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LineChartItem extends StatelessWidget {
  final List<double> data;

  const LineChartItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.reduce(
        (a, b) => a > b ? a : b); // Cari nilai maksimal untuk normalisasi
    final double normalizedMaxValue = maxValue == 0
        ? 1.0
        : maxValue.toDouble(); // Handle kondisi jika maxValue == 0

    return CustomPaint(
      size: const Size(200, 100), // Ukuran canvas (lebar x tinggi)
      painter: LineChart(data, normalizedMaxValue),
    );
  }
}
