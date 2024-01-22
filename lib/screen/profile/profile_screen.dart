import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/custombottombar.dart';
import 'package:css_mobile/widgets/profile/account_card.dart';
import 'package:css_mobile/widgets/profile/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: whiteColor,
              title: Text("Profil".tr, style: appTitleTextStyle.copyWith(color: blueJNE)),
              leading: CustomBackButton(
                onPressed: () => Get.off(const DashboardScreen()),
              ),
            ),
            body: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: greyLightColor3, width: 5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const UserInfoCard(),
                      SvgPicture.asset(IconsConstant.edit),
                    ],
                  ),
                ),
                Column(
                    children: controller.profilList
                        .mapIndexed(
                          (i, e) => Container(
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: greyLightColor3, width: 5))),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(e.leading.toString()),
                                  title: Text(
                                    e.title ?? '',
                                    style: listTitleTextStyle.copyWith(color: blueJNE),
                                  ),
                                  trailing: Transform.flip(flipY: e.isShow ?? true, child: SvgPicture.asset(IconsConstant.arrowChevron)),
                                  onTap: () {
                                    e.isShow = e.isShow == false ? true : false;
                                    controller.update();
                                  },
                                ),
                                i == 0
                                    ? e.isShow!
                                        ? const Column(
                                            children: [
                                              AccountCard(),
                                            ],
                                          )
                                        : const SizedBox()
                                    : i == 1
                                        ? e.isShow!
                                            ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Nama Toko / Perusahaan", style: subTitleTextStyle),
                                                Text("Nama Lengkap", style: subTitleTextStyle),
                                                Text("Nomor Identitas / KTP", style: subTitleTextStyle),
                                                Text("Alamat Lengkap", style: subTitleTextStyle),
                                                Text("Provinsi", style: subTitleTextStyle),
                                                Text("Kota / Kabupaten", style: subTitleTextStyle),
                                                Text("Kecamatan", style: subTitleTextStyle),
                                                Text("Kelurahan", style: subTitleTextStyle),
                                                Text("Kode Pos", style: subTitleTextStyle),
                                                Text("Nomor Telepon", style: subTitleTextStyle),
                                                Text("Nomor Whatsapp", style: subTitleTextStyle),
                                                Text("Alamat Email", style: subTitleTextStyle),
                                              ],
                                            )
                                            : const SizedBox()
                                        : const SizedBox()
                              ],
                            ),
                          ),
                        )
                        .toList()),
                ListTile(
                  leading: const Icon(Icons.account_box, color: blueJNE, size: 30),
                  title: Text('Keluar'.tr, style: listTitleTextStyle.copyWith(color: blueJNE)),
                  trailing: const Icon(Icons.logout, color: redJNE, size: 25),
                  onTap: () => controller.doLogout(),
                ),
              ],
            ),
            bottomNavigationBar: const BottomBar(
              menu: 1,
            ),
          );
        });
  }
}
