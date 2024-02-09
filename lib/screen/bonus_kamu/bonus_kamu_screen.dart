import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/jlcpoint/jlcpoint_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BonusKamuScreen extends StatelessWidget {
  const BonusKamuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BonusKamuController>(
        init: BonusKamuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Bonus Kamu'.tr,
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: const Column(
                  children: [
                    JlcPointBox()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
