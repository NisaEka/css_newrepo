import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/add/add_dropshipper_screen.dart';
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
                  onPressed: () => Get.to(const AddDropshipperScreen(), arguments: {
                    'account': controller.account,
                  })?.then((value) => controller.initData()),
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
                  controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: controller.dropshipperList
                                .map((e) => ContactRadioListItem(
                                      groupValue: controller.dropshipperList,
                                      value: e,
                                      name: e.name,
                                      phone: e.phone,
                                      city: e.city,
                                      address: e.address,
                                      onChanged: (value) {
                              controller.selectedDropshipper = value as DropshipperModel?;
                              controller.update();
                              Get.back(result: controller.selectedDropshipper);
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
