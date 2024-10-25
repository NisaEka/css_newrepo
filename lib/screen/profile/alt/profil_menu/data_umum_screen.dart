import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/data_umum_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/secret_data_dialog.dart';
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
            appBar: _appBarContent(context),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(DataUmumController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        children: c.isLoading
            ? List.generate(
                4,
                (index) => DataUmumListItem(
                  isLoading: c.isLoading,
                  title: "",
                  icon: Icons.account_circle,
                ),
              )
            : [
                DataUmumListItem(
                  title: c.ccrfProfil?.generalInfo?.ccrfBrand ?? '-',
                  subtitle: c.ccrfProfil?.generalInfo?.ccrfEmail ?? '-',
                  icon: Icons.store_mall_directory_rounded,
                  tooltip: '${'Nama Brand / Bisnis'.tr}\n${'Alamat email'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.generalInfo?.ccrfName ?? '-',
                  subtitle: c.ccrfProfil?.generalInfo?.ccrfKtp ?? '-',
                  icon: Icons.person,
                  tooltip:
                      '${'Nama Lengkap'.tr}\n${'Nomor Identitas / KTP'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.generalInfo?.ccrfPhone ??
                      c.ccrfProfil?.generalInfo?.ccrfHandphone ??
                      '-',
                  subtitle: c.ccrfProfil?.generalInfo?.ccrfHandphone ?? '-',
                  icon: Icons.phone,
                  tooltip: '${'No Telepon'.tr}\n${'Nomor Whatsapp'.tr}',
                ),
                DataUmumListItem(
                  title:
                      "${(c.ccrfProfil?.generalInfo?.ccrfAddress == null) ? ""
                          "" : "${c.ccrfProfil?.generalInfo?.ccrfAddress}, "}"
                      "${(c.ccrfProfil?.generalInfo?.ccrfSubdistrict == null) ? ""
                          "${c.basicProfil?.origin?.originName ?? ''}" : ""
                          ",  ${c.ccrfProfil?.generalInfo?.ccrfSubdistrict ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.ccrfDistrict == null) ? "" : ""
                          ", ${c.ccrfProfil?.generalInfo?.ccrfDistrict ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.ccrfCity == null) ? "" : ""
                          ", ${c.ccrfProfil?.generalInfo?.ccrfCity ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.ccrfProvince == null) ? "" : ""
                          ", ${c.ccrfProfil?.generalInfo?.ccrfProvince ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.ccrfZipcode == null) ? ""
                          "${(c.basicProfil?.zipCode) == null ? '' : ''
                              ', ${c.basicProfil?.zipCode}'}" : ""
                          ", ${c.ccrfProfil?.generalInfo?.ccrfZipcode ?? '-'}"}",
                  // subtitle: c.ccrfProfil?.generalInfo?.zipCode ?? '-',
                  icon: Icons.home,
                  tooltip: 'Alamat Lengkap'.tr,
                ),
                // DataUmumListItem(
                //   title: controller.ccrfProfil?.generalInfo?.district ?? '-',
                //   subtitle: controller.ccrfProfil?.generalInfo?.subDistrict ?? '-',
                //   icon: Icons.location_pin,
                // ),
                // DataUmumListItem(
                //   title: controller.ccrfProfil?.generalInfo?.city ?? '-',
                //   subtitle: controller.ccrfProfil?.generalInfo?.province ?? '-',
                //   icon: Icons.location_on,
                // ),
                // CustomFilledButton(color: blueJNE, title: "Edit Profil".tr,)
              ],
      ),
    );
  }

  CustomTopBar _appBarContent(BuildContext context) {
    return CustomTopBar(
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
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return SecretDataDialog(text: 'kerahasiaan_data'.tr);
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
