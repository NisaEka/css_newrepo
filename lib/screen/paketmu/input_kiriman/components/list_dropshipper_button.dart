import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/dropshipper/list_dropshipper_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDropshipperButton extends StatelessWidget {
  const ListDropshipperButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipperController>(
        init: ShipperController(),
        builder: (c) {
          if (c.state.isDropshipper) {
            return GestureDetector(
              onTap: () => c.state.selectedAccount != null
                  ? Get.to(const ListDropshipperScreen(), arguments: {
                      'account': c.state.selectedAccount,
                    })?.then(
                      (result) {
                        c.state.dropshipper = result;
                        c.update();
                        c.getSelectedDropshipper();
                      },
                    )
                  : Get.showSnackbar(
                      GetSnackBar(
                        message: 'Pilih Account Terlebih dahulu'.tr,
                        backgroundColor: errorColor,
                        isDismissible: true,
                        duration: const Duration(seconds: 5),
                      ),
                    ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: greyColor, width: 2),
                      top: BorderSide(color: greyColor, width: 2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lihat Data Dropshipper'.tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: redJNE,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
