import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/profil_menu/data_umum_controller.dart';
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
                  title: c.ccrfProfil?.generalInfo?.brand ?? '-',
                  icon: Icons.store_rounded,
                  tooltip: 'Nama Brand / Bisnis'.tr,
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.generalInfo?.email ?? '-',
                  subtitle: c.ccrfProfil?.generalInfo?.email ?? '-',
                  icon: Icons.alternate_email_rounded,
                  tooltip: '${'Nama Brand / Bisnis'.tr}\n${'Alamat email'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.generalInfo?.name ?? '-',
                  subtitle: c.ccrfProfil?.generalInfo?.ktp ?? '-',
                  icon: Icons.person_2_rounded,
                  tooltip:
                      '${'Nama Lengkap'.tr}\n${'Nomor Identitas / KTP'.tr}',
                ),
                DataUmumListItem(
                  title: c.ccrfProfil?.generalInfo?.phone ??
                      c.ccrfProfil?.generalInfo?.secondPhone ??
                      '-',
                  subtitle: c.ccrfProfil?.generalInfo?.secondPhone ?? '-',
                  icon: Icons.phone_rounded,
                  tooltip: '${'No Telepon'.tr}\n${'Nomor Whatsapp'.tr}',
                ),
                DataUmumListItem(
                  title: "${(c.ccrfProfil?.generalInfo?.address == null) ? ""
                          "" : "${c.ccrfProfil?.generalInfo?.address}, "}"
                      "${(c.ccrfProfil?.generalInfo?.subDistrict == null) ? ""
                          "${c.basicProfil?.origin?.originName ?? ''}" : ""
                          ",  ${c.ccrfProfil?.generalInfo?.subDistrict ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.district == null) ? "" : ""
                          ", ${c.ccrfProfil?.generalInfo?.district ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.city == null) ? "" : ""
                          ", ${c.ccrfProfil?.generalInfo?.city ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.province == null) ? "" : ""
                          ", ${c.ccrfProfil?.generalInfo?.province ?? '-'}"}"
                      "${(c.ccrfProfil?.generalInfo?.zipCode == null) ? ""
                          "${(c.basicProfil?.zipCode) == null ? '' : ''
                              ', ${c.basicProfil?.zipCode}'}" : ""
                          ", ${c.ccrfProfil?.generalInfo?.zipCode ?? '-'}"}",
                  icon: Icons.home_work_rounded,
                  tooltip: 'Alamat Lengkap'.tr,
                ),
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
            icon: Icon(Icons.info_rounded,
                color: Theme.of(context).brightness == Brightness.light
                    ? redJNE
                    : warningColor),
            tooltip: 'informasi'.tr,
          ),
        )
      ],
    );
  }
}
