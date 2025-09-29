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

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String _scanBarcode = 'Unknown';
  late final bool cekResi;

  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool _handled = false;

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
        body: Stack(
          children: [
            MobileScanner(
              controller: _controller,
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
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black..withValues(alpha: 0.5),
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
        ),
      ),
    );
  }
}
