import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/alamat_return_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/secret_data_dialog.dart';
import 'package:css_mobile/widgets/items/data_umum_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamatReturnScreen extends StatelessWidget {
  const AlamatReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlamatReturnController>(
        init: AlamatReturnController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(context),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(AlamatReturnController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        children: c.isLoading
            ? List.generate(
                5,
                (index) => DataUmumListItem(
                  isLoading: c.isLoading,
                  title: "",
                  icon: Icons.account_circle,
                ),
              )
            : [
                DataUmumListItem(
                  title:
                      c.ccrfProfil?.returnAddress?.responsibleName ??
                          '-',
                  subtitle: c.ccrfProfil?.returnAddress?.npwpName ?? '-',
                  icon: Icons.person_pin,
                  tooltip: '${'Nama Penanggung Jawab'.tr}\n${'Nama NPWP'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.returnAddress?.npwpType ?? '-',
                  subtitle: c.ccrfProfil?.returnAddress?.npwpNumber ?? '-',
                  icon: Icons.credit_score_rounded,
                  tooltip: '${'Jenis NPWP'.tr}\n${'Nomor NPWP'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.returnAddress?.jlcNumber ?? '-',
                  subtitle: c.ccrfProfil?.returnAddress?.counter ?? '-',
                  icon: Icons.card_membership_rounded,
                  tooltip:
                      '${'Nomor JLC'.tr}\n${'Nomor Counter Pengiriman'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.returnAddress?.secondPhone ??
                      c.ccrfProfil?.returnAddress?.phone ??
                      '-',
                  subtitle: c.ccrfProfil?.returnAddress?.phone ?? '-',
                  icon: Icons.contact_phone_rounded,
                  tooltip: '${'No Telepon'.tr}\n${'Nomor Whatsapp'.tr}',
                ),
                DataUmumListItem(
                  title:
                      "${c.ccrfProfil?.returnAddress?.address ?? '-'}"
                      ",  ${c.ccrfProfil?.returnAddress?.subDistrict ?? '-'}"
                      ", ${c.ccrfProfil?.returnAddress?.district ?? '-'}"
                      ", ${c.ccrfProfil?.returnAddress?.city ?? '-'}"
                      ", ${c.ccrfProfil?.returnAddress?.province ?? '-'}"
                      ", ${c.ccrfProfil?.returnAddress?.zipCode ?? '-'}",
                  // subtitle: controller.ccrfProfil?.generalInfo?.zipCode ?? '-',
                  icon: Icons.home,
                  tooltip: 'Alamat Lengkap'.tr,
                ),
                // DataUmumListItem(
                //   title: controller.ccrfProfil?.returnAddress?.district ?? '-',
                //   subtitle: controller.ccrfProfil?.returnAddress?.subDistrict ?? '-',
                //   icon: Icons.location_city_rounded,
                // ),
                // DataUmumListItem(
                //   title: controller.ccrfProfil?.returnAddress?.city ?? '-',
                //   subtitle: controller.ccrfProfil?.returnAddress?.province ?? '-',
                //   icon: Icons.location_city_rounded,
                // )
              ],
      ),
    );
  }

  CustomTopBar _appBarContent(BuildContext context) {
    return CustomTopBar(
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
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return SecretDataDialog(
                      text: '${'return_info'.tr}\n\n${'kerahasiaan_data'.tr}');
                }),
                backgroundColor:
                    AppConst.isLightTheme(context) ? whiteColor : greyColor,
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
    );
  }
}
