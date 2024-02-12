import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/data_umum_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/items/data_umum_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUmumScreen extends StatelessWidget {
  const DataUmumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataUmumController>(
        init: DataUmumController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              backgroundColor: whiteColor,
              title: 'Data Umum'.tr,
              action: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        enableDrag: true,
                        isDismissible: true,
                        // isScrollControlled: true,
                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kerahasiaan Data'.tr,
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomFormLabel(label: 'kerahasiaan_data'.tr),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info_rounded, color: redJNE),
                    tooltip: 'informasi'.tr,
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ListView(
                    children: [
                      DataUmumListItem(
                        title: controller.ccrfProfil?.generalInfo?.brand ?? '-',
                        subtitle: controller.ccrfProfil?.generalInfo?.email ?? '-',
                        icon: Icons.store_mall_directory_rounded,
                      ),
                      DataUmumListItem(
                        title: controller.ccrfProfil?.generalInfo?.name ?? '-',
                        subtitle: controller.ccrfProfil?.generalInfo?.idCardNumber ?? '-',
                        icon: Icons.person_pin_rounded,
                      ),
                      DataUmumListItem(
                        title: controller.ccrfProfil?.generalInfo?.secondaryPhone ?? controller.ccrfProfil?.generalInfo?.phone ?? '-',
                        subtitle: controller.ccrfProfil?.generalInfo?.phone ?? '-',
                        icon: Icons.contact_phone_rounded,
                      ),
                      DataUmumListItem(
                        title: controller.ccrfProfil?.generalInfo?.address ?? '-',
                        subtitle: controller.ccrfProfil?.generalInfo?.zipCode ?? '-',
                        icon: Icons.folder_zip_rounded,
                      ),
                      DataUmumListItem(
                        title: controller.ccrfProfil?.generalInfo?.district ?? '-',
                        subtitle: controller.ccrfProfil?.generalInfo?.subDistrict ?? '-',
                        icon: Icons.location_city_rounded,
                      ),
                      DataUmumListItem(
                        title: controller.ccrfProfil?.generalInfo?.city ?? '-',
                        subtitle: controller.ccrfProfil?.generalInfo?.province ?? '-',
                        icon: Icons.location_city_rounded,
                      )
                    ],
                  ),
                ),
                controller.isLoading ? const LoadingDialog() : Container(),
              ],
            ),
          );
        });
  }
}
