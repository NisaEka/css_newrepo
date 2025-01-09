import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
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
      title: Column(
        children: [
          Image.asset(ImageConstant.logoCSS,
              height: 30, width: Get.width, color: primaryColor(context)),
          const SizedBox(height: 16),
          Text(
            'TIPS AMAN MENGGUNAKAN CSS'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: bold, fontSize: 16, color: primaryColor(context)),
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBulletPoint(
                  'Pastikan Anda hanya memasang aplikasi CSS Mobile dari playstore.'
                      .tr,
                  context,
                  Icons.link_rounded),
              const SizedBox(height: 5),
              _buildBulletPoint(
                  'Menjaga kerahasiaan informasi data Log In ID Pengguna, Kata Sandi, Kata Sandi Email, dan data kredensial lainnya.'
                      .tr,
                  context,
                  Icons.lock_rounded),
              const SizedBox(height: 5),
              _buildBulletPoint(
                  'Hindari klik tautan mencurigakan dari Website, WhatsApp dengan alamat nomor yang tidak dikenal.'
                      .tr,
                  context,
                  Icons.warning_rounded),
              const SizedBox(height: 5),
              _buildBulletPoint(
                  'Tidak menyimpan data kata sandi saat Log In dan pastikan melakukan Log Out setelah selesai menggunakan CSS.'
                      .tr,
                  context,
                  Icons.password_rounded),
              const SizedBox(height: 5),
              _buildBulletPoint(
                  'Amankan Komputer dan Jaringan yang digunakan dengan mengaktifkan Spam Blocker, menggunakan Antivirus, dan Konfigurasi Firewall.'
                      .tr,
                  context,
                  Icons.security_rounded),
              const SizedBox(height: 5),
              _buildBulletPoint(
                  'Waspada terhadap email phishing, website phishing dan pastikan teliti serta validasi kembali transaksi anda.'
                      .tr,
                  context,
                  Icons.email_rounded),
              const SizedBox(height: 5),
              _buildBulletPoint(
                  'Jangan pernah memberikan PIN/OTP/PASSWORD/PIN CSS/Kode OTP kepada siapapun. Pihak JNE tidak pernah meminta PIN/OTP/PASSWORD/PIN CSS/Kode OTP dari Customer.'
                      .tr,
                  context,
                  Icons.lock_person_rounded),
            ],
          ),
        ),
      ),
      actions: [
        CustomFilledButton(
          radius: 10,
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
          child: Icon(icon, size: 17, color: primaryColor(context)),
        ),
        const SizedBox(width: 20),
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
