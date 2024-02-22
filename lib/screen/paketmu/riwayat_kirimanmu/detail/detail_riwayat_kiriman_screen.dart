import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanScreen extends StatelessWidget {
  const DetailRiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailRiwayatKirimanController>(
      init: DetailRiwayatKirimanController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar: CustomTopBar(
                title: 'Detail Kiriman'.tr,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    Text(controller.transactionModel?.status.toString() ?? ''),
                    Row(
                      children: [
                        Column(
                          children: [
                            CustomTextFormField(
                              controller: TextEditingController(text: controller.transactionModel?.status.toString()),
                              label: 'Status Transaksi'.tr,
                              width: Get.width / 2,
                              readOnly: true,
                              backgroundColor: greyLightColor3,
                            ),
                            CustomTextFormField(
                              controller: TextEditingController(text: controller.transactionModel?.pickupStatus.toString()),
                              label: 'Status Pickup'.tr,
                              width: Get.width / 2,
                              readOnly: true,
                              backgroundColor: greyLightColor3,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            controller.isLoading == true ? const LoadingDialog() : Container(),
          ],
        );
      },
    );
  }
}
