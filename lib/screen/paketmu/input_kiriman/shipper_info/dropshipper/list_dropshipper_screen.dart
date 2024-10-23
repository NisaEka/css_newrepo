import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/dropshipper/add/add_dropshipper_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/dropshipper/list_dropshipper_controller.dart';
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
            appBar: _appBarContent(controller, context),
            body: _bodyContent(controller, context),
          );
        });
  }

  AppBar _appBarContent(ListDropshipperController c, BuildContext context) {
    return AppBar(
      elevation: 2,
      leading: const CustomBackButton(),
      title: Text(
        'Pilih Data Dropshipper'.tr,
        style: appTitleTextStyle.copyWith(color: AppConst.isLightTheme(context) ? blueJNE : whiteColor),
      ),
      actions: [
        c.isOnline
            ? IconButton(
                onPressed: () => Get.to(const AddDropshipperScreen(), arguments: {
                  'account': c.account,
                })?.then((value) => c.initData()),
                icon: Icon(
                  Icons.add,
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              )
            : const SizedBox()
      ],
    );
  }

  Widget _bodyContent(ListDropshipperController c, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // !controller.isOnline ? const OfflineBar() : const SizedBox(),
          CustomSearchField(
            controller: c.search,
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
              c.initData();
            },
            onClear: () {
              c.search.clear();
              c.initData();
            },
          ),
          const SizedBox(height: 20),
          c.isLoading
              ? Expanded(
                  child: ListView.builder(
                  itemBuilder: (context, i) => c.dropshipperItem(DropshipperModel(), i, context),
                  itemCount: 5,
                ))
              : Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: c.dropshipperList.isNotEmpty
                        ? c.dropshipperList
                            .mapIndexed(
                              (i, e) => c.dropshipperItem(e, i, context),
                            )
                            .toList()
                        : [const Center(child: DataEmpty())],
                  ),
                )
        ],
      ),
    );
  }
}
