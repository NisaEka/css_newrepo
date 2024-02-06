import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatKirimanController extends BaseController {
  int selectedKiriman = 0;
  DateTime? selectedDateFilter;
  String? selectedStatusKiriman;
  String? selectedPetugasEntry;

  bool isFiltered = false;

  List<String> listStatusKiriman = [
    "Masih Di Kamu",
    "Sudah Dijemput",
    "Dalam Perjalanan",
    "Sukses Diterima",
    "Sukses Dikembalikan",
  ];

  void showFilter() {
    isFiltered = isFiltered ? false : true;
    update();

    Get.bottomSheet(
      Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Bottom Sheet',
              style: TextStyle(fontSize: 18),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                selectedDateFilter != null || selectedStatusKiriman != null || selectedPetugasEntry != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            selectedDateFilter = null;
                            selectedPetugasEntry = null;
                            selectedStatusKiriman = null;
                          },
                          icon: const Icon(Icons.close_rounded),
                          color: blueJNE,
                        ),
                      )
                    : const SizedBox(),
                CustomFilledButton(
                  color: selectedDateFilter != null ? blueJNE : whiteColor,
                  title: 'Pilih Tanggal'.tr,
                  width: Get.width / 3,
                  fontColor: selectedDateFilter != null ? whiteColor : greyDarkColor1,
                  borderColor: greyDarkColor1,
                  fontStyle: subTitleTextStyle,
                  radius: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
                CustomFilledButton(
                  color: selectedStatusKiriman != null ? blueJNE : whiteColor,
                  title: 'Status Kiriman'.tr,
                  width: Get.width / 3,
                  fontColor: selectedStatusKiriman != null ? whiteColor : greyDarkColor1,
                  borderColor: greyDarkColor1,
                  fontStyle: subTitleTextStyle,
                  radius: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
                CustomFilledButton(
                  color: selectedPetugasEntry != null ? blueJNE : whiteColor,
                  title: 'Petugas Entry'.tr,
                  width: Get.width / 3,
                  fontColor: selectedPetugasEntry != null ? whiteColor : greyDarkColor1,
                  borderColor: greyDarkColor1,
                  fontStyle: subTitleTextStyle,
                  radius: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
