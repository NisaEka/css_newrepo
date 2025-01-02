import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SafetyTipsDialog extends StatelessWidget {
  final String? infoText;
  final VoidCallback? nextButton;
  final String? nextButtonTitle;

  const SafetyTipsDialog({
    super.key,
    this.infoText,
    this.nextButton,
    this.nextButtonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : bgDarkColor,
      title: Text(
        'TIPS AMAN MENGGUNAKAN CSS'.tr,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: regular, fontSize: 16),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBulletPoint(
                'Pastikan Anda hanya mengakses tautan CSS: http://css.jne.co.id.'
                    .tr,
                context,
                Icons.link),
            _buildBulletPoint(
                'Menjaga kerahasiaan informasi data Log In ID Pengguna, Kata Sandi, Kata Sandi Email, dan data kredensial lainnya.'
                    .tr,
                context,
                Icons.lock),
            _buildBulletPoint(
                'Hindari klik tautan mencurigakan dari Website, WhatsApp dengan alamat nomor yang tidak dikenal.'
                    .tr,
                context,
                Icons.warning),
            _buildBulletPoint(
                'Tidak menyimpan data kata sandi saat Log In dan pastikan melakukan Log Out setelah selesai menggunakan CSS.'
                    .tr,
                context,
                Icons.exit_to_app),
            _buildBulletPoint(
                'Amankan Komputer dan Jaringan yang digunakan dengan mengaktifkan Spam Blocker, menggunakan Antivirus, dan Konfigurasi Firewall.'
                    .tr,
                context,
                Icons.security),
            _buildBulletPoint(
                'Waspada terhadap email phishing, website phishing dan pastikan teliti serta validasi kembali transaksi anda.'
                    .tr,
                context,
                Icons.email),
            _buildBulletPoint(
                'Jangan pernah memberikan PIN/OTP/PASSWORD/PIN CSS/Kode OTP kepada siapapun. Pihak JNE tidak pernah meminta PIN/OTP/PASSWORD/PIN CSS/Kode OTP dari Customer.'
                    .tr,
                context,
                Icons.lock_open),
          ],
        ),
      ),
      actions: [
        CustomFilledButton(
          radius: 50,
          color: primaryColor(context),
          title: 'Saya telah membaca & memahami'.tr,
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text, BuildContext context, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Icon(icon, size: 16, color: Theme.of(context).iconTheme.color),
        ),
        const SizedBox(width: 8), // Space between bullet and text
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: regular, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
