import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/alamat_return_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/data_umum_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/textstyle.dart';
import '../../../../../widgets/forms/customformlabel.dart';


class AlamatReturnScreen extends StatelessWidget {
  const AlamatReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlamatReturnController>(
        init: AlamatReturnController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              backgroundColor: whiteColor,
              title: 'Alamat Pengembalian'.tr,
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
                                      'Kerahasiaan Data',
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                      },
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
                                            CustomFormLabel(
                                                label:
                                                'Data ini dipergunakan dalam proses '
                                                    'pengembalian barang kiriman kamu. \n'
                                                    '\n'
                                                    'Informasi ini rahasia, '
                                                    'hanya kamu yang dapat melihatnya '
                                                    'dan tidak dibagikan ke pihak manapun'.tr),

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
                    icon: const Icon(Icons.info_rounded,
                    color: redJNE),
                    tooltip: 'informasi'.tr,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(
                children: [
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.responsibleName ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.npwpName ?? '-',
                    icon: Icons.person_pin,
                  ),
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.npwpType ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.npwpNumber ?? '-',
                    icon: Icons.credit_score_rounded,
                  ),
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.jlcNumber ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.counter ?? '-',
                    icon: Icons.card_membership_rounded,
                  ),
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.secondaryPhone ??
                        controller.ccrfProfil?.returnAddress?.phone ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.phone ?? '-',
                    icon: Icons.contact_phone_rounded,
                  ),
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.address ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.zipCode ?? '-',
                    icon: Icons.folder_zip_rounded,
                  ),
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.district ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.subDistrict ?? '-',
                    icon: Icons.location_city_rounded,
                  ),
                  DataUmumListItem(
                    title: controller.ccrfProfil?.returnAddress?.city ?? '-',
                    subtitle: controller.ccrfProfil?.returnAddress?.province ?? '-',
                    icon: Icons.location_city_rounded,
                  )
                ],
              ),
            ),
          );
        });
  }
}
