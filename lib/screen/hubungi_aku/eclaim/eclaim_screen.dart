import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/components/eclaim_items.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/components/eclaim_search_field.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/components/eclaim_status_button.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/eclaim_filter_button.dart';

class EclaimScreen extends StatelessWidget {
  const EclaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EclaimController>(
        init: EclaimController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'E-Claim'.tr,
              leading: CustomBackButton(
                onPressed: () =>
                    Get.delete<DashboardController>().then((_) => Get.back()),
              ),
              action: const [
                EclaimFilterButton(),
              ],
            ),
            body: const Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EclaimSearchField(),
                    EclaimStatusButton(),
                    EclaimItems(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
