import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/add/tambah_penerima_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/list_penerima_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPenerimaScreen extends StatelessWidget {
  const ListPenerimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPenerimaController>(
        init: ListPenerimaController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: whiteColor,
              elevation: 2,
              leading: const CustomBackButton(),
              title: Text(
                'Pilih Data Penerima'.tr,
                style: appTitleTextStyle.copyWith(color: blueJNE),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.to(const TambahPenerimaScreen()),
                  icon: const Icon(
                    Icons.add,
                    color: blueJNE,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  CustomSearchField(
                    hintText: 'Cari Data Penerima'.tr,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        });
  }
}
