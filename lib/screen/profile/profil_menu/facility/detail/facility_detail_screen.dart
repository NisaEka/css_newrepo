import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/detail/facility_detail_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/detail/facility_detail_option_dialog.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class FacilityDetailScreen extends StatelessWidget {
  const FacilityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FacilityDetailController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomTopBar(title: controller.facilityArgs.name),
              bottomNavigationBar: _detailBottomAppBar(context, controller),
              body: _detailBody(controller, context));
        });
  }

  Widget? _detailBottomAppBar(
      BuildContext context, FacilityDetailController controller) {
    if (!controller.facilityArgs.canUse) {
      return null;
    }

    if (controller.facilityArgs.name == "Bayar Ongkir Nanti") {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {
                  if (controller.buttonEnabled) {
                    showDialog(
                      context: context,
                      builder: (context) => FacilityDetailOptionDialog(
                        facilityType:
                            "${controller.facilityArgs.name} (Mingguan)",
                      ),
                    );
                  }
                },
                child: Text(
                  "Mingguan".tr,
                  style: const TextStyle(color: whiteColor),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  if (controller.buttonEnabled) {
                    showDialog(
                      context: context,
                      builder: (context) => FacilityDetailOptionDialog(
                        facilityType:
                            "${controller.facilityArgs.name} (Bulanan)",
                      ),
                    );
                  }
                },
                child: Text(
                  "Bulanan".tr,
                  style: const TextStyle(color: whiteColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomFilledButton(
        color: controller.buttonEnabled ? redJNE : greyColor,
        title: controller.buttonText.tr,
        onPressed: () {
          if (controller.buttonEnabled) {
            showDialog(
                context: context,
                builder: (context) => FacilityDetailOptionDialog(
                    facilityType: controller.facilityArgs.name));
          }
        },
      ),
    );
  }

  Widget _detailBody(
      FacilityDetailController controller, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          sliver: SliverToBoxAdapter(
              child: Center(
                  child: SizedBox(
            width: 128,
            height: 128,
            child: Image(
                image: NetworkImage(controller.facilityArgs.icon),
                fit: BoxFit.cover),
          ))),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          sliver: SliverToBoxAdapter(
              child: Center(
            child: Text(
              'Skema Pembayaran'.tr,
              textAlign: TextAlign.center,
              style: appTitleTextStyle.copyWith(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
          )),
        ),
        SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
                child:
                    _descriptionSection(controller.facilityArgs.description)))
      ],
    );
  }

  Widget _descriptionSection(String facilityDescription) {
    return Html(
      data: facilityDescription,
      style: {
        'ul': Style(
            margin: Margins(left: Margin.zero()),
            padding: HtmlPaddings(left: HtmlPadding(16))),
        'h6': Style(fontSize: FontSize.large)
      },
    );
  }
}
