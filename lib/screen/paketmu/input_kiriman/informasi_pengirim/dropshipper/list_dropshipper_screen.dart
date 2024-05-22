import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/add/add_dropshipper_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/list_dropshipper_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:collection/collection.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              elevation: 2,
              leading: const CustomBackButton(),
              title: Text(
                'Pilih Data Dropshipper'.tr,
                style: appTitleTextStyle.copyWith(color: AppConst.isLightTheme(context) ? blueJNE : whiteColor),
              ),
              actions: [
                controller.isOnline
                    ? IconButton(
                        onPressed: () => Get.to(const AddDropshipperScreen(), arguments: {
                          'account': controller.account,
                        })?.then((value) => controller.initData()),
                        icon: Icon(
                          Icons.add,
                          color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  // !controller.isOnline ? const OfflineBar() : const SizedBox(),
                  CustomSearchField(
                    controller: controller.search,
                    hintText: 'Cari Data Dropshipper'.tr,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return newValue.copyWith(text: newValue.text.toUpperCase());
                      })
                    ],
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
                    ),
                    onChanged: (value) {
                      controller.searchDropshipper(value);
                    },
                    onClear: () {
                      controller.search.clear();
                      controller.initData();
                    },
                  ),
                  const SizedBox(height: 20),
                  controller.isLoading
                      ? Expanded(
                          child: ListView.builder(
                          itemBuilder: (context, i) => controller.dropshipperItem(DropshipperModel(), i, context),
                          itemCount: 5,
                        ))
                      : Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: controller.search.text.isNotEmpty
                                ? controller.searchResultList.isNotEmpty
                                    ? controller.searchResultList
                                        .mapIndexed(
                                          (i, e) => controller.dropshipperItem(e, i, context),
                                        )
                                        .toList()
                                    : [
                                        Center(
                                            child: DataEmpty(
                                          text: "Petugas Tidak Ditemukan".tr,
                                        ))
                                      ]
                                : controller.dropshipperList.isNotEmpty
                                    ? controller.dropshipperList
                                        .mapIndexed(
                                          (i, e) => controller.dropshipperItem(e, i, context),
                                        )
                                        .toList()
                                    : [const Center(child: DataEmpty())],
                          ),
                        )
                ],
              ),
            ),
          );
        });
  }
}
