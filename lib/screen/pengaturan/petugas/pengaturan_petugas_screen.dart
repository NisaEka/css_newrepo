import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/petugas_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PengaturanPetugasscreen extends StatelessWidget {
  const PengaturanPetugasscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBar(
        backgroundColor: whiteColor,
        title: 'Pengaturan Petugas'.tr,
        action: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: () => Get.to(const TambahPetugasScreen()),
            icon: const Icon(
              Icons.add,
              color: blueJNE,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomSearchField(
              hintText: 'Cari Data Petugas'.tr,
              prefixIcon: SvgPicture.asset(IconsConstant.search),
            ),
            const SizedBox(height: 21),
            Expanded(
              child: ListView(
                children: [
                  PetugasListItem(
                    icon: const Icon(
                      Icons.shield_outlined,
                      color: successColor,
                    ),
                    title: 'Logistik'.tr,
                    subtitle: 'logistic-everpro1@evermos.com\n085220891824\nBDO000 - BDO10000',
                  ),
                  PetugasListItem(
                    icon: const Icon(
                      Icons.shield_outlined,
                      color: errorColor,
                    ),
                    title: 'Logistik'.tr,
                    subtitle: 'logistic-everpro1@evermos.com\n085220891824\nBDO000 - BDO10000',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
