import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/add/add_penerima_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/list_penerima_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class ListPenerimaScreen extends StatelessWidget {
  const ListPenerimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPenerimaController>(
        init: ListPenerimaController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              leading: const CustomBackButton(),
              title: Text(
                'Pilih Data Penerima'.tr,
                style: appTitleTextStyle.copyWith(color: AppConst.isLightTheme(context) ? blueJNE : whiteColor),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.to(const AddPenerimaScreen()),
                  icon: Icon(
                    Icons.add,
                    color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  CustomSearchField(
                    controller: controller.search,
                    hintText: 'Cari Data Penerima'.tr,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
                    ),
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return newValue.copyWith(text: newValue.text.toUpperCase());
                      })
                    ],
                    onChanged: (value) {
                      controller.searchReceiver(value);
                    },
                    onClear: () {
                      controller.search.clear();
                      controller.initData();
                    },
                  ),
                  const SizedBox(height: 30),
                  controller.isLoading
                      ? Expanded(
                          child: ListView.builder(
                          itemBuilder: (context, i) => controller.receiverItem(ReceiverModel(), i, context),
                          itemCount: 5,
                        ))
                      : Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: controller.search.text.isNotEmpty
                                ? controller.searchResultList.isNotEmpty
                                    ? controller.searchResultList
                                        .mapIndexed(
                                          (i, e) => controller.receiverItem(e, i, context),
                                        )
                                        .toList()
                                    : [
                                        Center(
                                            child: DataEmpty(
                                          text: "Penerima Tidak Ditemukan".tr,
                                        ))
                                      ]
                                : controller.receiverList.isNotEmpty
                                    ? controller.receiverList
                                        .mapIndexed(
                                          (i, e) => controller.receiverItem(e, i, context),
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
