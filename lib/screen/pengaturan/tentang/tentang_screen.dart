import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_controller.dart';
import 'package:css_mobile/screen/pengaturan/tentang/lisensi_screen.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tentangscreen extends StatelessWidget {
  const Tentangscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanController>(
        init: PengaturanController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              backgroundColor: whiteColor,
              leading: CustomBackButton(
                onPressed: () => Get.back(),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('CSS Mobile',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        controller.version ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        ImageConstant.logoCSS,
                        height: 67,
                        color: CustomTheme().logoColor(context),
                      ),
                    ),
                    CustomFilledButton(
                      color:
                          AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                      onPressed: () {
                        Get.to(() => const LisensiScreen());
                      },
                      title: "Lisensi",
                      width: 100,
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
