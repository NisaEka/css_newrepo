import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String _scanBarcode = 'Unknown';
  late final bool cekResi;

  @override
  void initState() {
    super.initState();
    // Safely get the 'cek_resi' argument or default to false if it's not provided
    cekResi = Get.arguments['cek_resi'] ?? false;
    scanBarcodeNormal();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to scan barcode.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    if (barcodeScanRes == "-1") {
      // Handle scan cancellation
      _handleScanCancelled();
    } else {
      // Handle valid barcode scan
      _handleScanResult(barcodeScanRes);
    }
  }

  void _handleScanCancelled() {
    setState(() {
      _scanBarcode = "Scan canceled";
    });

    if (cekResi) {
      Get.off(const LacakKirimanScreen(), arguments: {});
    } else {
      Get.back();
    }
  }

  void _handleScanResult(String barcode) {
    if (cekResi) {
      Get.off(const LacakKirimanScreen(), arguments: {'nomor_resi': barcode});
    } else {
      Get.back(result: barcode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Scan result: $_scanBarcode',
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
