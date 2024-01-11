import 'package:css_mobile/widgets/bar/custombottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil".tr),
      ),
      bottomNavigationBar: BottomBar(
        menu: 1,
      ),
    );
  }
}
