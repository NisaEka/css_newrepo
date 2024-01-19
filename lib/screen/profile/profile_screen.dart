import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/profile_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/custombottombar.dart';
import 'package:css_mobile/widgets/profile/user_info_card.dart';
import 'package:flutter/material.dart';
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
              leading: const CustomBackButton(),
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
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_square,
                          color: redJNE,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.account_box, color: blueJNE, size: 30),
                  title: Text('Keluar'.tr, style: listTitleTextStyle),
                  trailing: IconButton(
                    icon: const Icon(Icons.logout, color: redJNE, size: 30),
                    onPressed: () => controller.doLogout(),
                  ),
                  onTap: () => controller.doLogout(),
                )
              ],
            ),
            bottomNavigationBar: const BottomBar(
              menu: 1,
            ),
          );
        });
  }
}
