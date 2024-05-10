import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/detail/facility_detail_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/facility_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityScreen extends StatelessWidget {
  const FacilityScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FacilityController>(
      init: FacilityController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            title: "Fasilitasku".tr
          ),
          body: facilityBody(context, controller)
        );
      }
    );
  }

  Widget facilityBody(BuildContext context, FacilityController controller) {
    if (controller.showLoadingIndicator) {
      return const Center(
        child: CircularProgressIndicator()
      );
    }

    if (controller.showProhibitedContent) {
      return const Center(
        child: Text("Prohibited")
      );
    }

    if (controller.showMainContent) {
      return facilityMainContent(context, controller);
    }

    return const Center(
      child: Text("Error")
    );
  }

  Widget facilityMainContent(BuildContext context, FacilityController controller) {
    return Column(
      children: [
        Expanded(
            child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: SliverToBoxAdapter(
                        child: headerText(context, "COD / BAYAR DI TEMPAT")
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: facilityGrid(controller.codFacilities)
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.only(top: 32),
                      sliver: SliverToBoxAdapter(
                          child: headerText(context, "NON COD")
                      )
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      sliver: facilityGrid(controller.nonCodFacilities)
                  )
                ]
            )
        )
      ],
    );
  }

  Widget headerText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: appTitleTextStyle.copyWith(
                color: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : whiteColor
            )
        ),
      ),
    );
  }

  Widget facilityGrid(List<FacilityModel> facilities) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) =>
            FacilityItem(
              facility: facilities[index],
              onTap: () => Get.to(const FacilityDetailScreen(), arguments: {
                'facility': facilities[index]
              }),
            ), childCount: facilities.length
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.65
        )
    );
  }

}