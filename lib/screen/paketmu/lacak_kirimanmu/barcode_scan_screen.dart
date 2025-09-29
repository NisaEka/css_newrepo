import 'dart:math' as math;
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen>
    with SingleTickerProviderStateMixin {
  String _scanBarcode = 'Unknown';
  late final bool cekResi;

  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool _handled = false;

  late final AnimationController _anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100))
    ..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    cekResi = Get.arguments?['cek_resi'] ?? false;
    scanBarcodeNormal();
  }

  Future<void> scanBarcodeNormal() async {
    try {
      await _controller.start();
    } catch (_) {}
  }

  void _handleScanCancelled() async {
    setState(() {
      _scanBarcode = "Scan canceled";
    });
    await _controller.stop();
    if (cekResi) {
      Get.off(() => const LacakKirimanScreen(), arguments: {});
    } else {
      Get.back();
    }
  }

  void _handleScanResult(String barcode) async {
    final upperBarcode = barcode.toUpperCase();

    if (!mounted) return;
    setState(() {
      _scanBarcode = upperBarcode;
    });

    if (upperBarcode.trim().isEmpty) {
      await _controller.stop();
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(Icons.warning, color: whiteColor),
          message: 'Nomor resi tidak boleh kosong'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
      return;
    }

    if (upperBarcode.length > 16) {
      await _controller.stop();
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(Icons.warning, color: whiteColor),
          message: 'Nomor resi maksimal 16 karakter'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
      return;
    }

    await _controller.stop();

    if (cekResi) {
      Get.off(() => const LacakKirimanScreen(),
          arguments: {'nomor_resi': upperBarcode});
    } else {
      Get.back(result: upperBarcode);
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: _handleScanCancelled,
          ),
          actions: [
            IconButton(
              tooltip: 'Toggle Flash',
              icon: const Icon(Icons.flash_on, color: Colors.white),
              onPressed: () => _controller.toggleTorch(),
            ),
            IconButton(
              tooltip: 'Switch Camera',
              icon: const Icon(Icons.cameraswitch, color: Colors.white),
              onPressed: () => _controller.switchCamera(),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            final boxSize = math.min(w * 0.75, 260.0);
            final left = (w - boxSize) / 2;
            final top = (h - boxSize) / 2.6;
            final scanRect = Rect.fromLTWH(left, top, boxSize, boxSize);

            const lineThickness = 3.0;

            return Stack(
              children: [
                MobileScanner(
                  controller: _controller,
                  scanWindow: scanRect,
                  onDetect: (BarcodeCapture capture) {
                    if (_handled) return;
                    final barcodes = capture.barcodes;
                    if (barcodes.isEmpty) return;

                    final raw = barcodes.first.rawValue;
                    if (raw == null || raw.isEmpty) return;

                    _handled = true;
                    _handleScanResult(raw);
                  },
                ),
                Positioned.fromRect(
                  rect: scanRect,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _anim,
                  builder: (_, __) {
                    final y = top + _anim.value * (boxSize - lineThickness);
                    return Positioned(
                      left: left + 10,
                      right: left + 10,
                      top: y,
                      child: Container(
                        height: lineThickness,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 24,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5), // 🔹 perbaiki
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Scan result: $_scanBarcode',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
