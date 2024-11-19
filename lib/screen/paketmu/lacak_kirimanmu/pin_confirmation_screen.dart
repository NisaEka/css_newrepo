import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PinConfirmationScreen extends StatefulWidget {
  final String awb;
  final Function(String awb, String pin) cekResi;

  const PinConfirmationScreen(
      {Key? key, required this.awb, required this.cekResi})
      : super(key: key);

  @override
  PinConfirmationScreenState createState() => PinConfirmationScreenState();
}

class PinConfirmationScreenState extends State<PinConfirmationScreen> {
  late String _pin;

  @override
  void initState() {
    super.initState();
    _pin = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Nomor Telepon'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${'Untuk menjaga privasi pengguna, mohon masukkan empat digit terakhir nomor telepon pengirim atau penerima yang terkait dengan nomor resi'.tr}: ${widget.awb}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Pinput(
              length: 4,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (pin) {
                setState(() {
                  _pin = pin;
                });
              },
              onCompleted: (pin) {
                setState(() {
                  _pin = pin;
                });
                widget.cekResi(widget.awb, _pin).then((value) {
                  if (value.code == 200) {
                    Navigator.pop(context);
                  } else {
                    AppSnackBar.error(value.message);
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.cekResi(widget.awb, _pin).then((value) {
                  if (value.code == 200) {
                    Navigator.pop(context);
                  } else {
                    AppSnackBar.error(value.message);
                  }
                });
              },
              child: Text('Konfirmasi'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
