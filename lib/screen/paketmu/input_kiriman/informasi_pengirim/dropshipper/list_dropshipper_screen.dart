import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/list_dropshipper_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/contact_radio_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDropshipperScreen extends StatelessWidget {
  const ListDropshipperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListDropshipperController>(
        init: ListDropshipperController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: whiteColor,
              elevation: 2,
              leading: const CustomBackButton(),
              title: Text(
                'Pilih Data Dropshipper'.tr,
                style: appTitleTextStyle.copyWith(color: blueJNE),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
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
                    hintText: 'Cari Data Dropshipper'.tr,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    child: Column(
                      children: controller.dropshipperList
                          .map((e) => ContactRadioListItem(
                                groupValue: controller.dropshipperList,
                                value: e,
                                onChanged: (value) {
                                  controller.selectedDropshipper = value;
                                  controller.update();
                                },
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
