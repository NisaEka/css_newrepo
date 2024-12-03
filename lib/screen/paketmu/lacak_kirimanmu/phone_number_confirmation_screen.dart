import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhoneNumberConfirmationScreen extends StatefulWidget {
  final String awb;
  final Function(String awb, String phoneNumber) cekResi;
  final bool isLoading;

  const PhoneNumberConfirmationScreen(
      {Key? key,
      required this.awb,
      required this.cekResi,
      required this.isLoading})
      : super(key: key);

  @override
  PhoneNumberConfirmationScreenState createState() =>
      PhoneNumberConfirmationScreenState();
}

class PhoneNumberConfirmationScreenState
    extends State<PhoneNumberConfirmationScreen> {
  late String _phoneNumber;
  late FocusNode _pinputFocusNode;

  @override
  void initState() {
    super.initState();
    _phoneNumber = '';
    _pinputFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pinputFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pinputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueJNE,
        title: Text('Verifikasi Nomor Telepon'.tr),
        centerTitle: true,
        titleTextStyle: appTitleTextStyle.copyWith(color: whiteColor),
        leading: const CustomBackButton(color: whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Text(
                'Mohon masukkan empat digit terakhir nomor telepon pengirim atau penerima'
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: CustomTheme().textColor(context),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.awb,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CustomTheme().textColor(context),
              ),
            ),
            const SizedBox(height: 40),
            Pinput(
              length: 4,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              focusNode: _pinputFocusNode,
              onChanged: (phoneNumber) {
                setState(() {
                  _phoneNumber = phoneNumber;
                });
              },
              onCompleted: (phoneNumber) {
                setState(() {
                  _phoneNumber = phoneNumber;
                });
                widget.cekResi(widget.awb, _phoneNumber).then((value) {
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
                if (!widget.isLoading) {
                  widget.cekResi(widget.awb, _phoneNumber).then((value) {
                    if (value.code == 200) {
                      Navigator.pop(context);
                    } else {
                      AppSnackBar.error(value.message);
                    }
                  });
                }
              },
              child: Text(
                'Konfirmasi'.tr,
                style: TextStyle(
                  color: CustomTheme().textColor(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
