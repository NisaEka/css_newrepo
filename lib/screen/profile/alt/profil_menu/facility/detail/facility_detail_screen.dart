import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/detail/facility_detail_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/detail/facility_detail_option_dialog.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/info/facility_form_info_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityDetailScreen extends StatelessWidget {

  const FacilityDetailScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FacilityDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: controller.facilityArgs.name
            ),
            bottomNavigationBar:
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomFilledButton(
                    color: controller.buttonEnabled ? redJNE : greyColor,
                    title: controller.buttonText.tr,
                    onPressed: () {
                      if (controller.buttonEnabled) {
                        showDialog(
                            context: context,
                            builder: (context) => FacilityDetailOptionDialog(
                                facilityType: controller.facilityArgs.name
                            )
                        );
                      }
                    },
                  ),
              ),
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 24
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 128,
                        height: 128,
                        child: Image(
                            image: NetworkImage(controller.facilityArgs.icon),
                            fit: BoxFit.cover
                        ),
                      )
                    )
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                          controller.facilityArgs.name,
                        textAlign: TextAlign.center,
                        style: appTitleTextStyle.copyWith(
                          color: Colors.black
                        ),
                      ),
                    )
                  ),
                )
              ],
            )
          );
    });
  }

}