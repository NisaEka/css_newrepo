import 'package:css_mobile/screen/dashboard/menu/other_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherMenuScreen extends StatelessWidget {
  const OtherMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherMenuCotroller>(
      init: OtherMenuCotroller(),
      builder: (controller) {
        return Scaffold();
      },
    );
  }
}
