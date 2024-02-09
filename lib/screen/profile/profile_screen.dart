import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/custombottombar.dart';
import 'package:css_mobile/widgets/items/document_image_item.dart';
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
                      UserInfoCard(
                        name: controller.basicProfil?.name ?? '-',
                        brand: controller.basicProfil?.brand ?? '-',
                        mail: controller.basicProfil?.email ?? '-',
                        type: controller.basicProfil?.userType?.capitalizeFirst ?? '-',
                      ),
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
                                    e.title?.tr ?? '-',
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
                                        ? Column(
                                            children: controller.accountList
                                                .mapIndexed(
                                                  (i, e) => AccountCard(account: e),
                                                )
                                                .toList(),
                                          )
                                        : const SizedBox()
                                    : i == 1
                                        ? e.isShow!
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Nama Toko / Perusahaan".tr, style: subTitleTextStyle),
                                                        Text("Nama Lengkap".tr, style: subTitleTextStyle),
                                                        Text("Nomor Identitas / KTP".tr, style: subTitleTextStyle),
                                                        Text("Alamat Lengkap".tr, style: subTitleTextStyle),
                                                        Text("Provinsi".tr, style: subTitleTextStyle),
                                                        Text("Kota / Kabupaten".tr, style: subTitleTextStyle),
                                                        Text("Kecamatan".tr, style: subTitleTextStyle),
                                                        Text("Kelurahan".tr, style: subTitleTextStyle),
                                                        Text("Kode Pos".tr, style: subTitleTextStyle),
                                                        Text("Nomor Telepon".tr, style: subTitleTextStyle),
                                                        Text("Nomor Whatsapp".tr, style: subTitleTextStyle),
                                                        Text("Alamat Email".tr, style: subTitleTextStyle),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.brand ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.name ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.idCardNumber ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.address ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.province ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.city ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.district ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.subDistrict ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.zipCode ?? '-',
                                                            style: listTitleTextStyle,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.phone ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.secondaryPhone ??
                                                                controller.ccrfProfil?.generalInfo?.phone ??
                                                                '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            controller.ccrfProfil?.generalInfo?.email ?? '-',
                                                            style: listTitleTextStyle,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : const SizedBox()
                                        : i == 2
                                            ? e.isShow!
                                                ? Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Alamat Pelanggan".tr, style: subTitleTextStyle),
                                                            Text("Provinsi".tr, style: subTitleTextStyle),
                                                            Text("Kota / Kabupaten".tr, style: subTitleTextStyle),
                                                            Text("Kecamatan".tr, style: subTitleTextStyle),
                                                            Text("Kelurahan".tr, style: subTitleTextStyle),
                                                            Text("Kode Pos".tr, style: subTitleTextStyle),
                                                            Text("No Telepon".tr, style: subTitleTextStyle),
                                                            Text("Nomor Whatsapp".tr, style: subTitleTextStyle),
                                                            Text("Nama Penanggung Jawab".tr, style: subTitleTextStyle),
                                                            Text("Nomor JLC".tr, style: subTitleTextStyle),
                                                            Text("Nama Counter Pengiriman".tr, style: subTitleTextStyle),
                                                            Text("Jenis NPWP".tr, style: subTitleTextStyle),
                                                            Text("Nama NPWP".tr, style: subTitleTextStyle),
                                                            Text("Nomor NPWP".tr, style: subTitleTextStyle),
                                                          ],
                                                        ),
                                                        const SizedBox(width: 10),
                                                        SizedBox(
                                                          width: Get.width / 2.5,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.address ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.province ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.city ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.district ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.subDistrict ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.zipCode ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.phone ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.secondaryPhone ??
                                                                    controller.ccrfProfil?.returnAddress?.phone ??
                                                                    '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.responsibleName ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.jlcNumber ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.counter ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.npwpType ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.npwpName ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                controller.ccrfProfil?.returnAddress?.npwpNumber ?? '-',
                                                                style: listTitleTextStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox()
                                            : i == 3
                                                ? e.isShow!
                                                    ? Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Nama Bank", style: subTitleTextStyle),
                                                                Text("No Rekening", style: subTitleTextStyle),
                                                                Text("Atas Nama", style: subTitleTextStyle),
                                                              ],
                                                            ),
                                                            const SizedBox(width: 10),
                                                            SizedBox(
                                                              width: Get.width / 2.5,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    controller.ccrfProfil?.bankAccount?.account ?? '-',
                                                                    style: listTitleTextStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                  Text(
                                                                    controller.ccrfProfil?.bankAccount?.accountName ?? '-',
                                                                    style: listTitleTextStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                  Text(
                                                                    controller.ccrfProfil?.bankAccount?.accountNumber ?? '-',
                                                                    style: listTitleTextStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox()
                                                : i == 4
                                                    ? e.isShow!
                                                        ? Container(
                                                            alignment: Alignment.topLeft,
                                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              // mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Text("Foto Dokumen KTP", style: subTitleTextStyle),
                                                                DocumentImageItem(img: controller.ccrfProfil?.document?.idCard ?? ''),
                                                                Text("Foto Dokumen NPWP", style: subTitleTextStyle),
                                                                DocumentImageItem(img: controller.ccrfProfil?.document?.npwp ?? ''),
                                                                Text("Foto Dokumen Buku Rekening", style: subTitleTextStyle),
                                                                DocumentImageItem(img: controller.ccrfProfil?.document?.bankAccount ?? ''),
                                                              ],
                                                            ),
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
                  title: Text(controller.isLogin ? 'Keluar'.tr : 'Masuk'.tr, style: listTitleTextStyle.copyWith(color: blueJNE)),
                  trailing: Icon(controller.isLogin ? Icons.logout : Icons.login, color: redJNE, size: 25),
                  onTap: () => controller.isLogin ? controller.doLogout() : Get.to(const LoginScreen()),
                )
              ],
            ),
            bottomNavigationBar: BottomBar(
              menu: 1,
              isLogin: controller.isLogin,
            ),
          );
        });
  }
}
