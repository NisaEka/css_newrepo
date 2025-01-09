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

class TentangScreen extends StatelessWidget {
  const TentangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanController>(
        init: PengaturanController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              backgroundColor: Colors.transparent,
              leading: CustomBackButton(
                onPressed: () => Get.back(),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.logoCSS,
                      width: Get.width - 100,
                      color: primaryColor(context),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'By ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Image.asset(
                          ImageConstant.logoJNE,
                          width: 50,
                          color:
                              AppConst.isDarkTheme(context) ? whiteColor : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.copyright_rounded),
                        Text(
                          '2024',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.version ?? '',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      isTransparent: true,
                      color: primaryColor(context),
                      onPressed: () {
                        Get.to(() => const LisensiScreen());
                      },
                      title: "Attribution License".tr,
                      suffixIcon: Icons.info_rounded,
                      width: Get.width / 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
