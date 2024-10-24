import 'package:css_mobile/screen/pantau_paketmu/components/pantau_count_item.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_card_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauCardScreen extends StatelessWidget {
  const PantauCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauCardController>(
        init: PantauCardController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Pantau Paketmu'.tr,
            ),
            body: RefreshIndicator(
              onRefresh: () => controller.loadPantauCountList(),
              child: SingleChildScrollView(
                child: controller.state.isLoading
                    ? const LoadingDialog()
                    : Column(
                        children: [
                          Column(
                              children: controller.state.pantauCountList

                                  .map((e) => PantauCountItem(
                                        data: e,
                                        type: 'COD',
                                      ))
                                  .toList()),
                          // Column(
                          //     children: controller.state.pantauCountList
                          //
                          //         .map((e) => PantauCountItem(
                          //               data: e,
                          //               type: 'NON COD',
                          //             ))
                          //         .toList()),
                          // Column(
                          //     children: controller.state.pantauCountList
                          //
                          //         .map((e) => PantauCountItem(
                          //               data: e,
                          //               type: 'COD ONGKIR',
                          //             ))
                          //         .toList()),
                        ],
                      ),
              ),
            ),
          );
        });
  }
}
